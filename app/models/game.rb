class Game < ApplicationRecord
  belongs_to :user
  has_many :turns, dependent: :destroy
  enum :status, { in_progress: "in_progress", completed: "completed", abandoned: "abandoned" }

  validates :wager, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: ->(record) { record.user&.balance || 0 },
    message: "your wager can't exceed your balance, asshole!"
  }


end
