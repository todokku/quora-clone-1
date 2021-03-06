
get '/users' do
	if logged_in?
		@questions=Question.all
		erb :"users/index"
	else
		@error = "Not logged in"
		erb :"static/index"
	end
end


post "/signup" do
	@questions=Question.all
	user=User.new(params[:user])
	if user.save
		session[:user_id] = user.id
		redirect '/'

	else
		@error = user.errors.full_messages #@error allows html to read the var
		erb :"static/login"
	end
end

get '/users/profile' do
	if logged_in?
		@questions=Question.all
		@user=current_user
		erb :"users/show"
	else
		@error = "Not logged in"
		erb :"static/index"
	end
end


get '/users/:id' do
	@questions=Question.all
	@user=User.find(params[:id])
	erb :"users/show"
end


post '/logout' do
	session[:user_id] = nil
	redirect '/'
end


post '/login' do
	user = User.authenticate(params[:user][:email], params[:user][:password])
	if user
		@questions=Question.all
		session[:user_id]=user.id
		redirect '/' 
	else
		@error = "Wrong password or email"
		erb :"static/login"
	end

end

# post "/create_username" do
# 	User.addName(session[:user_id], params[:user][:name])	
# 	'/homepage'
# end





get '/login' do
	@questions=Question.all
	erb :"static/login"
end