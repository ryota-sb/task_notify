class Task < ApplicationRecord
  validates :content, presence: true, length: { in: 1..40 }
  validates :notification_time, presence: true
end
