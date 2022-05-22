class Mentor < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :user
end
