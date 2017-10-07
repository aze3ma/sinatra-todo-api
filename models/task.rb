class Task < ActiveRecord::Base
  ## Associations
  belongs_to :list

  ## Validations
  validates :name, :list_id, presence: true
end