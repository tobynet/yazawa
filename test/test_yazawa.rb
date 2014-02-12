#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
$VERBOSE = true
require 'minitest/autorun'
begin require 'minitest/pride' rescue LoadError end # Ignore error for old ruby

require_relative '../lib/yazawa'

describe 'YAZAWA' do
  TEST_TEXTS = [
    # One Katakana word
    { 
      original: '仕事、課金しなくてもどんどんクエストくるしすごい',
      converted: '仕事、課金しなくてもどんどん『KUESUTO』くるしすごい',
      separated: ['仕事', '、', '課金', 'し', 'なく', 'て', 'も', 'どんどん', 'クエスト', 'くるし', 'すごい'],
    },

    # Some Katakana words
    {
      original: '意識の高いインターンが社内チャットで「世界を変えたいんです！！！」とか主張してたら社員が「ドラム缶で核融合するもの作ってどっかの国で爆発させましょうよ」とか言いだして意識格差すごい',
      converted: '意識の高い『INTAAN』が社内『CHATTO』で「世界を変えたいんです！！！」とか主張してたら社員が「『DORAMUKAN』で核融合するもの作ってどっかの国で爆発させましょうよ」とか言いだして意識格差すごい',
      separated: ["意識", "の", "高い", "インターン", "が", "社内", "チャット", "で", "「", "世界", "を", "変え", "たい", "ん", "です", "！", "！", "！", "」", "とか", "主張", "し", "て", "たら", "社員", "が", "「", "ドラム缶", "で", "核", "融合", "する", "もの", "作っ", "て", "どっか", "の", "国", "で", "爆発", "さ", "せ", "ましょ", "う", "よ", "」", "とか", "言い", "だし", "て", "意識", "格差", "すごい"],
    },

    # One word only
    {
      original: 'ジャバ', 
      converted: '『JABA』',
      separated: ['ジャバ'],
    },

    # No Katakana characters
    {
      original: '職質の本、すごいこと書いてあるな  http://instagram.com/p/bwDEFvRrz8/', 
      converted: '職質の本、『SUGOI』こと書いてあるな  http://instagram.com/p/bwDEFvRrz8/',
      separated: ["職", "質", "の", "本", "、", "すごい", "こと", "書い", "て", "ある", "な", "  http", "://", "instagram", ".", "com", "/", "p", "/", "bwDEFvRrz", "8", "/"],
    },
    {
      original: '空飛ぶ  寿司',
      converted: '空飛ぶ  『SUSHI』',
      separated: ["空", "飛ぶ", "  寿司"],
    },
  ]

  TEST_TEXTS.each do |text|
    it "can converts text to like Japanese yankee''s one(#{text[:original].slice(0..9)}...)" do
      YAZAWA.convert(text[:original]).must_equal text[:converted]
    end

    it "can separate words in Japanese with spaces(#{text[:original].slice(0..9)}...)" do
      YAZAWA.separate_words(text[:original]).must_equal text[:separated]
        
    end
  end

  it "can convert one word" do
    YAZAWA.convert_word('ドラム缶').must_equal '『DORAMUKAN』'
    YAZAWA.convert_word('ジャバ').must_equal '『JABA』'
    YAZAWA.convert_word(' JAVA').must_equal ' 『JAVA』'
    YAZAWA.convert_word('  JAVA').must_equal '  『JAVA』'
  end

  it "can find suitable index for replace" do
    YAZAWA.find_suitable_index_for_replace(YAZAWA.tagger.parse "空飛ぶ寿司").must_equal 2
    YAZAWA.find_suitable_index_for_replace(YAZAWA.tagger.parse "職質の本、すごいこと書いてある").must_equal 5

  end

end

