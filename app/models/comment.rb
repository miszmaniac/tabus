# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  attr_accessible :comment, :user_id

  belongs_to :user
  validates :content, :length => { :maximum => 140 }
end
