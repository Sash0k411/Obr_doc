class ApplicationDecorator < Draper::Decorator

  def time_format(datetime)
    datetime.strftime("%H:%M %d-%m-%Y") if datetime
  end

  def date_format(date)
    date.strftime("%d-%m-%Y") if date
  end

  def created_at
    time_format(object.created_at)
  end

  def updated_at
    time_format(object.updated_at)
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end