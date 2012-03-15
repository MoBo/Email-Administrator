module EmailHelper
  def active_badge(email)
    image_tag("email-is-active.png") if email.active?
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
end
