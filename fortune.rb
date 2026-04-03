# 誕生月占い 誕生月を入力すると順位とラッキーカラーがランダムに表示される

class Fortune

  attr_accessor :birthmonth
  attr_reader :rank, :color_list,:rank_list
  def initialize(birthmonth)
    raise ArgumentError, "1~12を入力してください" if birthmonth < 1 or 12 < birthmonth
    @birthmonth = birthmonth
    @color_list = ["黒","白","赤","青","黄色","緑","金","オレンジ","グレー","水色","紫","ピンク"].shuffle
    @rank_list = [1,2,3,4,5,6,7,8,9,10,11,12].shuffle
    @rank = get_rank(birthmonth)
  end

  def get_rank(birthmonth)
    rank = 1
    @rank_list.each do |i|
      if i == birthmonth
        return rank
      end
      rank += 1
    end
  end

  def get_lucky_color
    @color_list[@rank - 1]
  end

end

class Fortune_View
  def ask_birthmonth
    print "誕生月を入力(1~12)："
  end

  def ask_continue
    print "もう一度やりますか？やる場合 y を入力（それ以外の場合は終了）："
  end
  
  def show_result(birthmonth,rank,color)
    puts "#{birthmonth}月生まれのあなたの運勢は、#{rank}位でした！"
    puts "ラッキーカラーは#{color}です！"
  end

  def show_result_list(rank_list,color_list)
    puts "今回の運勢の一覧です！"
    rank = 1
    rank_list.each do |r|
      puts "#{rank}位：#{r}月　ラッキーカラー：#{color_list[rank - 1]}"
      rank+=1
    end
  end
end


class Fortune_Controller
  def initialize
    @view = Fortune_View.new()
  end
  def run
    puts "誕生月占いです。あなたの運勢を占います。"
    loop do

      begin
        @view.ask_birthmonth
        birthmonth = Integer(gets)
      rescue ArgumentError,TypeError
        print "1~12を入力してください。"
        next
      end

      begin
        fortune = Fortune.new(birthmonth)
      rescue ArgumentError => e
        puts e.message
        next
      end

      @view.show_result(fortune.birthmonth,fortune.rank,fortune.get_lucky_color)
      
      @view.show_result_list(fortune.rank_list,fortune.color_list)

      @view.ask_continue
      if gets.chomp == "y"
        next
      end
      break

    end
  end
end
Fortune_Controller.new().run