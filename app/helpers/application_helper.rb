module ApplicationHelper

  def user_avatar(user)
    if user.avatar.attached?
      url_for(user.avatar)
    else
      user.gravatar_url
    end
  end

end
