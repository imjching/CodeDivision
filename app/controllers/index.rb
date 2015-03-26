# Default route for public
get '/' do
  redirect to '/dashboard' if logged_in?
  @users = User.order(:created_at)
  @tags = Tag.group(:name).count
  erb :index
end

# Default route for users
get '/dashboard' do
  redirect_error("/login", "Access forbidden! Please login to continue.") if !logged_in?
  @users = User.where.not(id: current_user.id).order(:created_at)
  @tags = Tag.group(:name).count
  erb :dashboard
end