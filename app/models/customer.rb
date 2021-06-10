class Customer < ApplicationRecord
  validates :first_name, presence: true
end
