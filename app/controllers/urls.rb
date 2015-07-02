post '/urls' do
  form_data = params[:form]
  redirect_with_flash("/", "danger", "Invalid url entered!") if form_data.nil?

  if !form_data[:user_id].nil?
    if logged_in?
      redirect_with_flash("/", "danger", "Invalid url entered!") if form_data[:user_id].to_i != current_user.id
    else
      redirect_with_flash("/", "danger", "Invalid url entered!")
    end
  end

  url = Url.create(form_data)
  redirect_with_flash("/", "danger", "Url entered #{url.errors[:redirect_url][0]}") unless url.valid?
  redirect_with_flash("/", "success", "Short url generated: <a href=\"/#{url.short_uri}\">#{url.short_uri}</a>")
end

get '/:short_uri' do |s|
  url = Url.find_by_short_uri(s)
  redirect_with_flash("/", "danger", "Invalid short url!") unless url
  url.url_visit
  redirect to url.redirect_url
end

delete '/:short_uri' do |s|
  redirect_with_flash("/login", "danger", "Please login to proceed.") if !logged_in?
  url = Url.find_by_short_uri(s)
  redirect_with_flash("/", "danger", "Invalid short url!") unless url
  redirect_with_flash("/", "danger", "This url cannot be deleted!") if url.user.nil?
  redirect_with_flash("/", "danger", "Permission denied!") if url.user.id != current_user.id
  url.destroy
  redirect_with_flash("/", "success", "Successfully deleted short url: <a href=\"/#{url.short_uri}\">#{url.short_uri}</a>")
end