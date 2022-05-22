class Users::RegistrationsController < Devise::RegistrationsController
  # Override the action you want here.

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :bio, :photo])
  end
end
