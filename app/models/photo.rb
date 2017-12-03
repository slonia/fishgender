class Photo < ApplicationRecord
  include Usable

  mount_uploader :image, ImageUploader

  def get_celebrities
    @rekognition = Aws::Rekognition::Client.new(region: 'us-west-2', credentials: aws_credentials)
    faces = @rekognition.recognize_celebrities(image: {bytes: image.file_object.read}).celebrity_faces
    faces.map(&:name)
  end

  private

    def aws_credentials
      @aws_credentials ||= Aws::Credentials.new(Rails.application.secrets.aws[:id], Rails.application.secrets.aws[:secret])
    end
end
