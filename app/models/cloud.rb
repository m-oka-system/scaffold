class Cloud < ApplicationRecord
  validates :name,  presence: true
  validates :vendor,  presence: true
end
