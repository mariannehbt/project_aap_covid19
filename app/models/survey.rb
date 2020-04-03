class Survey < ApplicationRecord
	belongs_to :user, optional: true

	attr_writer :current_question

	def current_question 
		@current_question || questions.first
	end

	def questions 
		%w[q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20 q21 q22 q23 q24 q25 q26 q27]
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
