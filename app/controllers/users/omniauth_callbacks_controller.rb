class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.remember_me!
    sign_in_and_redirect @user
  end
end
