# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :comments
end
