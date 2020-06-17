class AddTutorialFirstThesisAndRenameInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :intro_done, :tutorial_welcome
    add_column :users, :tutorial_first_thesis, :boolean, default: false
  end
end
