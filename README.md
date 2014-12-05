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

### Find by name or code

    zhejiang = AreaCN.areas.find_by_name("浙江省")
    zhejiang.code # => "330000"
    zhejiang.children == zhejiang.cities # => [{:name => "杭州市", :code => "330100"}, {}, {}, ...]

    
    hangzhou = AreaCN.areas.find_by_code("330100")
    hangzhou.code # => "330100"
    hangzhou.name # => "杭州市"
    hangzhou.children == hangzhou.districts # => [{:name => "滨江区", :code => "330108"}, {}, {}, ...]

### Return all provinces

    AreaCN.provinces
    AreaCN.areas.provinces

### Code methods

    zhejiang.code.prefix # => return '33'
    hangzhou.code.parent # => return '330000'

    zhejiang.ancestor?(hangzhou) # => return true
    hangzhou.child?(zhejiang)    # => return true


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


