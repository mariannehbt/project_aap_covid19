class SurveysController < ApplicationController
  
	def show
		@survey = Survey.find(params[:id])
	end

  def new
  	session[:survey_params] ||= {}
  	@survey = Survey.new(session[:survey_params])
  	@survey.current_question = session[:survey_question]
  end

  def create 
  	session[:survey_params].deep_merge!(params[:survey].permit!) if params[:survey]
  	@survey = Survey.new(session[:survey_params])
  	@survey.current_question = session[:survey_question]
  	if params[:back_button]
  		@survey.previous_question
  	elsif @survey.last_question?
  		@survey.save
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


  def show
    @survey = Survey.find(params[:id])
  end

  def index
  end 


  private 

  def depression_score
    @survey = Survey.find(params[:id])
    return @survey.q1 + @survey.q2 + @survey.q3
  end

end
