get '/' do
  redirect '/login' if session[:email].nil?
  redirect '/user/dashboard'
end

# Logging in
get '/login' do
  if session[:email]
    session[:flash_type] = "warning"
    session[:flash_message] = "You are already logged in!"
    redirect to '/user/dashboard'
  end
  erb :login
end

# Logging in
post '/login' do
  if session[:email]
    session[:flash_type] = "warning"
    session[:flash_message] = "You are already logged in!"
    redirect to '/user/dashboard'
  end
  user = User.authenticate(params[:form])
  if user.nil?
    session[:flash_type] = "danger"
    session[:flash_message] = "Invalid username or password."
    redirect '/login'
  end
  session[:email] = user.email
  session[:full_name] = user.full_name
  session[:flash_type] = "success"
  session[:flash_message] = "Successfully logged in."
  redirect "/user/dashboard"
end

# Logging out
get '/logout' do
  session.clear
  session[:flash_type] = "success"
  session[:flash_message] = "Successfully logged out."
  redirect '/login'
end

# Creating an account
get '/register' do
  if session[:email]
    session[:flash_type] = "warning"
    session[:flash_message] = "You are already logged in!"
    redirect to '/user/dashboard'
  end
  erb :register
end

# Creating an account
post '/register' do
  if session[:email]
    session[:flash_type] = "warning"
    session[:flash_message] = "You are already logged in!"
    redirect to '/user/dashboard'
  end
  form_data = params[:form]
  if form_data && (form_data[:retype_password].nil? || form_data[:password].nil?)
    session[:flash_type] = "danger"
    session[:flash_message] = "Please type in the passwords."
    redirect to '/register'
  end
  if form_data && (form_data[:retype_password] != form_data[:password])
    session[:flash_type] = "danger"
    session[:flash_message] = "Please retype your passwords."
    redirect to '/register'
  end
  user = User.create(form_data)
  unless user.valid?
    session[:flash_type] = "danger"
    session[:flash_message] = user.errors.full_messages[0]
    redirect to '/register'
    return
  end
  session[:flash_type] = "success"
  session[:flash_message] = "Welcome on board! Successfully registered!"
  redirect to '/login'
end

before '/user/*' do
  if session[:email].nil?
    session[:flash_type] = "danger"
    session[:flash_message] = "Please login to proceed."
    redirect '/login'
  end
end

# Viewing the secret page
# Redirecting a user back to the "log in" screen if they try to view the secret page without being logged in
get '/user/dashboard' do
  erb :dashboard
end