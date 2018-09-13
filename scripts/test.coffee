
module.exports = (robot) ->

  robot.hear /おはよう/i, (res) ->
    res.send "おはよう😊"

  robot.hear /今日もいい天気だね/i, (res) ->
    res.send "そうだね、今日も一日頑張ろう😄"

  robot.hear /今日の運勢は？/i, (res) ->
    luck = ['大吉', '中吉', '小吉']
    res.send "今日の運勢は"　res.random luck　"だよ！"

  robot.respond /(.*) ++/i, (res) ->
    user_name = res.match[1]
    happy = ['すばらしい！', 'すごい', 'いいね']
      res.reply res.random happy

  robot.respond /(.*) --/i, (res) ->
    user_name = res.match[1]
    chearup = ['頑張って！', '負けないで！', 'まだ戦えるよ！']
      res.reply res.random chearup

  TODO:ランダム格言するBotを探す

  robot.hear /ランダム格言/i, (res) ->
    res.emote "いま準備中！"
