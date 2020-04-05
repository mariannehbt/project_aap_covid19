class AddSurveyidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :surveyid, :integer
    add_index :users, :surveyid, unique: true
  end
end
