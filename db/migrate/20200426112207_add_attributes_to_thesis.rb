class AddAttributesToThesis < ActiveRecord::Migration[6.0]
  def change
    add_reference :theses, :creator, foreign_key: { to_table: :users }
  end
end
