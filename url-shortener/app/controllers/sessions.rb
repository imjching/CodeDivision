# Logging in
get '/login' do
  redirect_with_flash("/", "warning", "You are already logged in!") if logged_in?
  erb :login
end

# Logging in
post '/login' do
  redirect_with_flash("/", "warning", "You are already logged in!") if logged_in?
  user = User.authenticate(params[:form])
  redirect_with_flash("/login", "danger", "Invalid username or password.") if user.nil?
  session[:user_id] = user.id
  redirect_with_flash("/", "success", "Successfully logged in.")
end

# Logging out
get '/logout' do
  session.clear
  redirect_with_flash("/login", "success", "Successfully logged out.")
end