class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def delete
    self.is_valid = false
    self.save
  end
end
