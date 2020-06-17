# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class CustomDeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    CustomDeviseMailer.confirmation_instructions(User.new(email: 'some@email.com'), 'thisisatoken', {})
  end
end
