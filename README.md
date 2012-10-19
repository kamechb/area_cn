# AreaCn

中国地区数据查询

## Installation

Add this line to your application's Gemfile:

    gem 'area_cn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install area_cn

## Usage

  zhejiang = AreaCN.areas.find_by_name("浙江省")
  zhejiang.code # => "330000"
  zhejiang.children == zhejiang.cities # => ["杭州市", "...", "..."]

  
  hangzhou = AreaCN.areas.find_by_name("杭州市")
  hangzhou.code # => "330100"
  hangzhou.children == hangzhou.districts # => ["滨江区", "...", "..."]



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
