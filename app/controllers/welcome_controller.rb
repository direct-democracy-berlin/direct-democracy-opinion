class WelcomeController < ApplicationController
  before_action :set_welcome_thesis

  def welcome; end

  def thesis; end

  private

  def set_welcome_thesis
    @welcome_thesis = Thesis.find_by system_template: 'welcome'
  end

end
