class ProfilesController < ApplicationController
  def show; end

  def update
    if user_params[:email] != current_user.email
      flash[:notice] = "Check your mail to confirm your new address '#{user_params[:email]}'"
    end
    current_user.update(user_params)
    current_user.save!

    respond_to do |format|
      format.html { redirect_back fallback_location: :root }
      format.js { render json: user }
    end
  end

  def logout
    if current_user.confirmed?
      session.clear
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.permit(:email, :name)
  end
end
