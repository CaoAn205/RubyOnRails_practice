module ApplicationHelper

  def user_avatar(user)
    if user.avatar
      user.avatar
    else
      user.gravatar_url
    end
  end

end
