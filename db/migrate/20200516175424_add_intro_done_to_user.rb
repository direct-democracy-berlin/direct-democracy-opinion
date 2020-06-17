class AddIntroDoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :intro_done, :boolean, default: false
  end
end
