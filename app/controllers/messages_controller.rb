class MessagesController < ApplicationController
	before_action :require_user!

	def new
		#@users = User.list_all_user(current_user.id)
		@users = User.list_friend(current_user.id)
		@message = Message.new
	end

	def create
		@recipients = message_params[:recipient_id]
		@flash_success = ""
		@flash_fail = ""
		if @recipients
			@recipients.each do |recipient|
				
				if recipient.to_i > 0
					@message = Message.new
					@message.sender_id = message_params[:sender_id]
					@message.recipient_id = recipient
					@message.subject = message_params[:subject]
					@message.body = message_params[:body]
					@message.photo = message_params[:photo]
					if @message.save!
						@flash_success << recipient.to_s + ","
					else
						@flash_fail << recipient.to_s + ","
					end
				end
			end

			if @flash_success.length > 0
				@flash_success = "Message sent to " + @flash_success + ". "
			end

			if @flash_fail.length > 0
				@flash_fail = "Message not sent to " + @flash_fail
			end
			flash[:success] = @flash_success + @flash_fail
			redirect_to outgoing_messages_path
		end
	end

  def incoming
		@incoming_messages = current_user.incoming_messages
  end

  def outgoing
		@outgoing_messages = current_user.outgoing_messages
  end

	# def mark_as_read
	# 	@messages = Message.find_by_id(params[:id])
	# 	@messages.read_status = 1
  # 	@messages.updated_at = Time.now
  #   if @messages.save
	# 		flash[:success] = "Message Read!"
  #     redirect_to incoming_messages_path
  #   else
  #     render 'index'
  #   end
	# end

	def show
		@message = Message.find_by_id(params[:id])
		if @message.read_status == nil 
			@message.read_status = @message.read_status.to_i + 1
			@message.save
		else
			@message.body = nil
		end
	end

	private 

	def message_params
		params[:message][:recipient_id] ||= []
  	params.require(:message).permit(:sender_id, :subject, :body, :photo, :recipient_id => [])
  end
end
