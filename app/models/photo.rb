class Photo < ApplicationRecord
  # modules
  include Usable

  # fields
  mount_uploader :image, ImageUploader
  serialize :tags, Array
  enum source: %w(manual instagram)
  INSTAGRAM_URL = "https://www.instagram.com/p/"

  # scopes
  scope :active, -> {where(active: true)}

  # validations
  validates :instagram_id, uniqueness: true, allow_blank: true
  validates :fingerprint, uniqueness: true, allow_blank: true
  validates :fingerprint, uniqueness: true, allow_blank: true

  # callbacks
  before_save :process_image
  before_create :set_active

  def deactivate
    update(active: false)
  end

  def activate
    update(active: true)
  end

  def instagram_link
    instagram_code ? "#{INSTAGRAM_URL}#{instagram_code}" : nil
  end

  private

    def process_image
      @rekognition = Aws::Rekognition::Client.new(region: 'us-west-2', credentials: aws_credentials)
      faces = @rekognition.recognize_celebrities(image: {bytes: image.file_object.read}).celebrity_faces
      tags = faces.map(&:name)
      self.tags = tags
      self.fingerprint = calculate_fingerprint
    end

    def set_active
      self.active = (source == 'manual') || tags.include?('Vera Brezhneva')
    end

    def aws_credentials
      @aws_credentials ||= Aws::Credentials.new(Rails.application.secrets.aws[:id], Rails.application.secrets.aws[:secret])
    end

    def calculate_fingerprint
      phashion = Phashion::Image.new(image.file_object.path)
      phashion.fingerprint
    end
end
