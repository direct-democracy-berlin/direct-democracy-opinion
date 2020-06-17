class CreateDevicesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :user_agent, null: false
      t.string :user_agent_key, null: false, index: true
      t.string :session_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # User.each { |u| u.devices.create!(name: 'unknown', user_agent: 'dummy') }
  end
end
