# View all users
get '/users' do
  @users = User.all
  erb :'/users/index'
end

# New user (new)
get '/users/new' do
  redirect to '/' if logged_in?

  @user = User.new(session[:form_fields])
  session.delete("form_fields")
  erb :'users/new'
end

# Create user (create)
post '/users' do
  redirect to '/' if logged_in?

  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id # auto login
    @user.create_default_album
    flash[:success] = "Welcome to Flickr, Jr. #{@user.full_name}"
    redirect to '/'
  else
    flash[:form_errors] = @user.errors.full_messages
    session[:form_fields] = user_params.permit(:email, :full_name)
    redirect to '/users/new'
  end
end

# View one user (show)
get '/users/:id' do |id|
  @user = User.find_by_id(id)
  if @user.nil?
    flash[:danger] = "Invalid user id."
    redirect to '/'
  else
    erb :'users/show'
  end
end

# Edit user (edit)
get '/users/:id/edit' do |id|
  redirect to '/' if current_user.nil? || current_user.id != id.to_i

  if session[:form_fields]
    @user = User.new(session[:form_fields])
    session.delete("form_fields")
    erb :'users/edit'
  end

  @user = User.find_by_id(id)
  if @user.nil?
    flash[:danger] = "Invalid user id."
    redirect to '/'
  else
    @user.password = nil
    erb :'users/edit'
  end
end

# Update user (update)
patch '/users/:id' do |id|
  redirect to '/' if current_user.nil? || current_user.id != id.to_i

  @user = User.find_by_id(id)
  if @user.nil?
    flash[:danger] = "Invalid user id."
    redirect to '/'
  elsif @user.update_attributes(user_params)
    flash[:success] = "Successfully updated user details!"
    redirect to "/users/#{id}/edit"
  else
    flash[:form_errors] = @user.errors.full_messages
    session[:form_fields] = user_params.permit(:email, :full_name)
    redirect to "/users/#{id}/edit"
  end
end

def user_params
  params.require(:user).permit(:email, :password, :full_name)
end
