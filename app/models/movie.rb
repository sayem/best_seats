class Movie < ApplicationRecord
  validates :title, :summary, :year, :genre, presence: true
  validates_uniqueness_of :title
end
