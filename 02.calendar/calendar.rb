# コマンドライン引数・オプションの処理
require 'optparse'
opt = OptionParser.new


days = {}

opt.on('-y [VAL]') {|v| days[:y] = v }
opt.on('-m [VAL]') {|v| days[:m] = v }

opt.parse!(ARGV)

# 今日を定義する
require 'date'

today = Date.today


# 年月を定義
day = today.day

if (days[:y].to_i) == 0
  year = today.year
else
  year = days[:y].to_i
end

if (days[:m].to_i) == 0
  month = today.month
else
  month = days[:m].to_i
end


# カレンダーに表示する最初と最後の日を決定
day = Date.new(year, month, day)
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)


# カレンダーの頭の素材
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"


# 全部の日付を配列に
days = []
(first_day.day..last_day.day).each do |x|
  days.push(x)
end


# 全部の曜日を配列に
wdays = []
(first_day..last_day).each do |x|
  wdays.push(x.strftime('%w'))
end


# 日付と曜日をハッシュへ変換
ary = [days, wdays].transpose
days_and_wdays = Hash[*ary.flatten]


# 1日の前のスペースを表示
first_day.wday.times do
  print ' ' * 3
end


# 日付を表示
days_and_wdays.each do |key, value|
if key < 10
  print (' ')
end
print "#{key} "
print "\n" if value == "6"
end
