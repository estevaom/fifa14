# -*- encoding : utf-8 -*-

class Match < ActiveRecord::Base
  def self.report
    matches = Match.all
    message = "Total matches: #{matches.size}"
    message << "\nGoal difference: #{matches.pluck(:my_score).inject(:+)-matches.pluck(:rival_score).inject(:+)}"
    message << "\nGoals scored: #{matches.pluck(:my_score).inject(:+)}"
    message << "\nGoals conceded: #{matches.pluck(:rival_score).inject(:+)}"
    message << "\nGoals per game: #{matches.pluck(:my_score).inject(:+).to_f/matches.size}"
    message << "\nGoals against per game: #{matches.pluck(:rival_score).inject(:+).to_f/matches.size}"
    message << "\nShots per game: #{matches.pluck(:my_shots).inject(:+).to_f/matches.size}"
    message << "\nShots against per game: #{matches.pluck(:rival_shots).inject(:+).to_f/matches.size}"
    message << "\nPasses attempt per game: #{matches.pluck(:my_pass_attempts).inject(:+)/matches.size}"
    message << "\nShot accuracy: #{(matches.pluck(:my_shots_on_goal).inject(:+)/matches.pluck(:my_shots).inject(:+).to_f*100).to_s[0..4].to_f}%"
    message << "\nPass accuracy: #{matches.pluck(:my_pass_accuracy).inject(:+).to_f/matches.pluck(:my_pass_accuracy).size}%"
    message << "\nPossession: #{matches.pluck(:my_possession).inject(:+).to_f/matches.pluck(:my_possession).size}%"
    message << "\nOverall W:#{matches.select {|x| x.result == "W"}.size} D:#{matches.select {|x| x.result == "D"}.size} L:#{matches.select {|x| x.result =="L"}.size}"
    message
  end

  def result
    return "W" if my_score > rival_score
    return "D" if my_score == rival_score
    return "L" if my_score < rival_score
  end

  def score
    "#{my_score} x #{rival_score}"
  end

  def named_score
    "lmagus #{score} #{rival_name}"
  end
end
