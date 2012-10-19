# encoding: utf-8
require 'spec_helper'

describe AreaCN, "中国地区数据" do
  describe AreaCN::Areas do
    it "#find_by_name should find area by name and can be scope" do
      hangzhou = AreaCN.areas.find_by_name("杭州市")
      hangzhou.should_not be_nil
      hangzhou.code.should == '330100'

      hangzhou = AreaCN.areas.find_by_name("杭州市", :city)
      hangzhou.should_not be_nil
      hangzhou.code.should == '330100'

      hangzhou = AreaCN.areas.find_by_name("杭州市", :province)
      hangzhou.should be_nil

      hangzhou = AreaCN.areas.find_by_name("杭州市", :district)
      hangzhou.should be_nil
    end

    it "#find_by_code should find area by code" do
      hangzhou = AreaCN.areas.find_by_code("330100")
      hangzhou.name.should == "杭州市"
    end

    it "province should have cities and city have districts" do
      zhejiang = AreaCN.areas.find_by_name("浙江省")
      hangzhou = AreaCN.areas.find_by_name("杭州市")
      zhejiang.cities.should_not be_empty
      hangzhou.districts.should_not be_empty
    end
  end

  describe AreaCN::Area do
    it "an area instance should know self is province? or city? or district?" do
      zhejiang = AreaCN::Area.new({"text" => "浙江", "id" => "330000"})
      hangzhou = AreaCN::Area.new({"text" => "杭州", "id" => "330100"})
      binjiang = AreaCN::Area.new({"text" => "滨江", "id" => "330108"})

      zhejiang.should be_province
      hangzhou.should be_city
      binjiang.should be_district
    end

    it "area should can be compare" do
      AreaCN::Area.new({"text" => "浙江", "id" => "330000"}).should == AreaCN::Area.new({"text" => "浙江", "id" => "330000"})
    end
  end

  describe AreaCN::Code do
    it "code.prefix should return code's prefix" do
      code = AreaCN::Code.new("110000")
      code.prefix.should == '11'

      code = AreaCN::Code.new("110010")
      code.prefix.should == '110010'

      code = AreaCN::Code.new("100000")
      code.prefix.should == '10'

      code = AreaCN::Code.new("110100")
      code.prefix.should == '1101'
    end

    it "code parent" do
      code = AreaCN::Code.new("110000")
      code.parent.should == AreaCN::Code.new("000000")

      AreaCN::Code.new("000000").parent.should == nil
    end

    it "code ancestor" do
      code1 = AreaCN::Code.new("330101")
      code2 = AreaCN::Code.new("330100")
      code3 = AreaCN::Code.new("330000")

      code2.ancestor?(code1).should be_true
      code3.ancestor?(code2).should be_true
      code3.ancestor?(code1).should be_true

      code1.child?(code2).should be_true
      code1.child?(code3).should be_true
    end

    it "code should can be compare" do
      AreaCN::Code.new("330101").should == AreaCN::Code.new("330101")
    end
  end

end
