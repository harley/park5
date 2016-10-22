class UserMailer < ApplicationMailer
	default from: 'viettrungsq@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

	def new_msg_recieved_noti(user, url)
    @user = user
    @url  = url
    mail(to: @user.email, subject: 'You have one new message')
	end

	def sent_msg_seen_noti(user, read_time, recipient)
    @user = user
    @readtime = read_time
		@recipient = recipient
    mail(to: @user.email, subject: 'Your message is read')
	end
end
