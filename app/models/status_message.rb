class StatusMessage < ActiveRecord::Base
  before_create :assign_missing_status, if: :status_is_missing?
  validate :new_status, on: :create

  enum status: { DOWN: 0, UP: 1 }
  scope :latest, -> { order(created_at: :desc).limit(10) }
  scope :current, -> { order(created_at: :desc).first }

  private

  def assign_missing_status
    write_attribute(:status, StatusMessage.last.status)
  end

  def new_status
    errors.add(:status, 'needs to be set the first time.') if status_is_required?
  end

  def status_is_missing?
    read_attribute(:status).blank?
  end

  def is_first_status?
    !StatusMessage.exists?
  end

  def status_is_required?
    status_is_missing? && is_first_status?
  end
end
