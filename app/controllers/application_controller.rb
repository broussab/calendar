class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_beginning_of_week

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :slackhandle])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :slackhandle])
  end
end
