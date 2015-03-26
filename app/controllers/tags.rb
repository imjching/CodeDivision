# Show me all posts with a given tag
get '/tag/:name' do |tag|
  #redirect_with_flash("/login", "danger", "Access forbidden! Please login to continue.") if !logged_in?
  tagg = Tag.where(name: tag)
  @posts = []
  tagg.each do |x|
    @posts << x.posts.first
  end
# Part.joins(:category).joins(:brands).where(category: {name: 'car'}).select(brands.name).distinct
  redirect_with_flash("/", "danger", "Tag not found.") if tagg.empty?
  @tag = tag
  erb :posts_show
end