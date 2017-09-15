class Micropost < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true;
	default_scope -> { order ('created_at desc') }
	validates :content, presence: true, length: {maximum: 140}

	def self.from_users_followed_by(user)
       followed_user_ids = "SELECT followed_id FROM relationships WHERE
        followed_id = :user_id"
       where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
       user_id: user_id)
	end
end
