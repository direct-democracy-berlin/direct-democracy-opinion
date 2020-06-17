class AddVoteSummaryToThesis < ActiveRecord::Migration[6.0]
  def change
    add_column :theses, :votes_up, :integer, default: 0, null: false
    add_column :theses, :votes_down, :integer, default: 0, null: false
    add_column :theses, :votes_neutral, :integer, default: 0, null: false
  end
end
