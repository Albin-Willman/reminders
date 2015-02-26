namespace :notifier do

  desc 'Notfies all subscribers about all due tasks'
  task notify_subscribers: :environment do
    puts 'Running task'
    date = Date.today
    tasks = Task.due_tasks(date)
    Subscriber.all.each do |subscriber|
      puts "Mailing: #{subscriber.email}"
      TaskMailer.due_tasks(tasks, subscriber.email).deliver_now
    end
    puts 'Ran task'
  end
end