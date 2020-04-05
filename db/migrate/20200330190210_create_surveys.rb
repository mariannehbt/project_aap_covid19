class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.datetime :date
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :depression_score
      t.integer :total_score

      t.timestamps
    end
  end
end
