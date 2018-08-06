class BudgetedLineItem < ApplicationRecord

  validates :description, presence: true

  monetize :amount_cents
  validates :amount_cents, presence: true

  enum recurrence:  [:no_recurrence, :weekly, :monthly, :yearly ]
  validates :recurrence, presence: true

  validates :recurrence_multiplier, presence: true

  belongs_to :user
  validates :user, presence: true

  has_many :transactions, dependent: :nullify

  validates :start_date, presence: true

  self.per_page = 50
  scope :search, -> (term) { where('description LIKE ?', "%#{term}%")}

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
