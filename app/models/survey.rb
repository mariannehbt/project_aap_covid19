class Survey < ApplicationRecord
	belongs_to :user, optional: true

	attr_writer :current_question

	def current_question 
		@current_question || questions.first
	end

	def questions 
		%w[q1 q2 q3]
	end

	def next_question 
		self.current_question = questions[questions.index(current_question)+1]
	end

	def previous_question 
		self.current_question = questions[questions.index(current_question)-1]
	end

	def first_question?
		current_question == questions.first
	end

	def last_question?
		current_question == questions.last
	end

end
