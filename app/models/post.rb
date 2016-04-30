class Post < ActiveRecord::Base

  belongs_to :address
  belongs_to :user
  default_scope -> { order created_at: :desc }
  validates :user_id, presence: true
  validates :content_type, presence: true,
            numericality: { less_than: 3 }
  validates :channel, presence: true,
            numericality: { less_than: 2 }
  validates :billing_type, presence: true,
            numericality: { less_than: 2 }
  validates :scope_hours, numericality: { less_than: 160, greater_than: 0 }
  validates :title, length: { maximum: 1000 }
  validates :remarks, length: { maximum: 2000 }
  validates :scope_of_work, length: { maximum: 2000 }
  validates :scope_of_experience, length: { maximum: 2000 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :hourly_payment, numericality: { less_than: 500 }
  validates :currency, presence: true,
            numericality: { less_than: 3 }
  # user must accept terms and conditions
  validates :terms_and_contitions, acceptance: true

  
  
end
