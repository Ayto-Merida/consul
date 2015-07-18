require 'numeric'
class Debate < ActiveRecord::Base
  acts_as_votable

  validates :title, presence: true
  validates :description, presence: true

  validates :terms_of_service, acceptance: { allow_nil: false }, on: :create

  #vote can be 'likes' or 'dislikes'
  def percentage(vote)
    return if total_votes == 0
    send(vote).percent_of(total_votes)
  end

  def likes
    get_likes.size
  end

  def dislikes
    get_dislikes.size
  end

  def total_votes
    votes_for.size
  end
end