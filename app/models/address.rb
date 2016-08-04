class Address < ActiveRecord::Base

  belongs_to :user
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }

  validates :user_id, presence: true
  validates :company, presence: true, length: { maximum: 255 }
  validates :country_iso_code, presence: true, length: { maximum: 2 }
  validates :street_name, length: { maximum: 255 }
  validates :street_no, length: { maximum: 255 }
  validates :zip, length: { maximum: 255 }
  validates :city, length: { maximum: 255 }
  validates :phone, length: { maximum: 255 }
  validates :contact_person, presence: true, length: { maximum: 255 }
  validates :vat_no, length: { maximum: 255 }
  validates :website, length: { maximum: 255 }
  validates :state, length: { maximum: 255 }
  

  private

    # converts email to all lower case
  def downcase_email
    self.email = email.downcase
  end
  
end
