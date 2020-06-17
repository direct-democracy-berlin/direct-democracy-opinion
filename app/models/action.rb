# == Schema Information
#
# Table name: actions
#
#  id         :bigint           not null, primary key
#  action     :string           not null
#  payload    :jsonb
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_actions_on_token    (token) UNIQUE
#  index_actions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Action < ApplicationRecord
  before_create :set_token_of_required

  belongs_to :user

  scope :user_action, ->(user, action) { where(user: user, action: action) }

  def set_token_of_required
    self.token ||= Devise.friendly_token
  end
end
