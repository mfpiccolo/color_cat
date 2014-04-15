require "helper"

describe ColorCat::Process do

  describe '.call' do

    it "should create an array of color information about the image" do
      cc = ColorCat::Process.call("http://www.baxterboo.com/global/images/products/large/zanies-neon-lil-yelpers-dog-toy-bright-blue-1.jpg", ignore_white_bg: true)
      cc.color_info.must_equal [{:hex=>"#105DA4", :rgb=>[15, 92, 164], :intensity=>20027, :color_cat=>"blue", :color_name=>"DodgerBlue4"}, {:hex=>"#263C6B", :rgb=>[37, 60, 107], :intensity=>15118, :color_cat=>"blue", :color_name=>"RoyalBlue4"}, {:hex=>"#3488C8", :rgb=>[52, 135, 200], :intensity=>30404, :color_cat=>"blue", :color_name=>"SteelBlue"}, {:hex=>"#CFD7E5", :rgb=>[207, 214, 228], :intensity=>55018, :color_cat=>"gray", :color_name=>"gray85"}, {:hex=>"#ABC8E3", :rgb=>[171, 199, 227], :intensity=>49946, :color_cat=>"blue", :color_name=>"LightSteelBlue"}]
      cc.to_hex.must_equal "#105DA4"
      cc.to_rgb.must_equal [15, 92, 164]
      cc.intensity.must_equal 20027
      cc.dominant_category.must_equal "blue"
      cc.dominant_name.must_equal "DodgerBlue4"
    end
  end

end
