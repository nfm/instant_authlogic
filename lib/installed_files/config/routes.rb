ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => :user_sessions, :action => :new, :conditions => { :method => :get }
  map.login 'login', :controller => :user_sessions, :action => :create, :conditions => { :method => :post }
  map.logout 'logout', :controller => :user_sessions, :action => :destroy
  map.resources :users, :member => { :change_password => [ :get, :post ] }
  map.resources :user_sessions
end
