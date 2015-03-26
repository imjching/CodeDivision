# Create a new post
get '/posts/new' do
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  erb :post_create
end

# A page that lets someone create a new posting in a given category
# Create my own posting
post '/posts' do
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  redirect_with_flash("/posts/new", "danger", "Please enter the tags!") if params[:tags].nil?
  new_post = current_user.posts.create(params[:form])
  redirect_with_flash("/posts/new", "danger", new_post.errors.full_messages[0]) unless new_post.valid?
  tag = params[:tags].split(",").uniq
  tag.each do |t|
    new_post.tags.create(name: t)
  end
  redirect_with_flash("/dashboard", "success", "Successfully created post title: #{new_post.title}")
end

# Show me a particular post
get '/posts/:slug' do |s|
  #redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  @post = Post.find_by_slug(s)
  redirect_with_flash("/", "danger","Post not found! Better luck next time :(") if @post.nil?
  erb :post_show
end

# Edit an existing post
get '/posts/:slug/edit' do |s|
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  @post = Post.find_by_slug(s)
  redirect_with_flash("/dashboard", "danger", "Post not found! Better luck next time :(") if @post.nil?
  redirect_with_flash("/dashboard", "danger", "Access forbidden! You cannot edit this post!") if current_user.id != @post.user.id
  erb :post_edit
end

# UPDATE
# A page that lets someone who has created a page return to edit/update the page
# Edit my postings by using the "secret key" that I get after creating my posting
post '/posts/:slug' do |s|
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  redirect_with_flash("/posts/new", "danger", "Please enter at least one tag!") if params[:tags].nil?
  @post = Post.find_by_slug(s)
  redirect_with_flash("/dashboard", "danger", "Post not found! Better luck next time :(") if @post.nil?
  redirect_with_flash("/dashboard", "danger", "Access forbidden! You cannot edit this post!") if current_user.id != @post.user.id
  form_data = params[:form]
  modified = false
  if form_data[:content] != @post.content
    @post.content = form_data[:content]
    modified = true
  end
  if params[:tags] != @post.get_tags_string
    tag = params[:tags].split(",").uniq
    mapped = @post.tags.map { |x| x.name }
    tag.each do |x|
      @post.tags.create(name: x)
    end
    mapped.each do |t|
      @post.tags.find_by_name(t).destroy
    end
    modified = true
  end

  if modified
    @post.save
    redirect_with_flash("/posts/#{s}", "success", "You have successfully saved the post!")
  else
    redirect_with_flash("/posts/#{s}", "warning", "Nothing to be saved!")
  end
end

# Delete an existing post
delete '/posts/:slug' do |s|
  redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  post = Post.find_by_slug(s)
  redirect_with_flash("/dashboard", "danger", "Post not found! Better luck next time :(") if post.nil?
  redirect_with_flash("/dashboard", "danger", "Access forbidden! You cannot delete this post!") if current_user.id != post.user.id
  post.tags.each do |t|
    t.destroy if t.posts.count == 1
  end
  post.destroy
  redirect_with_flash("/", "success", "Successfully deleted post with title: #{post.title}")
end