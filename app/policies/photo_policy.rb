class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  # Our policy is that a photo should only be seen by the owner or followers
  #   of the owner, unless the owner is not private in which case anyone can
  #   see it

  def show?
    user == photo.owner || photo.owner.followers.include?(user) || !photo.owner.private?
  end

  def new?
    create?
  end

  def create?
    true # all users should be able to create new photos
  end

  def edit?
    update?
  end
  
  # only allow updating if photo belongs to user

  def update?
    user == photo.owner
  end

  # only allow deleting if photo belongs to user

  def destroy?
    user == photo.owner 
  end
end
