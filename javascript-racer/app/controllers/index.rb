get '/' do
  @games = Game.all
  erb :index
end

post '/new_game' do
  if session[:player1] || session[:player2]
    session.clear
    session[:alert] = "You have already started a game. Please start again."
    redirect to '/'
  end
  if params[:player1].downcase == params[:player2].downcase
    session.clear
    session[:alert] = "Please choose different initials for both players."
    redirect to '/'
  end
  if params[:player1] == "" || params[:player2] == ""
    session.clear
    session[:alert] = "Please enter initials for both players."
    redirect to '/'
  end
  session[:player1] = params[:player1]
  session[:player2] = params[:player2]
  redirect to '/start_game'
end

get '/start_game' do
  if session[:player1].nil? || session[:player2].nil?
    session.clear
    session[:alert] = "Please initiate a game!"
    redirect to '/'
  end
  session[:start_time] = Time.now
  erb :start_game
end

post '/end_game' do
  # Should actually check if hacking occurs here (0 < position < 58)
  game = Game.create(time_taken: Time.now - session[:start_time])
  player1 = Player.find_or_create_by(initials: session[:player1])
  player1.games_players.create(player_number: 1, player_position: params[:player1_position], game_id: game.id)
  player2 = Player.find_or_create_by(initials: session[:player2])
  player2.games_players.create(player_number: 2, player_position: params[:player2_position], game_id: game.id)
  session.clear
  redirect to '/'
end

get '/replay/:id' do |id|
  @game = Game.where(id: id)
  if @game.empty?
    session[:alert] = "Game not found!"
    redirect to '/'
  end
  @game_player = GamesPlayer.where(game_id: id)
  erb :view_game
end