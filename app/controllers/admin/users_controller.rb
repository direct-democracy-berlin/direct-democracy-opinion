class Admin::UsersController < Admin::BaseController
  # need security

  def update
    user = User.find(params[:id])
    user.skip_reconfirmation!
    user.update(user_params)
    user.save!
    respond_to do |format|
      format.html
      format.js { render json: user }
    end
  end

  def destroy
    # should we?, probably better merge...
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end