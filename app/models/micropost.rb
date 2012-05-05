class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  # Returns microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  def self.from_users_followed_by(user)
	#http://ruby.railstutorial.org/chapters/following-users?version=3.2#sec:a_first_feed_implementation
    followed_user_ids = user.followed_user_ids.join(', ')
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end

  private

    # Returns an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
	#RUBY HERE DOC:
      followed_user_ids = %(SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id)
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
            { user_id: user })
    end
end
