# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :books
      resources :book_lendings do
        member do
          post 'cancel'
        end
      end
    end
  end
end
