# Static pages routing
class PagesController < ApplicationController
  layout 'minimal'

  def show
    render template: "pages/#{params[:page]}"
  end
end
