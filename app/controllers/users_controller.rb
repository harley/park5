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
			redirect_to root_path
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
