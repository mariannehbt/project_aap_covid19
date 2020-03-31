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
  		flash[:notice] = "Questionnaire enregistré"
  		redirect_to @survey
  	end
  end

  def edit
  end

  def show
  end

  def index
  end 

end
