class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :load_settings

  include Pundit::Authorization
  after_action :pundit_verify_authorized
  after_action :pundit_verify_policy_scoped

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def pundit_verify_authorized
    return if devise_controller?
    return if action_name == "index"

    verify_authorized
  end

  def pundit_verify_policy_scoped
    return if devise_controller?
    return unless action_name == "index"

    verify_policy_scoped
  end

  def configure_permitted_parameters
    added_attrs = [:enabled, :name, :is_admin, :is_librarian]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # WEB common settings
  def load_settings
    @my_settings = Rails.application.config.x.settings
    @status_list = @my_settings[:status_list]
    @status_options = @status_list.invert
  end
end
