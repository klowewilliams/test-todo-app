class Task < ActiveRecord::Base

  def toggle_complete! 
  #any method considered "dangerous" convention is to put the exclamation mark (updates data in the db in this case)
    update(complete: !complete)
  end

  def toggle_favorite!
    update(favorite: !favorite)
  end

  def overdue?
    return Time.now > deadline
  end

  def increment_priority!
    if priority < 10
      #priority must be less than 10
      update(priority: priority + 1)
    end
  end

  def decrement_priority!
    if priority > 1 
      update(priority: priority - 1)
    end
  end

  def snooze_hour!
    update(deadline: deadline + 1.hour)
    #time related attribute that comes with rails
  end

end
