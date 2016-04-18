class StatusMessage < ActiveRecord::Base
  before_create :assign_status_if_missing
  validate :new_status, on: :create

  scope :latest, -> { order(created_at: :desc).limit(10) }

  private

  def new_status
    if is_first_status?
      errors.add(:status, 'needs to be set the first time.')
    end
  end

  def assign_status_if_missing
    #TODO: needs to think in a better way to do this
    self.status = StatusMessage.last.status if status.blank?
    true
  end

  def is_first_status?
    status.blank? && !StatusMessage.exists?
  end
end
