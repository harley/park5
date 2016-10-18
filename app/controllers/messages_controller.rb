class MessagesController < ApplicationController
	before_action :require_user!

	def new
		#@users = User.list_all_user(current_user.id)
		@users = User.list_friend(current_user.id)
		@message = Message.new
	end

	def create
		@message = Message.new message_params
		if @message.save!
			flash[:success] = "Message sent"
			redirect_to outgoing_messages_path
		else
			#//TODO fix error displaying destination page when having error, right now just crash
			flash[:success] = "Error sending message"
			render 'new'
		end
	end

  def incoming
		@incoming_messages = current_user.incoming_messages
  end

  def outgoing
		@outgoing_messages = current_user.outgoing_messages
  end

	def mark_as_read
		@messages = Message.find_by_id(params[:id])
		@messages.read_status = 1
  	@messages.updated_at = Time.now
    if @messages.save
			flash[:success] = "Message Read!"
      redirect_to incoming_messages_path
    else
      render 'index'
    end
	end

	def message_params
  	params.require(:message).permit(:sender_id, :recipient_id, :subject, :body)
  end
end
