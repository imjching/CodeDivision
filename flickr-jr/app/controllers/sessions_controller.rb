# New session
get '/login' do
  redirect to '/' if logged_in?

  @user = User.new(session[:email])
  session.delete("email")
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
    session[:email] = user_params.permit(:email)
    flash[:danger] = "Invalid email or password."
    redirect to '/login'
  end
end

# Destroy a session (delete!)
get '/logout' do
  session.clear
  redirect to '/'
end

def user_params
  params.require(:user).permit(:email, :password)
end
