class RelationshipsController < ApplicationController
	def new
		@relationship = Relationship.new
	end
	def create
		@relationship = Relationship.new
		@relationship.first_person_id = params[:first_person_id]
		@relationship.second_person_id = params[:second_person_id]
		if @relationship.save
			flash[:success] = "Added as friend "
			redirect_to relationships_path
		else
			flash[:success] = "Error adding friend"
			redirect_to relationships_path
		end
	end

  def index
		@relationships = Relationship.list_all_relation(session[:user_id])
  end

  def update
  end

	private

	def relation_params
		params.require(:first_person_id).permit(:first_person_id, :second_person_id, :relation)
	end
end
