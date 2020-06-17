class Admin::BaseController < ApplicationController
  # we need extra security here!
  before_action :only_admins

  private

  def only_admins
    unless current_user.admin?
      Rails.logger.error "No admin"
      raise ActionController::RoutingError.new('Not found')
    end
  end
end