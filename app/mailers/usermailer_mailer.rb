class UsermailerMailer < ApplicationMailer

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: "welcome to my library")
	end
end
