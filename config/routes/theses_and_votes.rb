# frozen_string_literal: true

Rails.application.routes.draw do
  resources :votes, only: [] do
    collection do
      post 'vote'
    end
  end

  resources :theses do
    member do
      get 'results'
    end
    collection do
      get 'random'
      get 'my_own'
      get 'show_voted'
      get 'show_of_tags'
      post 'show_of_tags'
    end
  end
end
