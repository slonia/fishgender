class Photo < ApplicationRecord
  # modules
  include Usable

  # fields
  mount_uploader :image, ImageUploader
  serialize :tags, Array
  enum source: %w(manual instagram)

  # scopes
  scope :active, -> {where(active: true)}

  # validations
  validates :instagram_id, uniqueness: true, allow_blank: true

  # callbacks
  before_save :set_tags

  def deactivate
    update(active: false)
  end

  def activate
    update(active: true)
  end

  private

    def set_tags
      @rekognition = Aws::Rekognition::Client.new(region: 'us-west-2', credentials: aws_credentials)
      faces = @rekognition.recognize_celebrities(image: {bytes: image.file_object.read}).celebrity_faces
      tags = faces.map(&:name)
      active = (source == 'manual') || tags.include?('Vera Brezhneva')
      self.tags = tags
      self.active = active
    end

    def aws_credentials
      @aws_credentials ||= Aws::Credentials.new(Rails.application.secrets.aws[:id], Rails.application.secrets.aws[:secret])
    end
end
