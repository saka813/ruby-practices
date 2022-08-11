# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.first(18).each_slice(2) do |s|
  frames << s
end
frames << shots.drop(18)

point = 0

frames.first(8).each_with_index do |frame, i|
  point += if frame[0] == 10 && frames.slice(i + 1)[0] == 10 # strike & strike
             frame.sum + 10 + frames.slice(i + 2)[0]
           elsif frame[0] == 10 # strike
             frame.sum + frames.slice(i + 1)[0] + frames.slice(i + 1)[1]
           elsif frame.sum == 10 # spair
             frame.sum + frames.slice(i + 1)[0]
           else
             frame.sum
           end
end

ninth = frames[8]
last = frames[9]
last_point = last.sum

ninth_point = if ninth[0] == 10 && last[0] == 10 && last[2] == 10 # strike & strike & strike
                (ninth.sum + 20)
              elsif ninth[0] == 10 && last[0] == 10 && last[2] != 10 # stirke & strike
                ninth.sum + 10 + last[2]
              elsif ninth[0] == 10  # strike
                ninth.sum + last[0] + last[1]
              elsif ninth.sum == 10 # spair
                ninth.sum + last[0]
              else
                ninth.sum
              end

point = point + ninth_point + last_point
puts point
