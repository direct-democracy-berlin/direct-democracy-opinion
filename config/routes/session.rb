# frozen_string_literal: true

Rails.application.routes.draw do
  resource :register, only: %w[show] do
    post 'send_confirmation'
    get 'send_confirmation' => redirect('register')
    get 'merge_new_device'
  end

  devise_for :users

  resource :profile do
    get 'logout'
  end

end
