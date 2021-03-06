class SessionsController < ApplicationController
	def new
	end

	def create
		if @user = User.find_by_email(params[:email])
			if @user.authenticate(params[:password])
				session[:user_id] = @user.id
				flash[:success] = "Logged in successfully."
				redirect_to incoming_messages_path
			else
				flash.now[:error] = "Incorrect password."
				render 'new'	
			end
		else
			flash.now[:error] = "User not found."
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Logged Out! Bye bye"
		redirect_to root_path
	end

	def callback
		
		@user = User.from_omniauth(env["omniauth.auth"])
    if @user
			session[:user_id] = @user.id
			flash[:success] = "Logged in successfully."
			redirect_to incoming_messages_path
    else
    	flash[:error] = @user.errors.full_messages.to_sentence
			redirect_to root_path
    end
  end

end
