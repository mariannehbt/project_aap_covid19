class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :only_see_own_page, only: :show

  def show
  	@user = User.find(params[:id])
  end

	def only_see_own_page
	  @user = User.find(params[:id])
	  if current_user != @user
	    redirect_to root_path, notice: "Vous n'avez pas accès à cette page."
	  end
	end

	def set_frequency
		current_user.update(notification_frequency: params[:notification_frequency].downcase)

		if current_user.save
			redirect_to current_user, notice: "La fréquence a été configurée avec succès"
		else
			redirect_to current_user, notice: "Une erreur s'est produite lors de la configuration de votre fréquence"
		end
	end
end
