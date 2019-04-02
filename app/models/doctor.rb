class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_attached_file :photo, 
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :preview  => ['480x480#',  :jpg, :quality => 70],
    :large    => ['600>',      :jpg, :quality => 70],
    :retina   => ['1200>',     :jpg, :quality => 30]
  }
    
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  has_many :recipes, inverse_of: :doctor

  accepts_nested_attributes_for :recipes

  validates :first_name, :last_name, :document_type, :document, :birth_date,
            :speciality, :years_experience, :country, :city, :address, :presence => true
            
  before_create { |r|
    if !self.local_phone.present? && !self.cell_phone.present?
      r.errors.add(:create, "Please suplies at least one phone number")
      false
    end
  }

  before_validation :ensure_token

  def ensure_token
    self.token = generate_hex(:token) unless token.present?
  end

  def generate_hex(column)
    loop do
      hex = SecureRandom.hex
      break hex unless self.class.where(column => hex).any?
    end
  end

  def validates_phone
    self.local_phone.present? || self.cell_phone.present?
  end

  def full_name
  	full_name = []
  	full_name << self.first_name
  	full_name << self.second_name
  	full_name << self.last_name
  	full_name << self.second_last_name
  	full_name << self.married_name
  	full_name.join(" ")
  end
end
