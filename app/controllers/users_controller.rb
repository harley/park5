class UsersController < ApplicationController
	
	def new
		@user = User.new
	end
	def create
		#WRONG: @user = User.create(email: user_params[:email],password_digest: user_params[:password])
		@user = User.new user_params
		if @user.save
			flash[:success] = "User created successfully"
			#TODO: sign user in without logging in
			#TODO: email user //implement email function using ACTION MAILER
			session[:user_id] = @user.id
			redirect_to incoming_messages_path
		else
			render 'new'
		end
	end

	def index
		@users = User.list_all_user(session[:user_id])
	end

	def show
		
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
