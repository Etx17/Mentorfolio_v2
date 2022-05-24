class Users::RegistrationsController < Devise::RegistrationsController
  # Override the action you want here.
  before_action :configure_permitted_parameters

  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :photo])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :bio, :photo])
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name bio photo])
  end
end
