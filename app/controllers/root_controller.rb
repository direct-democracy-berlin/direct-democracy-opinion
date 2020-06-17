class RootController < ApplicationController
  def landing_page
    if current_user.confirmed?
      redirect_to theses_path
    else
      redirect_to welcome_path
    end
  end
end
