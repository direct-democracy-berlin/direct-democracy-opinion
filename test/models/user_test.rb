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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'merge' do
    anonym = users(:anonym)
    registered = users(:registered)

    assert_equal 1, anonym.theses.count
    assert_equal 1, registered.theses.count

    assert_equal 2, anonym.votes.count
    assert_equal 1, anonym.theses.count

    assert_equal 3, Vote.count

    registered.merge_from(anonym)

    assert_equal 2, registered.reload.theses.count
    # the two voted the same
    assert_equal 2, registered.reload.votes.count
    assert_equal 2, Vote.count


  end
end
