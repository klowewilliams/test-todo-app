require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should snooze each task' do
      list = List.create(name: "Chores")
      Task.create(deadline: Time.new(2015, 1, 1), list_id: list.id)
      Task.create(deadline: Time.new(2015, 1, 1), list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(Time.new(2015, 1, 1) + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'should return the sum of the duration of all the tasks' do
      list = List.create(name: "Chores")
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      expect(list.total_duration).to eq(150)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all incomplete tasks' do
      list = List.create(name: "Chores")
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      incomplete_tasks = list.incomplete_tasks
      expect(incomplete_tasks.count).to eq(2)
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end
end