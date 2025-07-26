class Game < ApplicationRecord
  belongs_to :user
  has_many :turns, dependent: :destroy
  enum :status, { in_progress: "in_progress", completed: "completed", abandoned: "abandoned" }
end
