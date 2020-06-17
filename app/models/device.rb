# == Schema Information
#
# Table name: devices
#
#  id             :bigint           not null, primary key
#  name           :string
#  session_name   :string
#  user_agent     :string           not null
#  user_agent_key :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_devices_on_user_agent_key  (user_agent_key)
#  index_devices_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Device < ApplicationRecord
  belongs_to :user

  before_create :apply_defaults

  scope :by_creation_date, -> { order(created_at: :desc) }
  scope :from_user_and_agent, lambda { |user, user_agent|
    where(user: user,
          user_agent_key: Device.generate_key(user_agent))
  }

  def self.generate_key(user_agent)
    client = DeviceDetector.new(user_agent)
    if client.known?
      "#{client.name} - #{client.os_name} - #{client.device_type}"
    else
      'unknown-client'
    end
  end

  def self.generate_name(user_agent)
    client = DeviceDetector.new(user_agent)
    if client.known?
      client.device_name || "#{client.name}(#{client.os_name}) from #{client.device_type}"
    else
      'device'
    end
  end

  private

  def apply_defaults
    self.user_agent_key ||= Device.generate_key(user_agent)
    self.name ||= Device.generate_name(user_agent)
  end
end
