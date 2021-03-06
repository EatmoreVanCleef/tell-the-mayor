require 'exifr'
require 'geocoder'

class Image
  attr_accessor :latitude, :longitude, :location, :path
  
  def initialize(path)
    @path = path

    if geotagged? 
      find_coords
      find_location
      get_city
    else
      puts "Image is not geotagged!"
    end
  end

  def geotagged?
    EXIFR::JPEG.new(@path).gps ? true :false
  end

  def find_coords
    @latitude = EXIFR::JPEG.new(@path).gps.latitude
    @longitude = EXIFR::JPEG.new(@path).gps.longitude
  end

  def find_location
    query = @latitude.to_s + "," + @longitude.to_s 
    @location = Geocoder.search(query).first
  end

  def get_city
    location.city
  end

  def get_address
    location.address
  end

end