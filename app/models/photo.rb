# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  belongs_to(:poster, {
    :class_name => "User",
    :foreign_key => "owner_id",
    :required => true
  })
  has_many(:likes, {
    :class_name => "Like",
    :foreign_key => "photo_id"
  })
  has_many(:fans, {
    :through => :likes,
    :source => :fan
  })

  def fan_list
    my_fans = self.fans

    array_of_usernames = Array.new

    my_fans.each do |a_user|
      array_of_usernames.push(a_user.username)
    end
    formatted_usernames = array_of_usernames.to_sentence

    return formatted_usernames
  end
end
