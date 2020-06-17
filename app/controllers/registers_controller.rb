# frozen_string_literal: true

# Handles user and device registration
class RegistersController < ApplicationController
  def show; end

  def send_confirmation
    email = params[:email]

    # check if mail exists
    real_user = User.find_by(email: email)
    if real_user
      create_action_for_new_device real_user
      flash[:notice] = 'Message sent, check your email'
      redirect_to theses_path
    else
      confirm_mail
    end
  end

  def merge_new_device
    action = Action.find_by(token: params[:token])
    if action
      merge_sessions_for_new_device action

      if session.id.to_s == action.payload['from_session']
        # same device used for following link
        flash[:notice] = 'You are now logged in in this new device!'
        redirect_to theses_path
      else
        redirect_to pages_path(page: :logged_in_in_new_device)
      end
      action.destroy
    else
      redirect_to pages_path(page: :action_outdated)
    end
  end

  private

  def create_action_for_new_device(real_user)
    Action.find_by(user: current_user, action: 'new_device')&.delete
    # new device!
    session[:switch_to_new_device] = true
    action = Action.create!(action: 'new_device',
                            user: current_user,
                            payload: { anonym_user_id: current_user.id,
                                       user_id: real_user.id,
                                       from_session: session.id.to_s })
    UserMailer.with(anonym_user: current_user,
                    real_user: real_user,
                    token: action.token).new_device.deliver_now
  end

  def merge_sessions_for_new_device(action)
    anonym_user = User.find(action.payload['anonym_user_id'])
    user = User.find(action.payload['user_id'])

    user.merge_from(anonym_user)
    Action.create!(user: anonym_user, action: 'new_device_accepted', payload: action.payload)
  end

  def confirm_mail
    current_user.unconfirmed_email = params[:email]
    if current_user.save
      current_user.send_confirmation_instructions
      flash[:notice] = 'Message sent, check your email'
      redirect_to theses_path
    else
      puts current_user.errors
      @errors = current_user.errors
      # redirect_to register_path
      render 'show'
    end
  end
end
