class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.string :token, null: false, index: { unique: true }
      t.references :user, foreign_key: true, null: false
      t.string :action
      t.jsonb :payload

      t.timestamps
    end
  end
end
