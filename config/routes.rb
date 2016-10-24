Rails.application.routes.draw do
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    root 'home/home#index'

    scope '/home', module: 'home' do
      resources :user_sessions, only: [:new, :create]
      resources :users, only: [:new, :create]
      get 'login' => 'user_sessions#new'
    end

    scope '/dashboard', module: 'dashboard' do
      resources :users
      resources :decks do
        resources :cards
        put :make_current, on: :member
      end

      resources :user_sessions, only: [:destroy]

      get 'logout' => 'user_sessions#destroy'

      post 'check_answer', to: 'home#check_answer'
    end
  end
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
end
