module DomainHelper
  def user_count_badge(domain)
    image_tag("email-forwards.png")+content_tag(:span, domain.count_users_of_domain, :class => "label label-info")
  end
end
