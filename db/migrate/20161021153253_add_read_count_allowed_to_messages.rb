class AddReadCountAllowedToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :read_count_allowed, :integer
  end
end
