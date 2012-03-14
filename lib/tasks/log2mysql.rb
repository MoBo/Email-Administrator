#!/usr/local/bin/ruby
# convert Postfix log to MySQL
# $Id: pflog2mysql,v 1.14 2005/07/24 01:41:00 tommy Exp $
#
# Copyright (C) 2004 TOMITA Masahiro
# tommy@tmtm.org
# 
# Usage: pflog [option] log-filename...
#   -Y yyyy         set year
#   --mysql-server  MySQL server name
#   --mysql-user    MySQL user name
#   --mysql-passwd  MySQL password
#   --mysql-db      MySQL database name
#   -f              follow mode
#   --purge #       purge log # days ago
#   --debug         put unrecognized message 
# 

require "date"
require "mysql"
require "optconfig"

$incoming_fields = %w(server queue_id arrive_time hostname ipaddr uid user sender sdomain message_id size old)
$outgoing_fields = %w(id action_time recipient rdomain status relay delay info)

opt = OptConfig.new
opt.options = {
  ["f", "follow"] => nil,
  ["Y", "year"]   => /^\d+$/,
  "mysql-server"  => true,
  "mysql-user"    => true,
  "mysql-passwd"  => true,
  "mysql-db"      => true,
  "purge"         => /^\d+$/,
  "debug"         => nil,
}
opt.file = $0+".conf" if File.exist?($0+".conf")
begin
  n = opt.parse ARGV
  ARGV.slice! 0, n
rescue
  STDERR.puts $!.to_s
  STDERR.puts <<EOS
Usage: pflog2mysql [option] log-filename...
  option:
    -f, --follow         follow mode
    -Y, --year yyyy      set year
    --mysql-server host  MySQL server name
    --mysql-user name    MySQL user name
    --mysql-passwd pwd   MySQL password
    --mysql-db name      MySQL database name
    --purge n            purge log n days ago
    --debug              put unrecognized message
EOS
  exit 1
end

$year = opt["year"] ? opt["year"].to_i : nil
$follow = opt["follow"]
$debug = opt["debug"]

@m = Mysql.new(opt["mysql-server"], opt["mysql-user"], opt["mysql-passwd"], opt["mysql-db"])
class << @m
  def q(s)
    self.quote(s ? s.to_s : "")
  end
end

if opt["purge"] then
  delete_datetime = (Time.now - opt["purge"].to_i*24*60*60).strftime("%Y%m%d%H%M%S")
  sql = "delete from incoming,outgoing using incoming,outgoing where incoming.id=outgoing.id and action_time < '#{delete_datetime}'"
  @m.query sql
  sql = "delete from incoming where arrive_time < '#{delete_datetime}' and message_id is null"
  @m.query sql
end

def to_time(d)
  mon, day, hour, min, sec = d.split /\s+|:/
  mon = Date::ABBR_MONTHNAMES.index mon
  Time.local($year, mon, day.to_i, hour.to_i, min.to_i, sec.to_i)
end

def set_old(qid)
  @m.query("update incoming set old=1 where queue_id='#{@m.q qid}'")
end

def update_incoming(hash)
  hash["old"] = "0" unless hash.key? "old"
  s = hash.map{|k,v| $incoming_fields.include?(k) ? "#{k}='#{@m.q v}'" : nil}.compact.join(",")
  if hash.key?("id") and hash["id"] then
    @m.query("update incoming set #{s} where id='#{@m.q hash["id"]}'")
    id = hash["id"].to_i
  else
    @m.query("insert incoming set #{s}")
    id = @m.insert_id
  end
  id
end

def insert_outgoing(hash)
  var = []
  val = []
  hash.map do |k,v|
    if $outgoing_fields.include?(k) then
      var << k
      val << "'#{@m.q v}'"
    end
  end
  @m.query("insert into outgoing (#{var.join(",")}) values (#{val.join(",")})")
end

def proc_line(line)
  line.chomp!
  unless $year then
    $year = Time.now.year
    if line =~ /^([A-Z][a-z][a-z]  ?\d+ \d+:\d+:\d+)/no then
      $year -= 1 if Time.now < to_time($1)
    end
  end

  return unless line =~ /^([A-Z][a-z][a-z]  ?\d+ \d+:\d+:\d+) (\S+) postfix\/(\w+)\[\d+\]: (?:\[[^\]]+\] )?(.*)$/no
  datetime = $1
  servername = $2
  service = $3
  content = $4
  return if content =~ /^(dis)?connect from /no
  return unless content =~ /^([A-Z0-9]+): (.*)$/no
  qid = $1
  content = $2

  datetime = to_time(datetime).strftime("%Y-%m-%d %H:%M:%S")

  if service == "smtpd" and content =~ /^reject: .* from ([A-Za-z0-9._-]+)\[([\d.]+)\](?:: .*?: (.*))?; from=<(.*?)> to=<(.*?)>/no then
    hostname, ipaddr, info, sender, rcpt = $1, $2, $3, $4, $5
    sdomain = sender.split(/@/,2)[1]
    if info =~ /, \[[\d.]+\]$/ then
      info = $`
    end
    h = {"server"=>servername, "arrive_time"=>datetime, "hostname"=>hostname, "ipaddr"=>ipaddr, "sender"=>sender, "sdomain"=>sdomain, "queue_id"=>qid, "old"=>"1"}
    id = update_incoming h
    rdomain = rcpt.split(/@/,2)[1]
    h = {"id"=>id, "action_time"=>datetime, "recipient"=>rcpt, "rdomain"=>rdomain, "status"=>"reject", "info"=>info}
    insert_outgoing h
    return
  end

  if service == "cleanup" and content =~ /^reject: .* from ([A-Za-z0-9._-]+)\[([\d.]+)\]; from=<(.*?)> to=<(.*?)> .*: (.*)$/no then
    hostname, ipaddr, sender, rcpt, info = $1, $2, $3, $4, $5
    sdomain = sender.split(/@/,2)[1]
    if info =~ /, \[[\d.]+\]$/ then
      info = $`
    end
    h = {"server"=>servername, "arrive_time"=>datetime, "hostname"=>hostname, "ipaddr"=>ipaddr, "sender"=>sender, "sdomain"=>sdomain, "queue_id"=>qid, "old"=>"1"}
    id = update_incoming h
    rdomain = rcpt.split(/@/,2)[1]
    h = {"id"=>id, "action_time"=>datetime, "recipient"=>rcpt, "rdomain"=>rdomain, "status"=>"reject", "info"=>info}
    insert_outgoing h
    return
  end

  if qid == "NOQUEUE" then
    return
  end

  if content =~ /^reject: / then
    STDERR.puts "unrecognized reject line: #{content}" if $debug
    return
  end

  h = @m.query("select * from incoming where server='#{@m.q servername}' and queue_id='#{@m.q qid}' and old=0").fetch_hash
  unless h then
    h = {}
  end
  case content
  when "removed"
    if h["id"] then
      set_old qid
    end
  when /^client=(\S+)\[([^\]]*)\]/no
    set_old qid
    h = {"server"=>servername, "queue_id"=>qid, "arrive_time"=>datetime, "hostname"=>$1, "ipaddr"=>$2}
    update_incoming h
  when /^uid=(\d+) from=<(.*)>/no
    set_old qid
    h = {"server"=>servername, "queue_id"=>qid, "arrive_time"=>datetime, "uid"=>$1, "user"=>$2}
    update_incoming h
  when /^message-id=(.*)/no
    mid = $1
    if h["message_id"] and h["message_id"] != mid then
      set_old qid
      hh = {"server"=>servername, "queue_id"=>qid, "message_id"=>mid, "arrive_time"=>datetime}
    else
      hh = {"server"=>servername, "id"=>h["id"], "queue_id"=>qid, "message_id"=>mid}
      hh["arrive_time"] = datetime unless h["arrive_time"]
    end
    update_incoming hh
  when /^from=<(.*)>, size=(\d+),/no
    sender, size = $1, $2
    hh = {}
    hh["server"] = servername
    hh["sender"] = sender unless h["sender"]
    hh["sdomain"] = sender.split(/@/,2)[1] unless h["sdomain"]
    hh["size"] = size.to_i unless h["size"]
    unless hh.empty? then
      hh["id"] = h["id"]
      update_incoming hh
    end
  when /^to=<(.*?)>, (?:orig_to=<.*>, )?relay=(.*), delay=(\d+), status=(\S+) \((.*)\)/no
    hh = {"id"=>h["id"], "action_time"=>datetime, "recipient"=>$1, "relay"=>$2, "delay"=>$3, "status"=>$4, "info"=>$5}
    hh["rdomain"] = hh["recipient"].split(/@/,2)[1]
    hh["info"] = $5
    insert_outgoing hh
  else
    STDERR.puts "unrecognized line: #{content}" if $debug
  end
end

def follow_mode(f, fname)
  f.each do |line|
    break unless line[-1] == ?\n
    proc_line line
    @m.query("replace work set filename='#{@m.q fname}',inode='#{f.stat.ino}',pos='#{f.pos}'")
  end
end

unless $follow then
  ARGF.each do |line|
    proc_line line
  end
  exit
end

# follow mode
if ARGV.size != 1 then
  STDERR.puts <<EOS
follow mode need only one file and cannot treat stdin.
EOS
  exit 1
end

fname = ARGV[0]
inode, pos = @m.query("select inode,pos from work where filename='#{@m.q fname}'").fetch_row

if inode == nil then    # new file
  f = File.open(fname)
  inode = f.stat.ino
  follow_mode f, fname
  f.close
  exit
end

inode = inode.to_i
pos = pos.to_i
f = File.open(fname)
old = false
if f.stat.ino == inode then
  f.pos = pos
else
  STDERR.puts "file inode changed. finding old file..."
  f.close
  f = nil
  [fname+".0", fname+".1"].each do |fn|
    begin
      f = File.open(fn)
      if f.stat.ino == inode then
        old = true
        f.pos = pos
        STDERR.puts "#{fn} found"
        break
      end
      f.close
      f = nil
    rescue Errno::ENOENT
      # ignore
    end
  end
  unless f then
    STDERR.puts "give up"
    f = File.open(fname)
  end
end
follow_mode f, fname
f.close
if old then
  f = File.open(fname)
  follow_mode f, fname
  f.close
end
