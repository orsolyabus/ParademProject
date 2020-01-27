class AddValueToRsvps < ActiveRecord::Migration[6.0]
  def change
    add_column :rsvps, :response, :integer
  end
end
