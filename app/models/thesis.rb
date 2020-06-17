# frozen_string_literal: true

# == Schema Information
#
# Table name: theses
#
#  id              :bigint           not null, primary key
#  description     :text
#  system_template :string
#  title           :string           not null
#  votes_down      :integer          default(0), not null
#  votes_neutral   :integer          default(0), not null
#  votes_up        :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  creator_id      :bigint           not null
#
# Indexes
#
#  index_theses_on_creator_id       (creator_id)
#  index_theses_on_system_template  (system_template)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#
class Thesis < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }

  belongs_to :creator, class_name: 'User'
  has_many :votes, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  scope :of_user, ->(user) { where(creator: user) }
  scope :voted_by, ->(user) { joins(:votes).where(votes: { user: user }).distinct }

  def vote_of(user)
    votes.where(user_id: user.id).first
  end

  def total_votes
    votes_up + votes_neutral + votes_down
  end

  def percentage_up
    return 0 unless total_votes.positive?

    votes_up.to_f / total_votes
  end

  def percentage_neutral
    return 0 unless total_votes.positive?

    votes_neutral.to_f / total_votes
  end

  def percentage_down
    return 0 unless total_votes.positive?

    votes_down.to_f / total_votes
  end

  def score
    (votes_up - votes_down) / total_votes.to_f
  end

  def cast_vote!(vote)
    raise 'not the expected vote!' unless vote.thesis_id == id

    send("votes_#{vote.vote}=", send("votes_#{vote.vote}") + 1)
    save!
  end

  def uncast_vote!(vote)
    raise 'not the expected vote!' unless vote.thesis_id == id

    send("votes_#{vote.vote}=", send("votes_#{vote.vote}") - 1)
    save!
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(',')
  end
end
