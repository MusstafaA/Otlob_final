Rails.application.routes.draw do
 
  get 'editorder/:id/showinvited/' => 'editorder#showinvited'

  get 'editorder/:id/showjoined/'  => 'editorder#showjoined'

  get 'editorder/:id/remove/'       => 'editorder#remove'
  get 'editorder/:id/getuser/'       => 'editorder#getuser'
  

  resources :ordetails

  resources :usgroups

  resources :friendships

  resources :groups

  resources :orders

  resources :inviteds

  resources :friendships


  #devise_for :users
  #devise_for :users
 # devise_for :models
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  

  devise_for :users, :controllers => { registrations: 'registrations' , :omniauth_callbacks => "callbacks" }


  #devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  # resources :users
  # root 'users#index'


  # Example of regular route:
  
    get 'orders/joined/all' => 'orders#joined'

    get 'notifications/show' => 'notifications#show'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
    resources :users do
    resources :orders
  end
   resources :users do
    resources :groups
  end

   resources :users do
    resources :inviteds
  end

   resources :orders do
       resources :inviteds
    end

  resources :users do
       resources :friendships
    end

  resources :users do
       resources :usgroups
  end
      
  resources :groups do
       resources :usgroups
  end

  resources :users do
    resources :ordetails
  end

   resources :orders do
       resources :ordetails
    end



# notifications
resources :notifications do
  collection do
    post :mark_as_read
  end

  end

#join order
resources :ordetails do
  collection do
    post :join
  end

  end


end
