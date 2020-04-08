class AddScoreToSurvey < ActiveRecord::Migration[5.2]
  def change
  	add_column :surveys, :anxiety_score, :integer
  	add_column :surveys, :addiction_score, :integer
  	add_column :surveys, :abuse_score, :integer
  end
end
