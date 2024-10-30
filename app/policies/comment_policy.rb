class CommentPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  # index? not defined because inherited from ApplicationPolicy,
  # default value of false not changed because no user should be allowed to view comments index

  # a comment's details page should be shown to its author
  
  def show?
    user == comment.author
  end

  # all users should be allowed to create comments

  def create?
    true
  end

  # all users should be allowed to see the create comments form

  def new?
    create?
  end

  # only the comment's author should be allowed to update the comment

  def update?
    user == comment.author
  end

  # only the comment's author should be allowed to see the update comment form for a specific comment

  def edit?
    update?
  end

  # only the comment's author should be allowed to delete the comment
  
  def destroy?
    user == comment.author
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
