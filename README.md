# YAZAWA
[![Gem Version](https://badge.fury.io/rb/yazawa.png)](http://badge.fury.io/rb/yazawa) [![Build Status](https://travis-ci.org/toooooooby/yazawa.png?branch=master)](https://travis-ci.org/toooooooby/yazawa) [![Dependency Status](https://gemnasium.com/toooooooby/yazawa.png)](https://gemnasium.com/toooooooby/yazawa) [![Code Climate](https://codeclimate.com/github/toooooooby/yazawa.png)](https://codeclimate.com/github/toooooooby/yazawa) [![Coverage Status](https://coveralls.io/repos/toooooooby/yazawa/badge.png?branch=master)](https://coveralls.io/r/toooooooby/yazawa)

**『YAZAWA』** is one of `text-converter`, like [Yazawa](http://en.wikipedia.org/wiki/Eikichi_Yazawa).

```bash
$ yazawa '俺達の熱意で世界が変わる'
俺達の『NETSUI』で世界が変わる
```

## Installation

Requirements:

* MeCab (`sudo apt-get install mecab libmecab-dev mecab-ipadic-utf8` on Debian or Ubuntu linux)
* Ruby 1.9.x or lator

Add this line to your application's Gemfile:

    gem 'yazawa'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yazawa

## Usage as a command

Usage: `yazawa TEXT [-r|--random]`

## Examples as a command

```bash
$ yazawa '俺達の熱意で世界が変わる'
俺達の『NETSUI』で世界が変わる

$ yazawa -r '俺達の熱意で世界が変わる'
俺達の熱意で『SEKAI』が変わる

$ yazawa -r '俺達の熱意で世界が変わる'
俺達の熱意で世界が『KAWARU』

$ echo '唸る回転寿司' | yazawa
唸る『KAITEN』寿司

$ yazawa '便利を勘違いしていないか？'
便利を『KANCHIGAI』していないか？

$ yazawa '意識の高いインターンが社内チャットで「世界を変えたいんです！！！」とか主張してたら社員が「ドラム缶で核融合するもの作ってどっかの国で爆発させましょうよ」とか言いだして意識格差すごい'
意識の高いインターンが社内チャットで「世界を変えたいんです！！！」とか主張してたら社員が「『DORAMUKAN』で核融合するもの作ってどっかの国で爆発させましょうよ」とか言いだして意識格差すごい
```

## Examples as a library for ruby

```ruby
require 'yazawa'

p Yazawa.convert('俺達の熱意で世界が変わる') # => '俺達の『NETSUI』で世界が変わる'
p Yazawa.convert('俺達の熱意で世界が変わる', at_random: true) # => '俺達の熱意で『SEKAI』が変わる'
```
