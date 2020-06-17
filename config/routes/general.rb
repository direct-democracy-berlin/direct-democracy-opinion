# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tutorials, only: [] do
    member do
      post 'finish'
    end
  end

  resource :info, only: [:show] do
  end
  resolve('Info') { [:info] }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/welcome', to: 'welcome#welcome', as: 'welcome'
  get '/pages/:page', to: 'pages#show', as: 'pages'
  root 'root#landing_page'
end
