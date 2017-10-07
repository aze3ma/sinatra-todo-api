class List < ActiveRecord::Base
  ## Associations
  has_many :tasks, dependent: :destroy
  
  ## Validations
  validates :name, presence: true
  validates :color, presence: true, format: /\A#?(?:[A-F0-9]{3}){1,2}\z/i
end