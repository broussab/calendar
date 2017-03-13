class AddReasonToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :meetings, :reason, :string
  end
end
