# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thesis_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_votes_on_thesis_id              (thesis_id)
#  index_votes_on_user_id                (user_id)
#  index_votes_on_user_id_and_thesis_id  (user_id,thesis_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (thesis_id => theses.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class Vote < ApplicationRecord
  after_create -> { thesis.cast_vote!(self) }
  after_destroy -> { thesis.uncast_vote!(self) }

  belongs_to :user
  belongs_to :thesis

  enum vote: { up: 'up', neutral: 'neutral', down: 'down' }

  def self.vote_to_icon(vote)
    case vote.to_sym
    when :up
      'fa-thumbs-up'
    when :down
      'fa-thumbs-down'
    when :neutral
      'fa-equals'
    end
  end

  def icon
    vote_to_icon vote
  end

  def voted?(vote)
    self.vote == vote.to_s
  end

end
