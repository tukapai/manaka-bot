# Description:
#   manaka do something
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   huga - output huga
#   hubot search <keyword> - send get and post request to `example.com`
#
# Notes:
#   this is an example code for hubot-script.
#
# Author: tukapai
#


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

  robot.hear /^(.+)\+\+$/i, (msg) ->
    user = msg.match[1]

    if not robot.brain.data[user]
      robot.brain.data[user] = 0

    robot.brain.data[user]++
    robot.brain.save()

    msg.send robot.brain.data[user]

  robot.respond /ascii( me)? (.+)/i, (msg) ->
    msg
      .http("http://asciime.herokuapp.com/generate_ascii")
      .query(s: msg.match[2].split(' ').join('  '))
      .get() (err, res, body) ->
        msg.send body



module.exports = (robot) ->

  # hearするとチャットルームのメッセージを監視できる
  # チャットルームで hoge って打ち込むと huga って返す
  # msgオブジェクトの中にはuserNameとかが入ってて、メンション飛ばせたりする
  robot.hear /hoge/i, (msg) ->
    msg.send 'huga'
    msg.send "@#{msg.message.user.name}, foo bar."
    # reply使うとメッセージを送ったユーザーにリプライできるっぽい
    msg.reply 'foooo'

  # respondすると hubot search `something` のようにhubotに命令できる
  # http (get, post) もできたりするので組み合わせると面白いかも
  robot.respond /search (.*)/i, (msg) ->
    searchText = msg.match[1]
    data =
      hoge: 'hoge'
      fuga: 'fuga'
    robot.http('http://example.com')
      .get() (err, res, body) ->
        if err
          msg.send "sorry, #{msg.message.user.name}. I cannot understand..."
        # 返ってきた値を使って何かする
        msg.send "#{res.data}"
      .post(data) (err, res, body) ->
        # 同上
