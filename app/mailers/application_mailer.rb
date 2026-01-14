class ApplicationMailer < ActionMailer::Base
  include LoadSettings

  default from: "from@example.com"
  layout "mailer"
end
