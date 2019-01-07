class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # this makes it reject HTTP requests that are coming from somewhere besides my domain
    # all forms have a special token that is automatically included, which my app decrypts
    # any request not from my site wouldn't have that token

    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
      update_attrs = [:password, :password_confirmation, :current_password]
      devise_parameter_sanitizer.permit :account_update, keys: update_attrs
    end

    
end
