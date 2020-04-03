class UserMailer < ApplicationMailer
	default from: 'covipsy19@gmail.com'

	def welcome_email(user)
		@user = user
		@url  = 'https://project-aap-covid19.herokuapp.com/users/sign_in'
		mail(to: @user.email, subject: 'Bienvenue sur Covipsy19 !')
	end
end
