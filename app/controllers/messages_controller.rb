class MessagesController < ApplicationController
	before_action :require_user!

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

#	def message_params
#  	params.require(:message).permit(:id)
#  end
end
