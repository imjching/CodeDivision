get '/' do
  if logged_in?
    redirect to '/dashboard'
  end
  #redirect_with_flash("/login", "warning", "Please sign in to proceed!")
  @users = User.all.order(:created_at)
  @tags = Tag.all.group(:name).count
  erb :index
end

# Show me all posts
# Tabbed to create post/edit post/view my own post, view other users
get '/dashboard' do
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  @users = User.where.not(id: current_user.id).order(:created_at)
  @tags = Tag.all.group(:name).count
  erb :dashboard
end