# Create new album (create)
post '/albums' do
  redirect to '/' if !logged_in?

  @album = current_user.albums.new(album_params)
  if @album.save
    flash[:success] = "Successfully created album: #{@album.name}"
  else
    flash[:form_errors] = @album.errors.full_messages
  end
  redirect to "/users/#{current_user.id}"
end

# every photo in an album at a URL like
# view all photos (show)
get '/albums/:album_id' do |album_id|
  @album = Album.find_by_id(album_id)
  if @album.nil?
    flash[:danger] = "Invalid album id."
    redirect to '/'
  end
  erb :'albums/show'
end

# upload photo in an album at a URL like (create/photo)
post '/albums/:album_id' do |album_id|
  redirect to '/' if !logged_in?

  @album = Album.find_by_id(album_id)
  if @album.nil?
    flash[:danger] = "Invalid album id."
    redirect to '/'
  end
  redirect to '/' if @album.user_id != current_user.id

  begin
    @photo = @album.photos.new
    @photo.photo_path = params[:filename]
    @photo.caption = params[:photo][:caption]
    @photo.save!
    flash[:success] = "Successfully uploaded photo."
  rescue Exception => e
    flash[:form_errors] = [e.message]
  end
  redirect to "/albums/#{album_id}"
end

# edit album name (edit)
patch '/albums/edit' do
  redirect to '/' if !logged_in?

  @album = Album.find_by_id(params[:album][:id])
  if @album.nil? ||  @album.user_id != current_user.id
    flash[:danger] = "Invalid album id."
  elsif @album.update_attributes(album_params)
    flash[:success] = "Successfully updated the album: #{@album.name}"
  else
    flash[:form_errors] = @album.errors.full_messages
  end

  redirect to "/users/#{current_user.id}"
end

# destroy album
delete '/albums/:album_id' do |album_id|
  redirect to '/' if !logged_in?

  @album = Album.find_by_id(album_id)
  if @album.nil? ||  @album.user_id != current_user.id
    byebug
    status 404
    return
  end

  @album.destroy
end

def album_params
  params.require(:album).permit(:name)
end

def photo_params
  params.require(:photo).permit(:photo_path, :caption)
end