class AddAdditionalFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :vanity_name, :string, required: true
    add_column :users, :steam_id, :string
  end
end
