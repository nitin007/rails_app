Blog::Application.routes.draw do
	
	namespace :admin do
		resources :posts do
			resources :comments, :only => [:create, :destroy]
		end
		resources :categories, :except => :show
	end
	  
	scope :module => "admin" do
  	resources :posts, :except => [:new, :edit] do
  		resources :comments, :only => [:create, :destroy]
  	end
	end
	 
	scope "/admin" do
  	resources :posts, :only => [:new, :edit]
  	resources :categories, :except => :show
	end
	  
	resources :logins, :only => ['index', 'login', 'logout'] do
  	post 'login', :on => :collection
	end
	
	match 'login' => 'logins#index'
	match 'logout' => 'logins#logout'

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
 	root :to => 'logins#index'

	match '*k', :to => 'errors#routing'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
