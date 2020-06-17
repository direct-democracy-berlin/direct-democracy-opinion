# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def new_device
    UserMailer.with(anonym_user: User.new, real_user: User.second).new_device
  end
end
