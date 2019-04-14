class Category < ApplicationRecord
  scope :valid, ->(*) { where(is_valid: true) }
  scope :by_name, -> name { where("lower(name) like lower(?)", "%#{name}%") }

  validates :name, presence: true
end
