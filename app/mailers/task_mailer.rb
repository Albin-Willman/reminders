# -*- encoding : utf-8 -*-
class TaskMailer < ActionMailer::Base
  
  default from: ReminderDefines::BASE_EMAIL

  def due_tasks(tasks, email)
    @tasks = tasks
    mail(to: email, subject: 'Reminders of today')
  end
end
