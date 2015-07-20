class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  scope :access, -> { where(is_access: true) }
  scope :menage, -> { where(is_menage: true) }
  scope :accepted_menage, -> { where(accepted: true, is_manage: true) }

end
