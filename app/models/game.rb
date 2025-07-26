class Game < ApplicationRecord
  belongs_to :user
  has_many :turns, dependent: :destroy
end
