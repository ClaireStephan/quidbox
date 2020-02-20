class Message < ApplicationRecord
  validates :from, presence: true
  validates :to, presence: true
  validates :body, presence: true
  validates :private, presence: true
end
