class UsersController < ApplicationController
  def index
    @users = User.all.order({ :username => :asc })
  
    render({ :template => "user_templates/all_users.html.erb" })
  end
  
  def show
    the_username = params.fetch(:the_username)
    @user = User.where({ :username => the_username }).at(0)
  
    render({ :template => "user_templates/details.html.erb" })
  end
  
  def create
    user = User.new
  
    user.username = params.fetch(:input_username, nil)
    user.private = params.fetch(:input_private, nil)
    user.likes_count = params.fetch(:input_likes_count, 0)
    user.comments_count = params.fetch(:input_comments_count, 0)
    
    user.save
    redirect_to("/users/" + user.username)
  end
  
  def update
    the_id = params.fetch(:the_user_id)
    user = User.where({ :id => the_id }).at(0)
  
  
    user.username = params.fetch(:input_username, user.username)
    user.private = params.fetch(:input_private, nil)
    user.likes_count = params.fetch(:input_likes_count, user.likes_count)
    user.comments_count = params.fetch(:input_comments_count, user.comments_count)
    
    user.save
  
    redirect_to("/users/" + user.username)
  
  end
  
  def destroy
    username = params.fetch(:the_username)
    user = User.where({ :username => username }).at(0)
  
    user.destroy
  
    render({ :json => user.as_json })
  end
  
  def liked_photos
    username = params.fetch(:the_username)
    @user = User.where({ :username => username }).at(0)
    render({ :json => @user.liked_photos.as_json })
  end
  
  def own_photos
    the_username = params.fetch("a_user_name")
    user_account = User.where({:username => the_username}).pluck(:id)
    photo_selection = Photo.where({ :owner_id => user_account})
    render({:json => photo_selection.to_json})
    
  end
  
  def feed
    username = params.fetch(:the_username)
    @user = User.where({ :username => username }).at(0)
    
    render({ :json => @user.feed.as_json })
  
  end
  
  def discover
    username = params.fetch(:the_username)
    @user = User.where({ :username => username }).at(0)
  
    render({ :json => @user.discover.as_json })
  
  end
  
end
