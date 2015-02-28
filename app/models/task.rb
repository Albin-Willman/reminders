class Task < ActiveRecord::Base
  validates_presence_of :name, :recurrance_type, :start_date
  enum recurrance_type: ['year', 'month', 'week', 'day', 'once']

  def self.due_tasks(date)
    Task.all.select { |t| t.due?(date) } 
  end

  def due?(date)
    return false if date < start_date
    return due_day?(date)   if day?
    return due_week?(date)  if week?
    return due_month?(date) if month?
    return due_year?(date)  if year?
    return due_once?(date)  if once?
  end

  def frequenzies
    return 1..10  if year?
    return 1..12  if month?
    return 1..52  if week?
    return 1..365 if day?
    []
  end

  private

  def due_year?(date)
    return false unless date.mday == start_date.mday && date.month == start_date.month
    ((date.year - start_date.year) % frequenzy) == 0
  end

  def due_month?(date)
    return false unless date.mday == start_date.mday
    (((date.year - start_date.year)*12 + date.mon - start_date.mon) % frequenzy) == 0
  end

  def due_week?(date)
    return false unless (date.wday + 6) % 7 == offset
    (((date - start_date)/7).to_i % frequenzy) == 0
  end

  def due_day?(date)
    ((date - start_date).to_i % frequenzy) == 0
  end

  def due_once?(date)
    date == start_date
  end
end
