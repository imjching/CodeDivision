# New session
get '/login' do
  redirect to '/' if logged_in?

  @user = User.new(session[:username])
  session.delete("username")
  erb :'sessions/new'
end

# Create a session
post '/login' do
  redirect to '/' if logged_in?

  @user = User.authenticate(user_params)
  if @user
    session[:user_id] = @user.id
    redirect to '/'
  else
    session[:username] = user_params.permit(:username)
    flash[:danger] = "Invalid username or password."
    redirect to '/login'
  end
end

# Destroy a session
delete '/logout' do
  session.clear
  redirect to '/'
end

def user_params
  params.require(:user).permit(:username, :password)
end