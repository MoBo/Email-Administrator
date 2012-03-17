Factory.define :email_expires_in_two_days , :class => :email do |email|
  email.email                 "mhart65"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart542@example.com"
  email.alt_email             "mhart542@example.com"
  email.expires_on               Time.now + 2.days
  email.reminder_sent         false
  email.email_path            "var/logs/"
  email.domain_id             1
end

Factory.define :email do |email|
  email.email                 "mhartl"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart2@example.com"
  email.alt_email             "mhart2@example.com"
  email.expires_on               Time.now + 50.days
  email.reminder_sent         false
  email.email_path            "var/logs/"
  email.domain_id             1
end

Factory.define :admin , :class => :email do |admin|
  admin.email   "ich@sauli.de"
  admin.password "foobar"
  admin.email_path "var/logs/"
  admin.domain_id               1
  admin.admin "true"
  admin.expires_on               Time.now + 50.days
  admin.alt_email "moritz.bode@gmail.com"
end

Factory.define :admin_domain, :class => :domain do |domain|
  domain.name "sauli.de"
end

Factory.define :email_expires_reminder_send , :class => :email do |email|
  email.email                 "mhart4"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart5@example.com"
  email.alt_email             "mhart6@example.com"
  email.expires_on               Time.now + 2.days
  email.reminder_sent         true
  email.email_path            "var/logs/"
  email.domain_id             1
end

Factory.sequence(:domain_name) do |n|
  "#{n}example.com"
end

Factory.define :domain_seq, :class => :domain do |d|
 d.name Factory.next(:domain_name)
end

Factory.define :domain do |d|
 d.name "test.com"
end

