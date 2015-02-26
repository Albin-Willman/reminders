require "rails_helper"

RSpec.describe Task, :type => :model do
  it "It validates that a name is present" do
    t = Task.create()
    expect(t.errors.any?).to be_truthy
    expect(t.errors.messages[:name]).to include("can't be blank")
  end

  it "It validates that a recurrance_type is present" do
    t = Task.create(name: 'test')
    expect(t.errors.any?).to be_truthy
    expect(t.errors.messages[:recurrance_type]).to include("can't be blank")
  end

end