# frozen_string_literal: true

class TutorialsController < ApplicationController
  def finish
    tutorial_variable = "tutorial_#{params[:id]}"
    if current_user.respond_to? tutorial_variable.to_sym
      current_user.send("#{tutorial_variable}=", true)
      current_user.save!
    end
  end
end
