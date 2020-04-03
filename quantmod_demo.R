#下載quantmod 包
install.packages('quantmod')

#引入
library(quantmod)

#抓資料 : 去yahoo查詢股票代碼 // 台股上市 XXXX.TW 台股上櫃 XXXX.TWO
# 抓APPLE 代號 AAPL
# auto,assign 一定要FALSE // 日期可以自訂,若無自定會從2007年開始抓
Apple <- loadSymbols('AAPL',auto.assign=FALSE,from="2019-01-01",to="2020-04-01")

#開始畫圖: lineChart 
# line.type 有7種可以選 詳情見講義 theme 可以換成black
# TA可以自己加 : TA :"addCCI();addSMA()"  詳情看講義連結
lineChart(Apple,line.type = 'h', theme = 'white', TA = NULL)

#把TA = NULL 拿掉就可以看見成交量(VOL)
lineChart(Apple,line.type = 'h', theme = 'black')

#barChart
barChart(Apple,line.type = 'hlc', theme = 'black',TA=NULL)

#candleChart K線理論(我也是不太懂,可以去查看看)
# 重點是要設置subset 看要統計哪個時間區間內的值
#以下都是可以使用的語法
candleChart(Apple, TA=NULL, subset = '2020')

candleChart(Apple, TA=NULL, subset = 'last 2 month')

candleChart(Apple, TA=NULL, subset = '2019-12-25::2020-3-25')

#來試著加入TA 吧~ MACD = 指數平滑異同移動平均線 
candleChart(Apple, TA=c(addMACD(),addVo()), subset = 'last 3 month')

#來試著加入TA 吧~ ADX = 平均趨向指標
candleChart(Apple, TA=c(addMACD(),addADX()), subset = 'last 3 month')

#來找點數字吧
ma5 <- SMA(Apple$"AAPL.Close",n=5) #n = 幾天一期 常用的有5天或20天
cc20 <- CCI(Apple$"AAPL.Close",n=20)

#黃金交叉
ma5 <- SMA(Apple$"AAPL.Close",n=5)
ma20 <- SMA(Apple$"AAPL.Close",n=20)
ma5>ma20 #回傳每一天的True /False
ma5[ma5>ma20] #回傳當時股價
index(ma5[ma5>ma20]) #回傳日期

#對了,如果你不想要用截圖的話可以使用以下方式儲存你的plot
jpeg(file="filename.jpeg")

candleChart(Apple, TA=c(addMACD(),addADX()), subset = 'last 3 month')

dev.off() #把控制權還給主控台

# 最後show 個看起來很厲害的plot 
#addSMA()會顯示在股價的圖裡面,有些TA會這樣,像是addBBands()
chartSeries(Apple, 
            type = c("auto", "matchsticks"), 
            subset = 'last 3 month',
            show.grid = TRUE,
            major.ticks='auto', minor.ticks=TRUE,
            multi.col = FALSE,
            TA=c(addMACD(),addVo(),addSMA(n=200,col = 'blue'),addSMA(n=50,col = 'red'),addSMA(n=22,col = 'green'),
            addROC(n=200,col = 'blue'),addROC(n=50,col = 'red'),addROC(n=22,col = 'green'))) # rate of change













