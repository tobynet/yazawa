#require "yazawa/version"

require 'mecab/light'
require 'mojinizer'

module MeCab
  module Light
    class CustomTagger < Tagger
      def initialize(options)
        @mecab = Binding.new(options)
      end
    end
  end
end

module YAZAWA
  class << self
    # e.g. "ジャバ" => "『JABA』"
    # e.g. "空飛ぶ 寿司" => "空飛ぶ 『SUSHI』"
    def convert(text)
      # With KATAKANA
      # e.g. "ジャバ" => "『JABA』"
      if text.contains_katakana?
        separate_words(text).map{|x| 
          if x.contains_katakana? then convert_word(x) else x end
        }.join
      else
        # Without KATAKANA
        # e.g. "空飛ぶ 寿司" => "空飛ぶ 『SUSHI』"
        
        # Find a word index which is 'noun'(名詞) and longest length
        index_for_replace = find_suitable_index_for_replace(tagger.parse(text))

        # Convert specific word only
        words = separate_words(text)
        words[index_for_replace] = convert_word(words[index_for_replace])
        words.join
      end
    end
    
    def tagger
      # Specify mecab options for keeping white spaces in parsed text
      @tagger ||= MeCab::Light::CustomTagger.new('--node-format=%M\t%H\n --unk-format=%M\t%H\n')
    end

    # e.g. "空飛ぶ寿司" => ["空", "飛ぶ", "寿司"]
    def separate_words(text)
      tagger.parse(text).map(&:surface)
    end
    
    # e.g. "ジャバ" => "『JABA』"
    # e.g. " JAVA" => " 『JAVA』"
    def convert_word(word)
      # e.g. " JAVA" => " "
      left_space = word.match(/^\s+/).to_s
      striped_word = word.lstrip

      # e.g. "ジャバ" => "JABA"
      katakana = tagger.parse(striped_word).map{|x| x.feature.split(',')[7] }.join
      katakana = striped_word if katakana == ""

      # Generate a result
      left_space + "『" + katakana.romaji.upcase + "』"
    end

    def find_suitable_index_for_replace(parsed_words)
      index_for_replace = 0
      max_score = 0
      
      parsed_words.each_with_index do |result, index|
        score =
          # Japanese++
          (result.surface.contains_japanese? ? 100 : 0) +
          # adjective++
          (result.feature.split(',')[0] == "形容詞" ? 20 : 0) + 
          # noun++
          (result.feature.split(',')[0] == "名詞" ? 10 : 0) + 
          # (Long length)++
          result.surface.length

        if max_score < score
          max_score = score
          index_for_replace = index
        end
      end

      index_for_replace
    end

  end
end
