# a particular photo at a URL like
get '/albums/:album_id/:photo_id' do |album_id, photo_id|
  @photo = Photo.find_by_id(photo_id)
  if @photo.nil? || @photo.album.id != album_id.to_i
    flash[:danger] = "Invalid photo id."
    redirect to "/albums/#{album_id}"
  end
  erb :'/albums/photos/show'
end

# update photo, perhaps new caption
patch '/albums/:album_id/:photo_id' do |album_id, photo_id|
  redirect to '/' if !logged_in?

  @photo = Photo.find_by_id(photo_id)
  if @photo.nil? ||  @photo.album.id != album_id.to_i || @photo.album.user_id != current_user.id
    flash[:danger] = "Invalid photo id."
  elsif @photo.update_attributes(photo_params)
    flash[:success] = "Successfully updated the photo!"
  else
    flash[:form_errors] = @photo.errors.full_messages
  end

  redirect to "/albums/#{album_id}/#{photo_id}"
end

# delete photo
delete '/albums/:album_id/:photo_id' do |album_id, photo_id|
  redirect to '/' if !logged_in?

  @photo = Photo.find_by_id(photo_id)
  if @photo.nil? ||  @photo.album.id != album_id.to_i || @photo.album.user_id != current_user.id
    flash[:danger] = "Invalid photo id."
  end
  @photo.destroy

  flash[:success] = "Successfully deleted the photo!"
  redirect to "/albums/#{album_id}"
end

def photo_params
  params.require(:photo).permit(:caption)
end