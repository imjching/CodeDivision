# Shows form to create post
get '/posts/new' do
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  erb :post_create
end

# Create a new post
post '/posts' do
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  redirect_error("/posts/new", "Please enter at least one tag!") unless params[:tags]
  new_post = current_user.posts.create(params[:form])
  redirect_error("/posts/new", new_post.errors.full_messages) unless new_post.valid?
  tags_array = params[:tags].split(",").uniq
  tags = tags_array.map{|tag| Tag.create(name: tag)}
  new_post.tags = tags
  redirect_success("/dashboard", "Successfully created post title: #{new_post.title}")
end

# Display a particular post
get '/posts/:slug' do |s|
  @post = Post.find_by_slug(s)
  redirect_error("/", "Post not found! Better luck next time :(") unless @post
  erb :post_show
end

# Edit an existing post
get '/posts/:slug/edit' do |s|
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  @post = Post.find_by_slug(s)
  redirect_error("/dashboard", "Post not found! Better luck next time :(") unless @post
  redirect_error("/dashboard", "Access forbidden! You cannot edit this post!") if current_user.id != @post.user.id
  erb :post_edit
end

# Update post data
patch '/posts/:slug' do |s|
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  redirect_error("/posts/new", "Please enter at least one tag!") unless params[:tags]
  @post = Post.find_by_slug(s)
  redirect_error("/dashboard", "Post not found! Better luck next time :(") unless @post
  redirect_error("/dashboard", "Access forbidden! You cannot edit this post!") if current_user.id != @post.user.id
  @post.content = params[:form][:content]
  tags_array = params[:tags].split(",").uniq
  tags = tags_array.map{|tag| Tag.create(name: tag)}
  @post.tags = tags
  @post.save
  redirect_success("/posts/#{s}", "You have successfully saved the post!")
end

# Delete an existing post
delete '/posts/:slug' do |s|
  redirect_error("/login", "Access forbidden! Please login to continue.") unless logged_in?
  post = Post.find_by_slug(s)
  redirect_error("/dashboard", "Post not found! Better luck next time :(") unless post
  redirect_error("/dashboard", "Access forbidden! You cannot delete this post!") if current_user.id != post.user.id
  post.destroy
  redirect_success("/", "Successfully deleted post with title: #{post.title}")
end