# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  comment    :string(255)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  attr_accessible :comment, :user_id

  belongs_to :user
  validates :content, :length => { :maximum => 140 }
end
