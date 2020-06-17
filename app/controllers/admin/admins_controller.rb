class Admin::AdminsController < Admin::BaseController
  # we need extra security here!
  before_action :only_admins


  def show
    @users = User.all
  end

  private

  def only_admins
    raise ActionController::RoutingError.new('Not found') unless current_user.admin?
  end
end