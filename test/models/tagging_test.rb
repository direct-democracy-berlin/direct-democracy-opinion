# == Schema Information
#
# Table name: taggings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :bigint           not null
#  thesis_id  :bigint           not null
#
# Indexes
#
#  index_taggings_on_tag_id     (tag_id)
#  index_taggings_on_thesis_id  (thesis_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id)
#  fk_rails_...  (thesis_id => theses.id)
#
require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
