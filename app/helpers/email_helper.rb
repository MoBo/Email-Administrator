module EmailHelper
  def active_class(email)
    email.active? ? "active" : "inactive"
  end

  def admin_badge(email)
    image_tag("email-is-admin.png") if email.admin?
  end

  def get_email_prefix(email)
    email.sub(/@.*/,"")
  end

  def forwards_badge(email)
    image_tag("email-forwards.png")+content_tag(:span, email.forwards.count, :class => "label label-info") unless email.forwards.empty?
  end
  
  def can_receive(email)
    content_tag(:span, "R", :class => "label label-info") if email.can_receive
  end
  
  def can_send(email)
    content_tag(:span, "S", :class => "label label-info") if email.can_send
  end
  
  def get_expire_date(email)
    email.expires_on ? email.expires_on : APP_CONFIG["email_default_expires_in"].days.from_now.to_date
  end
  
  def get_email_path(email)
    email.email_path ? email.email_path : APP_CONFIG["email_default_save_path"]
  end
end
