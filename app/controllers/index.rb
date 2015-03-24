require 'json'

# A page that lists all the categories
# Choose a category to browse
get '/' do
  @cat = Category.all
  erb :index
end

# A page that lists all the postings in a given category
# View all postings in a particular category
get '/categories/:slug' do |s|
  @cat = Category.find_by_slug(s)
  if @cat.nil?
    session[:flash_message] = "Category not found! Better luck next time :("
    redirect to("/")
  else
    @posts = @cat.posts
    erb :categories_show
  end
end

# A page that lets someone create a new posting in a given category
# Create my own posting
post '/posts' do
  # Check for nil values
  if params[:category].nil? || params[:title].nil? || params[:content].nil? || params[:email].nil?
    render_json({success: 0, message: "Please try again later."})
    return
  end

  # Check if category exists
  cat = Category.find_by_name(params[:category])
  if cat.nil?
    render_json({success: 0, message: "Invalid category."})
    return
  end

  begin
    new_post = cat.posts.create!(title: params[:title], content: params[:content], author_email: params[:email])
    render_json({success: 1,
                title: new_post.title,
                slug: new_post.slug,
                id: new_post.author_key,
                author_email: new_post.author_email,
                content_simplified: new_post.content[0, 150]})
  rescue
    render_json({success: 0, message: "Title already exists."})
  end
end

# View a particular posting
get '/posts/:slug' do |s|
  @post = Post.find_by_slug(s)
  if @post.nil?
    session[:flash_message] = "Post not found! Better luck next time :("
    redirect to("/")
  else
    erb :post_show
  end
end

# Edit a particular posting
get '/posts/:slug/edit' do |s|
  @post = Post.find_by_slug(s)
  if @post.nil?
    session[:flash_message] = "Post not found! Better luck next time :("
    redirect to("/")
    return
  end
  if params[:id].nil? || (!params[:id].nil? && params[:id] != @post.author_key)
    session[:flash_message] = "Wrong secret key!"
    redirect to("/posts/#{s}")
    return
  end
  erb :post_edit
end

# UPDATE
# A page that lets someone who has created a page return to edit/update the page
# Edit my postings by using the "secret key" that I get after creating my posting
post '/posts/:slug' do |s|
  @post = Post.find_by_slug(s)
  if @post.nil?
    session[:flash_message] = "Post not found! Better luck next time :("
    redirect to("/")
    return
  end
  if params[:id].nil? || (!params[:id].nil? && params[:id] != @post.author_key)
    session[:flash_message] = "Access forbidden!"
    redirect to("/posts/#{s}")
    return
  end
  modified = false
  if params[:content] != @post.content
    @post.content = params[:content]
    modified = true
  end
  if params[:email] != @post.author_email
    @post.author_email = params[:email]
    modified = true
  end
  if modified
    @post.save
    session[:type_message] = "success"
    session[:success_message] = "You have successfully saved the post!"
  else
    session[:type_message] = "warning"
    session[:success_message] = "Nothing to be saved!"
  end

  redirect to("/posts/#{s}")
end

# Helper methods (TODO: Put into helpers)
def render_json(response)
  content_type :json
  response.to_json
end