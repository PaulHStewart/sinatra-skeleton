# this sets up an instance variable of @current_user
# if there is a user_id stored in session. If not this method
# will return nil and we don't have a logged in user
helpers do
	def current_user
		@current_user = User.find_by(id: session[:user_id]) if session[:user_id]
	end
end

before do
	redirect '/login' if !current_user && request.path != '/login' && request.path != '/signup'
end

# Homepage (Root path)
get '/' do
	@posts = Post.all.reverse
  	erb :index
end

get '/login' do
	erb :login
end

get '/signup' do
	erb :signup
end

get '/profile' do
	erb :profile
end

get '/posts/create' do
	erb :new_posts
end

get '/posts/:id' do
	@post=Post.find(params[:id])
	erb :post 
end

post '/posts/:id/comments/new' do #this shows the comments on posts
	comment = params[com]

	post = Post.find(params[:id])
	post.comments.create user_id: current_user.id, body: comment

	redirect "/posts/#{params[:id]}"
end

post '/login' do
	email=params[:email]
	psw=params[:psw]
	user=User.find_by(email:email)
	if user && psw == user.password 
		session[:user_id] = user.id 
		redirect '/posts/create'
	end
	redirect '/login'
end

post '/signup' do
	email=params[:email]
	psw=params[:psw]
	user=User.find_by(email:email)
	if user 
		redirect '/login'
	else
		user=User.create(email:email, password:psw)
		session[:user_id] = user.id
		redirect '/posts/create'
	end
end

post '/posts/create' do #this ties in to the action <form action="/posts/create" at the top of the posts form (.erb)
	category=params[:category]
	url=params[:url]
	title=params[:title]
	description=params[:description]
	post=current_user.posts.create(category:category, url:url, title:title, description:description)
	redirect "/posts/#{post.id}" #redirect the user to the post they just posted
end

post '/profile' do
	redirect '/'
end

get '/profile/edit' do
	current_user
	erb :profile
end

post '/profile/edit' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	email = params[:email]
	password = params[:password]
	gender = params[:gender]
	current_user.update first_name: first_name, last_name: last_name, email: email, password: password, gender: gender
	redirect '/'
end