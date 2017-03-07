require 'rails_helper'

RSpec.describe List, type: :model do
    describe '#complete_all_tasks!' do
     it 'should mark all tasks from the list as complete' do
       list = List.create(name: "Chores")
       Task.create(complete: false, list_id: list.id, name: "Take out trash")
       Task.create(complete: false, list_id: list.id, name: "Mow the lawn")
       list.complete_all_tasks!
       list.tasks.each do |task|
         expect(task.complete).to eq(true)
       end
     end
   end

    describe '#snooze_all_tasks!' do
      it 'should return one hour ahead of the deadline' do 
        list = List.new(name: "Snooze")
        deadline = DateTime.new(2017, 3, 6)
        Task.create(deadline: deadline, list_id: list.id, name: "Participate in an entrepreneurship event as a guest speaker")
        Task.create(deadline: deadline, list_id: list.id, name: "Present capstone project to my housemates prepare to present at Impact Hub")
        list.snooze_all_tasks!
        list.tasks.each do |task|
          expect(task.deadline).to eq(deadline + 1.hours)
        end
      end
    end

    describe '#total_duration' do 
      it 'should return all tasks marked incomplete' do 
        list = List.new(name: 'Tech Lab')
        Task.create(duration: 50, list_id: list.id, name: 'Testing paper circuits for K12 students')
        Task.create(duration: 100, list_id: list.id, name: 'Training team of staff')
        Task.create(duration: 50, list_id: list.id, name: 'Creating clear responsibilities')
        Task.create(duration: 100, list_id: list.id, name: 'Signing receipts for students')
        Task.create(duration: 50, list_id: list.id, name: 'Creating revenue model')
        list.total_duration.each do |time|
          expect(time.duration).to eq(50)
        end
      end
    end

    describe '#incomplete_tasks' do 
      it 'should return all tasks marked incomplete' do 
        list = List.new(name: 'Tech Lab')
        Task.create(complete: false, list_id: list.id, name: 'Testing paper circuits for K12 students')
        Task.create(complete: true, list_id: list.id, name: 'Training team of staff')
        Task.create(complete: false, list_id: list.id, name: 'Creating clear responsibilities')
        Task.create(complete: true, list_id: list.id, name: 'Signing receipts for students')
        Task.create(complete: false, list_id: list.id, name: 'Creating revenue model')
        list.incomplete_tasks.each do |task|
          expect(task.complete).to eq(false)
        end
      end
    end

    describe '#favorite_tasks' do 
      it 'should return favorite tasks' do
        list = List.new(name: "Hobbies")
        Task.create(favorite: false, list_id: list.id, name: 'Watching movies')
        Task.create(favorite: true, list_id: list.id, name: 'Playing guitar')
        Task.create(favorite: false, list_id: list.id, name: 'Eating out')
        Task.create(favorite: true, list_id: list.id, name: 'Playing music')
        Task.create(favorite: true, list_id: list.id, name: 'Swimming')
        list.favorite_tasks.each do |task| 
          expect(task.favorite).to eq (true)
        end
      end
    end
end
