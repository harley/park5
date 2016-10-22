class BlocklistsController < ApplicationController
	before_action :require_user!
	def new
	end
	def create
	end
	def show
	end
  def index
		# @relationships = Relationship.list_friend(session[:user_id])
		#Work without block function: @friendlist = User.list_friend(session[:user_id])
		#NOT WORK @friendlist = Relationship.list_all_friend(session[:user_id])

		#load friend only
		@blocklists = BlockedFriend.where(user_id: current_user.id)
  end

	def destroy
		@blocklist = BlockedFriend.find_by_id(params[:id])
		@blocklist.destroy
		flash[:success] = "User removed from block list"
		redirect_to blocklists_path
	end
	private

	def relation_params
		params.require(:blocklist).permit(:friend_id)
	end
end
