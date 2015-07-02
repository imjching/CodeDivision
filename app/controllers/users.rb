# Creating an account
get '/users/new' do
  redirect_error("/", "You are already logged in!") if logged_in?
  erb :user_create
end

# Creating an account
post '/users' do
  redirect_error("/", "You are already logged in!") if logged_in?
  form_data = params[:form]
  redirect_error("/users/new", "Passwords do not match.") if form_data && (form_data[:retype_password] != form_data[:password])
  form_data.delete("retype_password")
  user = User.create(form_data)
  redirect_error("/users/new", user.errors.full_messages) unless user.valid?
  redirect_success("/login", "Welcome on board! Successfully registered!")
end

# Edit user
get '/users/:id/edit' do |id|
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  redirect_error("/", "Permission denied!") if id.to_i != current_user.id
  erb :user_edit
end

# Update user
patch '/users/:id' do |id|
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  redirect_error("/", "Permission denied!") if id.to_i != current_user.id
  user = User.find(id.to_i)
  redirect_error("/", "Invalid user id.") unless user
  form_data = params[:user]
  redirect_error("/users/#{id}/edit", "Passwords do not match.")  if form_data && (form_data[:retype_password] != form_data[:password])
  form_data.delete("retype_password")
  user.update(form_data)
  redirect_error("/users/#{id}/edit", user.errors.full_messages) unless user.valid?
  redirect_success("/users/#{id}/edit", "Successfully updated")
end

# Show user profile
get '/users/:id' do |id|
  @user = User.find_by_id(id.to_i)
  redirect_error("/", "Invalid user id.") unless @user
  erb :user_show
end