Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  root 'events#index'

  post "/graphql", to: "graphql#execute"
  get 'events' => 'events#index'
  post 'events/new' => 'events#create'
  post 'events/edit' => 'events#edit'
  post 'events/:id/removeSubscription/:subscriber_id' => 'attendees#removeSubscription'
  get 'attendees' => 'attendees#index'
  get 'hosts' => 'hosts#index'
  get '/hosts/:id', to: 'hosts#show', as: 'host'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :events

  post 'host_checkin' => 'hosts#checkin',  as: :host_checkin
  post 'events/:id/openEvent' => 'events#openEvent', as: :open_event
  post 'attendee_checkin' => 'attendees#checkin', as: :attendee_checkin
  post 'attendees' => 'attendees#getAttendees', as: :getAttendees

  get 'attendees' => 'attendees#index', as: :index
  get 'attendees/:id' => 'attendees#show', as: :attendee
  post 'attendees/:id/delete' => 'attendees#removeSubscription', as: :attendee_delete
end
 