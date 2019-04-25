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
    
  has_one_attached :image
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  has_many :recipes, inverse_of: :doctor

  accepts_nested_attributes_for :recipes

  validates :first_name, :last_name, :document_type, :document, :birth_date,
            :speciality, :years_experience, :country, :city, :address, :genre, :presence => true
            
  before_save :validates_phone, :validates_gender,  on: :update

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
    if !self.local_phone.present? && !self.cell_phone.present?
      errors.add :cell_phone, "Por favor provea al menos un número telefónico."
      throw(:abort)
    end
  end

  def validates_gender
    if self.genre.present? && (self.genre.downcase != "femenino" && self.genre.downcase != "masculino")
      errors.add :genre, "Valor no valido. Permitido solo 'Femenino' y 'Masculino"
      throw(:abort)
    end
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

  def search(term, page)
    if term
      self.recipes.where('full_name LIKE ?', "%#{term}%").paginate(page: page, per_page: 5).order('id DESC')
    else
      self.recipes.paginate(page: page, per_page: 5).order('id DESC') 
    end
  end
end
