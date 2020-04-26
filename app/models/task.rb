class Task < ApplicationRecord
  validates :content, presence: true, length: { in: 1..40 }
end
