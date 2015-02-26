# -*- encoding : utf-8 -*-
class TaskMailer < ActionMailer::Base
  
  default from: 'reminder@gmail.com'

  def due_tasks(tasks, email)
    @tasks = tasks
    mail(to: email, subject: 'Reminders')
  end
end
