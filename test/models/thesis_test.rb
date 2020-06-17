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
require 'test_helper'

class ThesisTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
