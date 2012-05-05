# -*- encoding : utf-8 -*-
Tabu::Application.routes.draw do
  scope "(:locale)", :locale => /en|pl/ do
    get "microposts/create"

    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :sessions, only: [:new, :create, :destroy]
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]

    match '/uzytkownicy',  to: 'users#index', :as => :usersindex
    match '/zaloz_konto',  to: 'users#new', :as => :signup
    match '/zaloguj',  to: 'sessions#new', :as => :signin
    match '/wyloguj', to: 'sessions#destroy', via: :delete,  :as => :signout
    match '/edytuj_konto', to: 'sessions#edit', :as => :useredit

    root :to => 'static_pages#home'


    match '/pomoc', to: 'static_pages#help', :as => :help
    match '/kontakt', to: 'static_pages#contact', :as => :contact
    match '/polityka_prywatnosci', to: 'static_pages#privacy', :as => :privacy
    match '/o_stronie', to: 'static_pages#about', :as => :about

    resources :comments
    resources :cards

  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
