# frozen_string_literal: true

# 10本のピン全てを定数ALL_PINSと定義
ALL_PINS = 10

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
frames = shots.first(18).each_slice(2).to_a
frames << shots.drop(18)

point = 0

frames.first(8).each_with_index do |frame, i|
  point += if frame[0] == ALL_PINS && frames[i + 1][0] == ALL_PINS # strike & strike
             frame.sum + ALL_PINS + frames[i + 2][0]
           elsif frame[0] == ALL_PINS # strike
             frame.sum + frames[i + 1][0] + frames[i + 1][1]
           elsif frame.sum == ALL_PINS # spair
             frame.sum + frames[i + 1][0]
           else
             frame.sum
           end
end

ninth = frames[8]
last = frames[9]

ninth_point = if ninth[0] == ALL_PINS && last[0] == ALL_PINS # strike & strike
                ninth.sum + ALL_PINS + last[2]
              elsif ninth[0] == ALL_PINS  # strike
                ninth.sum + last[0] + last[1]
              elsif ninth.sum == ALL_PINS # spair
                ninth.sum + last[0]
              else
                ninth.sum
              end

point = point + ninth_point + last.sum
puts point
