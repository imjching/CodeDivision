# Creating an account
get '/users/new' do
  redirect_with_flash("/", "warning", "You are already logged in!") if logged_in?
  erb :register
end

# Creating an account
post '/users' do
  redirect_with_flash("/", "warning", "You are already logged in!") if logged_in?
  form_data = params[:form]
  if form_data && (form_data[:retype_password].nil? || form_data[:password].nil?)
    redirect_with_flash("/users/new", "danger", "Please type in the passwords.")
  end
  if form_data && (form_data[:retype_password] != form_data[:password])
    redirect_with_flash("/users/new", "danger", "Passwords do not match.")
  end
  user = User.create(form_data)
  redirect_with_flash("/users/new", "danger", user.errors.full_messages[0]) unless user.valid?
  redirect_with_flash("/login", "success", "Welcome on board! Successfully registered!")
end

# Show users
get '/users/view' do
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  @users = User.all.order(:created_at)#.where.not(id: current_user.id)
  erb :show_users
end

# Edit user
get '/users/:id/edit' do |id|
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  redirect_with_flash("/", "danger", "Permission denied!") if id.to_i != current_user.id
  erb :edit_user
end

# Edit user
post '/users/:id' do |id|
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  redirect_with_flash("/", "danger", "Permission denied!") if id.to_i != current_user.id
  user = User.find(id.to_i)
  redirect_with_flash("/", "danger", "Invalid user id.") if user.nil?
  form_data = params[:user]
  if form_data && (form_data[:retype_password].nil? || form_data[:password].nil?)
    redirect_with_flash("/users/#{id}/edit", "danger", "Please type in the passwords.")
  end
  if form_data && (form_data[:retype_password] != form_data[:password])
    redirect_with_flash("/users/#{id}/edit", "danger", "Passwords do not match.")
  end
  user.update(form_data)
  redirect_with_flash("/users/#{id}/edit", "danger", user.errors.full_messages[0]) unless user.valid?
  redirect_with_flash("/users/#{id}/edit", "success", "Successfully updated")
end

# Show user
# This should display all the links that a particular user has created.
# If I'm viewing my own profile page, show the number of clicks next to each link
get '/users/:id' do |id|
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  @user = User.find(id.to_i)
  redirect_with_flash("/users/view", "danger", "Could not find user.") if @user.nil?
  erb :show_user
end