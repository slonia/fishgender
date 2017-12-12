class Photo < ApplicationRecord
  include Usable
  mount_uploader :image, ImageUploader
  serialize :tags, Array

  scope :active, -> {where(active: true)}
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
      self.tags = faces.map(&:name)
    end

    def aws_credentials
      @aws_credentials ||= Aws::Credentials.new(Rails.application.secrets.aws[:id], Rails.application.secrets.aws[:secret])
    end
end
