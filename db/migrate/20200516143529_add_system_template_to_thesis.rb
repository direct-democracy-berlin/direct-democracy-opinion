class AddSystemTemplateToThesis < ActiveRecord::Migration[6.0]
  def change
    add_column :theses, :system_template, :string
    add_index :theses, :system_template
  end
end
