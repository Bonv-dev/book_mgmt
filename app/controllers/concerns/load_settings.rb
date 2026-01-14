module LoadSettings
  extend ActiveSupport::Concern

  included do
    before_action :load_settings
  end

  private

  def load_settings
    @my_settings = Rails.application.config.x.settings
    @status_list = @my_settings[:status_list]
    @status_options = @status_list.invert
  end
end
