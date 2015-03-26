# Show login page
get '/login' do
  redirect_error("/", "You are already logged in.") if logged_in?
  erb :login
end

# Login
post '/login' do
  redirect_error("/", "You are already logged in!") if logged_in?
  user = User.authenticate(params[:form])
  redirect_error("/login", "Invalid email or password.") if user.nil?
  session[:user_id] = user.id
  redirect_success("/", "Successfully logged in.")
end

# Log out
get '/logout' do
  session.clear
  redirect_success("/login", "Successfully logged out.")
end