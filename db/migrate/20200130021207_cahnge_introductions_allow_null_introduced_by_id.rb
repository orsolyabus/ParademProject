class CahngeIntroductionsAllowNullIntroducedById < ActiveRecord::Migration[6.0]
  def change
    change_column :introductions, :introduced_by_id, :integer, :null => true
  end
end
