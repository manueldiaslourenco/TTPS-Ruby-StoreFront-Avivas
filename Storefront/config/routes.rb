Rails.application.routes.draw do

  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'devise/registrations#update', as: 'user_registration'
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root "main#index"

  get 'admin', to: 'admin#dashboard', as: 'admin'

  get 'admin/users', to: 'user_management#index', as: 'admin_users'        # Listar todos los usuarios
  get 'admin/users/show/:id', to: 'user_management#show', as: 'show_admin_user'
  get 'admin/users/new', to: 'user_management#new', as: 'new_admin_user'    # Formulario para crear un nuevo usuario
  post 'admin/users', to: 'user_management#create', as: 'create_admin_user' # Crear un nuevo usuario
  delete 'admin/users/delete/:id', to: 'user_management#destroy', as: 'delete_admin_user'

  #get 'products', to: 'products#index', as: 'products'                
  #get 'products/new', to: 'products#new', as: 'new_product'            
  #post 'products', to: 'products#create', as: 'create_product'         
  #get 'products/:id', to: 'products#show', as: 'product'               
  #get 'products/:id/edit', to: 'products#edit', as: 'edit_product'     
  #patch 'products/:id', to: 'products#update', as: 'update_product'
  #patch 'products/:id/update_stock', to: 'products#update_stock', as: 'update_stock_product'

  #resources :products

  resources :products do
    # Ruta específica para actualizar solo el stock
    patch 'update_stock', on: :member
  end

  resources :sales do
    # Ruta específica para actualizar solo el stock
    post :update_products_list, on: :collection
    post :clear_selected_products, on: :collection
    
  end
  
end
