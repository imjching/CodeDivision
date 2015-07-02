# To display all the urls
get '/' do
  @public_urls = Url.where(user_id: nil).order(:created_at)
  if logged_in?
    @my_urls = current_user.urls.order(:created_at)
  end
  erb :index
end