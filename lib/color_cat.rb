require "color_cat/version"
require "color_cat/colors"
require "color_cat/process"


module ColorCat
  def self.included(base)
    base.send(:include, ColorCat::Process)
    base.send(:include, ColorCat::Colors)
    super
  end
end
