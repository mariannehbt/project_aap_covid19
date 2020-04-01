class RegistrationsController < Devise::RegistrationsController
  after_action :link_survey_to_user, only: :create

  def link_survey_to_user
  	current_user.surveys << Survey.last
  end

  protected

  def after_sign_up_path_for(user)
    :new_survey
  end
end