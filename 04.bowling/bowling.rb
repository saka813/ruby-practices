# frozen_string_literal: true

scores = ARGV[0].split(',')
shots = []

# 1投ずつshots配列に格納。ストライクは10,0とする。
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

# 9フレームまで、2投(1フレーム)ずつframes配列に格納
frames = []
shots.first(18).each_slice(2) do |s|
  frames << s
end
frames << shots.drop(18)

point = 0
all_pins = 10

frames.first(8).each_with_index do |frame, i|
  point += if frame[0] == all_pins && frames[i + 1][0] == all_pins # strike & strike
             frame.sum + all_pins + frames[i + 2][0]
           elsif frame[0] == all_pins # strike
             frame.sum + frames[i + 1][0] + frames[i + 1][1]
           elsif frame.sum == all_pins # spair
             frame.sum + frames[i + 1][0]
           else
             frame.sum
           end
end

ninth = frames[8]
last = frames[9]

ninth_point = if ninth[0] == all_pins && last[0] == all_pins # strike & strike
                ninth.sum + all_pins + last[2]
              elsif ninth[0] == all_pins  # strike
                ninth.sum + last[0] + last[1]
              elsif ninth.sum == all_pins # spair
                ninth.sum + last[0]
              else
                ninth.sum
              end

last_point = last.sum
point = point + ninth_point + last_point
puts point
