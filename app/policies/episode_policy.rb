class EpisodePolicy < ApplicationPolicy
  attr_reader :user, :episode

  def initialize(user, episode)
    @user = user
    @episode = episode
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
