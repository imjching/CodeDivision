get '/' do
  erb :form
end

post '/' do
  user_input = params[:user_input]
  redirect to("/#{user_input}") if !user_input.nil?
  redirect to("/")
end

get '/:word' do |word|
  @user_input = word
  @param = Word.find_by_name(word)
  erb :anagrams_list
end