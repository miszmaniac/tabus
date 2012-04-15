# == Schema Information
#
# Table name: cards
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  prompt1    :string(255)
#  prompt2    :string(255)
#  prompt3    :string(255)
#  prompt4    :string(255)
#  prompt5    :string(255)
#  times_used :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# -*- encoding : utf-8 -*-
require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
