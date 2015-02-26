class Task < ActiveRecord::Base
  validates_presence_of :name, :recurrance_type
  enum recurrance_type: ['month', 'week', 'day']

  def self.due_tasks(date)
    Task.all.select { |t| t.due?(date) } 
  end

  def due?(date)
    return date.yday % frequenzy if day?
    return due_week?(date)  if week?
    return due_month?(date) if month?
  end

  def offsets
    return 0..30 if month?
    return 0..6  if week?
    []   
  end

  def frequenzies
    return 1..12  if month?
    return 1..52  if week?
    return 1..365 if day?
    []
  end

  private

  def due_week?(date)
    return false unless date.mon % frequenzy
    (date.wday + 6) % 7 == offset
  end

  def due_week?(date)
    return false unless date.cweek % frequenzy
    (date.wday + 6) % 7 == offset
  end
end
