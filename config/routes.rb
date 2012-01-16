Greeting::Application.routes.draw do

    match '/admin', :to => 'admin#index'
    get  'admin/index'
    get  'admin/upload'
    post 'admin/upload_template'
    get  'admin/tag'
    post 'admin/tag_a_card'
    post 'admin/tag_card_from_image'

    get  'users/send_card'  # This needs to be before the resources :users line below 
                            # otherwise we end up at users/show.
    get  'users/sign_card'   
    get  'users/see_received'   
    get  'users/see_sent'   
    get  'users/see_signed'   
    get  'users/see_need_to_sign'   
    post 'users/do_sign'   

    match '/all_cards', :to => 'cards#show_all_cards'
    get  'cards/show_all_cards'
    get  'cards/show_single_card'
    get  'cards/show_card_from_email'
    post 'cards/create_a_card'
    post 'cards/create_from_image'   
    get  'cards/search'   

    resources :users
    resources :sessions, :only => [:new, :create, :destroy]
    resources :cards, :only => [:create]

    match '/signup', :to => 'users#new'
    match '/signin', :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy'

    root :to => 'pages#home'
    match '/contact', :to => 'pages#contact'
    match '/about', :to => 'pages#about'
    match '/help', :to => 'pages#help'

    get "pages/home"
    get "pages/contact"
    get "pages/about"
    get "pages/help"

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
    # root :to => 'welcome#index'

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id(.:format)))'
end
