Rails.application.routes.draw do
    devise_for :users, :controllers => { :registrations => "registrations" }

    root 'questions#index'
    resources :questions do
      resources :answers
    end

    resources :profiles
    resources :courses

    get "questions/:id" => "questions#show"

    get "user-management" => "profiles#index", as: 'user_management'

    get 'users/:id/approve'=> 'profiles#approve_user', as: 'approve_user'

    get 'users/:id/disable'=> 'profiles#disable_user', as: 'disable_user'

    post 'profiles/edit-role' => 'profiles#edit_role'

end
