class AddReadStatusToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :read_status, :integer
  end
end
