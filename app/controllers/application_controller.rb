class ApplicationController < ActionController::Base
  include RenderHelper

  before_action :check_add_new_device
  before_action :anonymous_sign_in
  #before_action :check_session_is_valid

  def check_add_new_device
    return unless session[:switch_to_new_device]

    # switch accounts
    # could we have more than one?
    action = Action.user_action(current_user, 'new_device_accepted').select { |a| a.payload['from_session'] == session.id.to_s }.first
    if action
      user = User.find(action.payload['user_id'])
      anonym_user_id = User.find(action.payload['anonym_user_id'])
      anonym_user_id.destroy
      sign_in(user)
      action.destroy
      session[:switch_to_new_device] = nil
      redirect_to root_path
    end
  end

  #TODO: for loggint out decentralized... later on
  # def check_session_is_valid
  #   byebug
  #   return unless current_user&.confirmed?
  #   return if session[:last_checked] && (Time.current - session[:last_checked]) < 10

  #   if Device.from_user_and_agent(current_user, request.user_agent)
  #            .where(session_name: session.id.to_s).exists?
  #     session[:last_checked] = Time.current
  #   else
  #     #session.clear
  #     #redirect_to logout_profile_path
  #   end
  # end


  def anonymous_sign_in
    return if user_signed_in?

    u = User.new(devices_attributes: [{ user_agent: request.user_agent }])
    u.save(:validate => false)
    u.remember_me!
    sign_in :user, u
  end

  # user session: session.id reset: session.clear
  def after_confirmation
    puts 'xxxxxxxx'
  end

end
