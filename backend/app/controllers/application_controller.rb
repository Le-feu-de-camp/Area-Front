require "httparty"

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, only: :create
  #protect_from_forgery with: :null_session
  #OmniAuth::AuthenticityTokenProtection.default_options(key: "csrf.token", authenticity_param: "_csrf")
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  def about
    about = File.read("public/about.json")
    render json: about
  end


  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name admin])
    end

    def user_logged?
      unless user_signed_in?
        render json: { "error": "You need to be logged" }, status: :unauthorized
      end
    end
end
