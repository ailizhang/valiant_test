RSpec.describe Task, type: :model do
  describe 'Validations' do
    let(:task) { build :task }

    it 'is valid if all attributes are valid' do
      expect(task).to be_valid
    end

    it 'is invalid without a description' do
      task.description = nil
      expect(task).not_to be_valid
    end

    it 'is invalid without a completed_at if completed is true' do
      task.completed = true
      task.completed_at = nil
      expect(task).not_to be_valid
    end

    it 'is invalid if completed at is after current time' do
      task.completed_at = Time.now + 1.days
      expect(task).not_to be_valid
    end
  end
end
