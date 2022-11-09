class PhotosController < ApplicationController
  skip_before_action(:force_user_sign_in, { :only => [:index] })
  def index
  
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :created_at => :asc })

    render({ :template => "photos/index.html.erb" })
  end

  def show
    
    the_id = params.fetch("path_id")

   

    matching_photos = Photo.where({ :id => the_id })

    @the_photo = matching_photos.at(0)

    render({ :template => "photos/show.html.erb" })
  end

  def create
    #added for image upload
    #need help fetching the value for the key image from image upload chapter
    @the_photo = Photo.new
    @the_photo.caption = params.fetch("query_caption")
    @the_photo.image = params.fetch(:image)
 
    @the_photo.owner_id = session.fetch(:user_id)

    if @the_photo.valid?
      @the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => @the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    
    @the_photo = Photo.where({ :id => the_id }).at(0)
    # @the_photo.image = params.fetch(:image)
    @the_photo.caption = params.fetch("query_caption")
    @the_photo.comments_count = params.fetch("query_comments_count")
   
 
    the_photo.likes_count = params.fetch("query_likes_count")
    @the_photo.owner_id = session.fetch(:user_id)

    if @the_photo.valid?
      @the_photo.save
      redirect_to("/photos/#{@the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @the_photo = Photo.where({ :id => the_id }).at(0)

    @the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
