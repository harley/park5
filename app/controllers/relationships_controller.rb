class RelationshipsController < ApplicationController
	def new
		@relationship = Relationship.new
	end
	def create
		@check_relation = Relationship.check_relation_exist(params[:first_person_id],params[:second_person_id])
		if @check_relation
				flash[:error] = "Already added this User as Friend"
				redirect_to users_path
		else
			@relationship = Relationship.new
			@relationship.first_person_id = params[:first_person_id]
			@relationship.second_person_id = params[:second_person_id]
			if @relationship.save
				flash[:success] = "Added as friend "
				redirect_to relationships_path
			else
				flash[:error] = @relationship.errors.full_messages.to_sentence
				redirect_to users_path
			end
		end
	end

  def index
		# @relationships = Relationship.list_friend(session[:user_id])
		#Work without block function: @friendlist = User.list_friend(session[:user_id])
		#NOT WORK @friendlist = Relationship.list_all_friend(session[:user_id])

		#load friend only
		@friendlist = Relationship.list_all_friend(session[:user_id])
  end

  def update
    respond_to do |format|
			if params[:relation] == nil
				raise 'nil'
				redirect_to relationships_path
			elsif params[:relation] == 1
				raise 'block'
				redirect_to relationships_path
			else
				raise 'new action'
				render 'show'
			end
    end
  end
	
	def show
		@relationship = Relationship.find_by_id(params[:id])
	end

	def blocklist
		#@blocklist = Relationship.where(first_person_id: current_user.id, relation: 1) + Relationship.where(second_person_id: current_user.id, relation: 1)
		@blocklist = BlockedFriend.where(user_id: current_user.id)
	end

	def block_user
		@relationship = Relationship.find_by_id(params[:id])
		@user_id_to_block = @relationship.first_person_id == current_user.id ? @relationship.second_person_id : @relationship.first_person_id
		@blocked_friend = BlockedFriend.new
		@blocked_friend.user_id = current_user.id
		@blocked_friend.friend_id = @user_id_to_block
    if @blocked_friend.save
			flash[:success] = "User added to block list"
      redirect_to blocklists_path
    else
      render 'show'
    end
	end

	def unblock_user
		@relationship = Relationship.find_by_id(params[:id])
		@relationship.relation = nil
  	@relationship.updated_at = Time.now
    if @relationship.save
			flash[:success] = "User removed from block list"
      redirect_to relationships_path
    else
      render 'show'
    end
	end

	def destroy
		@relationship = Relationship.find_by_id(params[:id])
		@relationship.destroy
		flash[:success] = "Friend removed"
		redirect_to relationships_path
	end
	private

	def relation_params
		params.require(:relationship).permit(:first_person_id, :second_person_id, :relation, :id)
	end
end
