# Shows all posts with a given tag
get '/tag/:name' do |tag|
  @tags = Tag.where(name: tag)
  redirect_error("/", "Tag not found.") if @tags.empty?
  erb :tag_show
end