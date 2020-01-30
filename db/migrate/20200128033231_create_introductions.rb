class CreateIntroductions < ActiveRecord::Migration[6.0]
  def change
    create_table :introductions do |t|
      t.references :contact,  null: false, foreign_key: true
      t.references :introduced_by, null: false
      t.integer :relationship

      t.timestamps
    end
    
    add_foreign_key :introductions, :contacts, column: :introduced_by_id
  end
end
