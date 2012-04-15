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
class Card < ActiveRecord::Base
  attr_accessible :prompt1, :prompt2, :prompt3, :prompt4, :prompt5, :title
end
