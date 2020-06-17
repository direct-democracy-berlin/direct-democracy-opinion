class AddNullConstraints < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:actions, :action, false)
    change_column_null(:tags, :name, false)

    change_column_null(:theses, :title, false)
    change_column_null(:theses, :creator_id, false)
    change_column_null(:votes, :user_id, false)
    change_column_null(:votes, :thesis_id, false)
    change_column_null(:votes, :vote, false)
    change_column_null(:votes, :user_id, false)
    change_column_null(:tags, :name, false)

    #clean up duplicates leaving only the first vote.
    Vote.select('min(id), count(*)').group('user_id, thesis_id').having('count(*) > 1')
    Vote.select(:user_id, :thesis_id).group(:user_id, :thesis_id).having('count(*) > 1').size.each do |u_id, t_id|
      Vote.where(user_id: u_id, thesis_id: t_id).limit(1000).offset(1).destroy_all
    end
    add_index(:votes, %i[user_id thesis_id], unique: true)
  end
end
