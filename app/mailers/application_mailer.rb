class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@direct-democracy.nowhere'
  layout 'mailer'
end
