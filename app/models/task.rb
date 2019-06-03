class Task < ApplicationRecord
  validates :description, presence: true
  validates :completed_at, presence: true, if: proc { completed? }
  validate :completed_at_validation, if: proc { completed_at.present? }

  private

  def completed_at_validation
    errors.add(:base, 'Completed date cannot be after current time') if completed_at > Time.now
  end
end
