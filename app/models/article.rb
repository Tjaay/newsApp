class Article < ApplicationRecord
  has_many :votes, dependent: :destroy
end
