class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	helper_method :current_user #provide access to :current_user function for views

	protected
	#this function getting data from session object to pass to view layer
	def current_user
		return @current_user if @current_user
		if session[:user_id]
			@current_user = User.find session[:user_id]
		end
	end
end
