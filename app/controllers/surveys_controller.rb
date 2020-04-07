class SurveysController < ApplicationController
  layout 'survey', :except => :show

  def show
    @survey = Survey.find(params[:id])
    if params[:search] && params[:search] != ''
      @cmps = Cmp.near(params[:search], 150, units: :km, :order => :distance)
      results = Geocoder.search(params[:search])
      @coord = results.first.coordinates
    else
      @cmps = Cmp.all
    end
  end

  def new
  	session[:survey_params] ||= {}
  	@survey = Survey.new(session[:survey_params])
  	@survey.current_question = session[:survey_question]
    delete_survey_of_today
  end

  def create
  	session[:survey_params].deep_merge!(params[:survey].permit!) if params[:survey]
  	@survey = Survey.new(session[:survey_params])
  	@survey.current_question = session[:survey_question]
  	if params[:back_button]
  		@survey.previous_question
  	elsif @survey.last_question?
      if user_signed_in?
        @survey.user = current_user
        @survey.save
      else
  	   	@survey.save
      end
  	else
  		@survey.next_question
  	end
  	session[:survey_question] = @survey.current_question
  	if @survey.new_record?
  		render "new"
  	else
  		session[:survey_question] = session[:survey_params] = nil
  		flash[:notice] = "Merci de confirmer vos réponses."
  		redirect_to edit_survey_path(@survey)
  	end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update(params[:survey].permit!)
      @survey.update(depression_score: depression_score)
      flash[:notice] = "Votre questionnaire a bien été enregistré."
      redirect_to @survey
    else
      render "edit"
    end
  end

  def destroy
    @surveys = current_user.surveys
    @surveys.each do |survey|
      survey.destroy
    end
    flash[:notice] = "Vos données liées aux questionnaires ont bien été supprimées."
    redirect_to edit_user_registration_path
  end

  def index
  end


  private

  def depression_score
    @survey = Survey.find(params[:id])
    return @survey.q1 + @survey.q2 + @survey.q3 + @survey.q4 + @survey.q5 + @survey.q6 + @survey.q7 + @survey.q8 + @survey.q9 + @survey.q10 + @survey.q11 + @survey.q12 + @survey.q13 + @survey.q14 + @survey.q15 + @survey.q16 + @survey.q17 + @survey.q18 + @survey.q19 + @survey.q20 + @survey.q21 + @survey.q22 + @survey.q23 + @survey.q24 + @survey.q25 + @survey.q26 + @survey.q27
  end

  def delete_survey_of_today
    if user_signed_in? && current_user.surveys.last 
      if current_user.surveys.last.created_at.strftime("%d/%m/%y") == Date.today.strftime("%d/%m/%y") 
        #delete the survey of today if user wants to take another one on same day
        current_user.surveys.last.delete
      end
    end
  end

end
