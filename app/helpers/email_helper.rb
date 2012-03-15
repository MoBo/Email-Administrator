module EmailHelper
  def active_class(email)
    email.active? ? "active" : "inactive"
  end

  def admin_badge(email)
    image_tag("email-is-admin.png") if email.admin?
  end

  def expiration_date_for(email)
    image_tag("email-expires-on.png") + l(email.expires_on) if email.expires_on
  end

  def forwards_badge(email)
    image_tag("email-forwards.png")+content_tag(:span, email.forwards.count, :class => "label label-info") unless email.forwards.empty?
  end

  def maildir_for(email)
    email.email_path || File.join(APP_CONFIG["email_default_save_path"], email.email || "")
  end

  def prefix_for(email)
    email.split("@").first
  end
  
  def receive_badge(email)
    image_tag("email-can-receive.png") if email.can_receive?
  end
  
  def send_badge(email)
    image_tag("email-can-send.png") if email.can_send?
  end
end
