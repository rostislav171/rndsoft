# app/controllers/devise/registrations_controller.rb
class Devise::RegistrationsController < DeviseController
  before_action :configure_sign_up_params, only: [:create]
  before_action :initialize_resource_defaults, only: [:new, :create]

  def create
    self.resource = resource_class.new(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up

        respond_with resource, location: after_sign_in_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute_name])
  end

  def initialize_resource_defaults
    self.resource = resource_class.new
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :username, :password_confirmation, :digest_frequency)
  end

end
