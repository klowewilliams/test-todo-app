require 'rails_helper'

RSpec.describe Task, type: :model do

  describe '#toggle_complete!' do
    it 'should make an incomplete task complete' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it 'should make a complete task incomplete' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end

  describe '#toggle_favorite!' do
    it 'should make a task not marked as a favorite a favorite' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end

    it 'should make a task marked as a favorite not a favorite' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'should check to see if task is overdue' do
      task = Task.create(deadline: 1.day.ago)
      task.overdue?
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if deadline is in the future' do
      task = Task.create(deadline: 2.years.from_now)
      task.overdue?
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should increase the priority of a task by one if the priority is less than 10' do
      task = Task.create(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
    end

    it 'should not increase the priority if the priority is more than 10' do
      task = Task.create(priority: 11)
      task.increment_priority!
      expect(task.priority).to eq(11)
    end

    describe '#decrement_priority!' do
      it 'should decrease the priority of a task if it is more than 1' do
      task = Task.create(priority: 4)
      task.decrement_priority!
      expect(task.priority).to eq(3)
      end

      it 'should not decrease the priority of a task if is is less than one' do
        task = Task.create(priority: 0)
        task.decrement_priority!
        expect(task.priority).to eq(0)
      end
    end

    describe '#snooze_hour' do
      it 'should increase deadline by 1 hour' do
        task = Task.create(deadline: Time.new(2001, 1, 1))
        task.snooze_hour!
        expect(task.deadline).to eq(Time.new(2001, 1, 1) + 1.hour)
      end
    end
  end


end