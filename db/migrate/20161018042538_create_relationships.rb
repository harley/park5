class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :first_person_id, index: true
      t.integer :second_person_id, index: true
      t.integer :relation

      t.timestamps
    end
  end
end
