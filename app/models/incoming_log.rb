class IncomingLog < ActiveRecord::Base
  def to_hash
    hash = {}; self.attributes.each { |k,v| hash[k] = v }
    return hash
  end
end