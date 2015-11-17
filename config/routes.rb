Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :multisites, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      scope :multisites do
        resources :accounts, :except => :show do
          collection do
            post :update_positions
          end
        end
      end
    end
  end

end
