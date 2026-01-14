class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # WEB common settings
  MY_SETTINGS = Rails.application.config.x.settings
end
