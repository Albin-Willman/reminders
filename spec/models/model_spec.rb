require 'rails_helper'

RSpec.describe Task, :type => :model do
  it 'It validates that a name is present' do
    t = Task.create()
    expect(t.errors.any?).to be_truthy
    expect(t.errors.messages[:name]).to include("can't be blank")
  end

  it 'It validates that a recurrance_type is present' do
    t = Task.create(name: 'test')
    expect(t.errors.any?).to be_truthy
    expect(t.errors.messages[:recurrance_type]).to include("can't be blank")
  end

  it 'It should be created without errors in the basic case' do
    t = Task.new(name: 'test', recurrance_type: 'day')
    expect(t.valid?).to be_truthy
  end

  describe 'Due method' do

    describe 'Day tasks' do
      it 'Should always be due if it is of type day and frequenzy 1' do
        t = Task.new(name: 'test', recurrance_type: 'day', frequenzy: 1)
        date = Date.new(2001,2,3)
        expect(t.due?(date)).to be_truthy
      end

      it 'Should be due on even days if it is of type day and frequenzy 2' do
        t = Task.new(name: 'test', recurrance_type: 'day', frequenzy: 2)
        date = Date.new(2001,1,1)
        expect(t.due?(date)).to be_falsy
        date = Date.new(2001,1,2)
        expect(t.due?(date)).to be_truthy
      end
    end

    describe 'Week tasks' do
      it 'Should be due on mondays if setup right' do
        t = Task.new(name: 'test', recurrance_type: 'week', frequenzy: 1, offset: 0)
        date = Date.new(2015,2,23) # This is a monday
        expect(t.due?(date)).to be_truthy
        date = Date.new(2015,2,24)
        expect(t.due?(date)).to be_falsy
      end

      it 'Should be due on wednesdays if setup right' do
        t = Task.new(name: 'test', recurrance_type: 'week', frequenzy: 1, offset: 2)
        date = Date.new(2015,2,25) # This is a wednesday
        expect(t.due?(date)).to be_truthy
        date = Date.new(2015,2,24)
        expect(t.due?(date)).to be_falsy
      end

      it 'Should be due on even mondays if setup right' do
        t = Task.new(name: 'test', recurrance_type: 'week', frequenzy: 2, offset: 0)
        date = Date.new(2015,2,16) # This is a monday week 8
        expect(t.due?(date)).to be_truthy
        date = Date.new(2015,2,23) # This is a monday week 9
        expect(t.due?(date)).to be_falsy
        date = Date.new(2015,2,24)
        expect(t.due?(date)).to be_falsy
      end
    end

    describe 'Monthly tasks' do
      it 'Should be due the 3rd of every month if setup right' do
        t = Task.new(name: 'test', recurrance_type: 'month', frequenzy: 1, offset: 2)
        date = Date.new(2015,2,3)
        expect(t.due?(date)).to be_truthy
        date = Date.new(2015,5,3)
        expect(t.due?(date)).to be_truthy
        date = Date.new(2015,5,4)
        expect(t.due?(date)).to be_falsy
        date = Date.new(2015,5,30)
        expect(t.due?(date)).to be_falsy
      end
    end
  end

end