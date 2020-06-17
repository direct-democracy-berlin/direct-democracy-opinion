# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  admin                 :boolean          default(FALSE), not null
#  confirmation_sent_at  :datetime
#  confirmation_token    :string
#  confirmed_at          :datetime
#  current_sign_in_at    :datetime
#  current_sign_in_ip    :string
#  email                 :string
#  last_sign_in_at       :datetime
#  last_sign_in_ip       :string
#  name                  :string
#  remember_created_at   :datetime
#  sign_in_count         :integer          default(0), not null
#  tutorial_first_thesis :boolean          default(FALSE)
#  tutorial_welcome      :boolean          default(FALSE)
#  unconfirmed_email     :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token  (confirmation_token) UNIQUE
#  index_users_on_email               (email) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :database_authenticatable, :recoverable
  devise :trackable, :registerable, :rememberable, :confirmable

  has_many :theses, foreign_key: 'creator_id'
  has_many :actions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :devices, dependent: :destroy
  accepts_nested_attributes_for :devices

  before_save :fill_nil
  before_create :apply_defaults

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :unconfirmed_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  # DEVISE
  # def after_confirmation
  #   self.name = email if name == ANONYM_NAME
  # end

  #
  def device(user_agent)
    Device.
    devices.select { |d| }
  end

  def fill_nil
    self.email = nil if !email.nil? && email.empty?
  end

  def registered?
    !email.nil?
  end

  def apply_defaults
    self.name ||= email || 'anonymous'
  end

  def merge_from(other_user)
    Rails.logger.info 'merging user...'
    User.transaction do
      raise 'May only merge an anonym user' if other_user.confirmed?

      Thesis.where(creator: other_user).update_all creator_id: id

      # merge votes (find duplicates!)
      thesis_voted = votes.pluck(:thesis_id).map { |e| [e, true] }.to_h
      new_votes = other_user.votes.reject { |v| thesis_voted.key? v.thesis_id }
      same_votes = other_user.votes.select { |v| thesis_voted.key? v.thesis_id }
      Vote.where(id: new_votes).update_all user_id: id
      # remove same votes?

      other_user_device = other_user.devices.by_creation_date.first
      device = Device.from_user_and_agent(self, other_user_device.user_agent).first
      if device
        # device is known, reset session name
        device.update session_name: nil
      else
        devices.create!(user_agent: other_user_device.user_agent)
      end
    end
  end

end
