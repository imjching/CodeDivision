get '/' do
  @urls = Url.all
  erb :index
end

post '/urls' do
  url = Url.create(params[:form])
  unless url.valid?
    session[:flash_type] = "danger"
    session[:flash_message] = "Url entered #{url.errors[:redirect_url][0]}"
    redirect to '/'
    return
  end
  session[:flash_type] = "success"
  session[:flash_message] = "Short url generated: <a href=\"/#{url.short_uri}\">#{url.short_uri}</a>"
  redirect to '/'
end

get '/:short_uri' do |s|
  url = Url.find_by_short_uri(s)
  unless url
    session[:flash_type] = "danger"
    session[:flash_message] = "Invalid short url!"
    redirect to '/'
    return
  end
  url.url_visit
  redirect to url.redirect_url
end