Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :multisites do
    resources :multisites, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :multisites, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :multisites, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
