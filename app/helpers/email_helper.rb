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
    content_tag(:span, "R", :class => "label label-info") unless email.can_receive?
  end
  
  def can_send(email)
    content_tag(:span, "S", :class => "label label-info") unless email.can_send?
  end
end
