class AddNotificationFrequencyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notification_frequency, :string
  end
end
