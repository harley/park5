Rails.application.routes.draw do
  resources :messages do

		collection do
			get 'outgoing'
		end
		
		collection do
			get 'incoming'
		end

		member do
			post 'mark_as_read'
		end
	end
  #get 'relationship/add'
  #get 'relationship/block'
  #get 'relationship/unblock'
	#SEEMS TO BE INCORRECT. Should have use the below?
	#resources :relationships, only: [:new, :create, :update, :index, :show]
	resources :relationships do
		member do
			post 'block_user'
		end

		member do
			post 'unblock_user'
		end
		# member do
		# 	post 'remove_user'
		# end
	end

	#get 'blocklist' => 'relationships#blocklist'
	resources :blocklists
	get 'auth/:provider/callback' => 'sessions#callback'

	#get 'sessions/new', as: :login
	#post 'sessions' => 'sessions#create', as: :submit_login
	#above code is equals to:
	resources :sessions, only: [:new, :create]

	#delete 'sessions/destroy'
	delete 'logout' => 'sessions#destroy'
  resources :users
  root "home#index"
end
