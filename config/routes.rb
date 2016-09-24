Rails.application.routes.draw do
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    root 'home#index'

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
    delete 'oauth/:provider' => 'oauths#destroy', :as => :delete_oauth

    resources :users
    resources :decks do
      resources :cards
      put :make_current, on: :member
    end

    resources :user_sessions, only: [:new, :create, :destroy]

    get 'login'  => 'user_sessions#new'
    get 'logout' => 'user_sessions#destroy'

    post 'check_answer', to: 'home#check_answer'
  end

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
end
