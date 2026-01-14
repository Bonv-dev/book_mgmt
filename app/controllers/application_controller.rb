class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :load_settings

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "権限がありません。", status: :see_other
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:enabled, :name, :is_admin, :is_librarian]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # WEB common settings
  def load_settings
    @my_settings = Rails.application.config.x.settings
    @status_list = @my_settings[:status_list]
  end
end
