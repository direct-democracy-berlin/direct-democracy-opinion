class CreateTableVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :thesis, foreign_key: { on_delete: :cascade }
      t.string :vote, required: true
      t.timestamps null: false
    end

  end
end
