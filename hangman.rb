#!/usr/bin/env ruby

require 'set'

class Hangman
  def initialize
    @word = File.readlines('/usr/share/dict/words').sample.chomp
    @guesses = Set.new
    @lives = 10
  end

  def play
    loop do
      puts @word.gsub(/./) { |letter| @guesses.include?(letter.upcase) ? letter.upcase : '_' }
      if @guesses.any?
        puts "Guessed so far: #{@guesses.to_a.join(' ')}"
      end
      STDOUT << "You have #{@lives} lives. Guess a letter: "
      letter = gets.chomp.upcase
      if @guesses.include?(letter)
        puts "You already guessed #{letter}"
      else
        if !@word.upcase.include?(letter)
          @lives -= 1
        end
        @guesses << letter
      end
      puts
      if @word.upcase.chars.all? { |letter| @guesses.include?(letter) }
        puts "You won! The word was #{@word}"
        break
      elsif @lives == 0
        puts "You lost! The word was #{@word}"
        break
      end
    end
  end
end

Hangman.new.play
