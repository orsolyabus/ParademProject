class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.references :user, foreign_key: true
      t.string :email_primary
      t.string :label_email_primary
      t.string :phone_primary
      t.string :label_phone_primary
      t.string :email_secondary
      t.string :label_email_secondary
      t.string :phone_secondary
      t.string :label_phone_secondary
      t.string :organisation
      t.text :notes
      t.timestamps
    end
  end
end
