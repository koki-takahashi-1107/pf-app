class PostImage < ApplicationRecord

  belongs_to :user
  attachment :image

   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy

   has_many :tag_maps, dependent: :destroy
   has_many :tags, through: :tag_maps

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


   def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.post_image_tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_image_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_image_tag
    end
   end

   def self.looks(search, word)
    if search == "perfect_match"
      @post_image = PostImage.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post_image = PostImage.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post_image = PostImage.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post_image = PostImage.where("title LIKE?","%#{word}%")
    else
      @post_image = PostImage.all
    end
   end

  validates :image, presence: true
  validates :title, presence: true
end
