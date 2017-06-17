module AuthHelpers
  def assume_logged_in(user = nil)
    user = user || create(:user)
    login_as(user)
  end
end
