# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  #from Github
  def photo
    my_photo_id = self.photo_id 

    matching_photos = User.where({ :id => my_photo_id })

    the_photo = matching_photos.at(0)

    return the_photo
  end
  belongs_to(:commenter, {
    :class_name => "User",
    :foreign_key => "author_id"
  })
  #from the association accessors tool
  belongs_to(:generated_photo, { 
    :class_name => "Photo",
    :foreign_key => "photo_id"
  })


end
