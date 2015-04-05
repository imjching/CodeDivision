get '/' do
  @albums = Album.all.sample(16)
  erb :index
end
