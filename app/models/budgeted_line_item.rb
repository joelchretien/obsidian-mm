class BudgetedLineItem < ApplicationRecord
  belongs_to :user

  enum recurrence:  [:no_recurrence, :weekly, :monthly, :yearly ]

  self.per_page = 50

  def recurrence_text
    if(no_recurrence?)
      "one time"
    elsif(weekly?)
      get_recurrence_string("week")
    elsif(monthly?)
      get_recurrence_string("month")
    elsif(yearly?)
      get_recurrence_string("year")
    end
  end

  private

  def get_recurrence_string(recurrence_string)
    pluralized_recurrence_string = recurrence_string.pluralize(recurrence_multiplier)
    "Every #{recurrence_multiplier} #{pluralized_recurrence_string}"
  end
end
