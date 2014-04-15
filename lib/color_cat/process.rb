require "rmagick"

module ColorCat
  class Process
    attr_reader :url, :original, :quantized, :primary, :opts, :color_details

    NUMBER_OF_COLORS = 6

    def initialize(url, opts={})
      @url = url
      @opts = opts
      @color_details = []
    end

    def call
      process_image
      normal = sort_by_decreasing_frequency(quantized)
      get_pix(normal)
    end

    def self.call(url, opts={})
      new(url, opts).call
    end

    def color_category(my_rgb)
      tmp_dist = 255*3
      tmp_name = "none"
      tmp_category_color = "none"

      Colors.each_pair do |name, rgb|
        category_color = rgb[0]
        rgb = rgb[1]
        total_dist = Math.sqrt((rgb[0] - my_rgb[0]) ** 2 + (rgb[1] - my_rgb[1]) ** 2 + (rgb[2] - my_rgb[2]) ** 2)

        if (total_dist < tmp_dist)
          tmp_name = name
          tmp_category_color = category_color
          tmp_dist = total_dist
        end
      end

      [tmp_category_color, tmp_name]
    end

    def ignore_white_bg?
      opts[:ignore_white_bg]
    end

    def color_info
      color_details.compact
    end

    def to_hex
      color_info.first[:hex]
    end

    def to_rgb
      color_info.first[:rgb]
    end

    def intensity
      color_info.first[:intensity]
    end

    def dominant_category
      color_info.first[:color_cat]
    end

    def dominant_name
      color_info.first[:color_name]
    end


    private

    def process_image
      @original = Magick::Image.read(url).first
      @quantized = original.quantize(NUMBER_OF_COLORS, Magick::RGBColorspace)
    end

    def sort_by_decreasing_frequency(img)
      hist = img.color_histogram
      # sort by decreasing frequency
      sorted = hist.keys.sort_by {|p| -hist[p]}
      new_img = Magick::Image.new(hist.size, 1)
      new_img.store_pixels(0, 0, hist.size, 1, sorted)
    end

    def get_pix(img)
      pixels = img.get_pixels(0, 0, img.columns, 1)
      pixels.map do |p|
        red = (p.red / 257)
        green = (p.green / 257)
        blue = (p.blue / 257)

        # If the main dominant color is white or close and ignore_white_bg is set
        # skip this loop iteration.
        next if ignore_white_bg? && ((red + green + blue) > 759)

        my_rgb = [red, green, blue]
        color_category = color_category(my_rgb)[0]
        color_name = color_category(my_rgb)[1]

        color_details << {
          hex: p.to_color(Magick::AllCompliance, false, 8),
          rgb: my_rgb,
          intensity: p.intensity,
          color_cat: color_category,
          color_name: color_name
        }
      end

      self
    end

  end
end
