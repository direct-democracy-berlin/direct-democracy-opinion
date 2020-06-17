class UserMailer < ApplicationMailer

  def new_device
    @anonym_user = params[:anonym_user]
    @real_user = params[:real_user]
    @token = params[:token]
    mail(to: @real_user.email, subject: 'D²O: new device registration')
  end
end
