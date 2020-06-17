# frozen_string_literal: true

# tidy up in application.rb: config.paths['config/routes.rb'] = Dir[Rails.root.join('config/routes/*.rb')]
# https://medium.com/rubycademy/how-to-keep-your-routes-clean-in-ruby-on-rails-f7cf348ec13b
Rails.application.routes.draw do
  namespace :admin do
    resource :admin
    resources :users
  end

  get 'showcase/styles'
end
