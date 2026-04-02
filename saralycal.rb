class Saraly_Class
    def initialize(hourly_wage,working_hour)
        @hourly_wage = hourly_wage #時給
        @working_hour = working_hour #労働時間
        @saraly = hourly_wage * working_hour #給料
    end

    # 収入から税金を引いた額を取得
    def get_after_tax
        after_tax = @saraly - tax_cal
        return after_tax
    end

    #所得税の計算
    def tax_cal
        tax_list =[[40000000,0.45,4796000],[18000000,0.40,2796000],[9000000,0.33,1536000],[6950000,0.23,636000],[3300000,0.20,427500],[1950000,0.10,97500],[1000,0.05,0]]
        tax_list.each do |i|
          if @saraly > i[0]
            tax = @saraly * i[1] - i[2]
            return tax
          end
        end
    end
end

print "手取りを計算します（年額）"
print "時給を入力："
hourly_wage = gets.to_i
print "労働時間を入力："
working_hour = gets.to_i

s = Saraly_Class.new(hourly_wage,working_hour)

puts "手取りは{#s.get_after_tax}円です。"