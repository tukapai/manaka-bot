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

 #　いいねってしたら＋1カウントするやつ
  robot.hear /^(.+)\+\+$/i, (msg) ->
    user = msg.match[1]

    if not robot.brain.data[user]
      robot.brain.data[user] = 0

    robot.brain.data[user]++
    robot.brain.save()

    msg.send robot.brain.data[user]

  # genarate asciime
  robot.respond /ascii( me)? (.+)/i, (msg) ->
    msg
      .http("http://asciime.herokuapp.com/generate_ascii")
      .query(s: msg.match[2].split(' ').join('  '))
      .get() (err, res, body) ->
        msg.send body

 # 今日何曜日だっけに答えてくれるやつ
   robot.respond　/今日は何曜日？/i => {

    request.get({
      url: 'http://api.sekido.info/qreki?output=json',
      headers: {
        'User-Agent': 'Hubot'
      }
    }, (err, res, body) => {
        let parsedBody = JSON.parse(body);
        console.log(parsedBody.rokuyou_text);
        msg.send(`今日は${JSON.parse(body).rokuyou_text}です`);
    });
  });


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

  # key score sample
  KEY_SCORE = 'key_score'

  getScores = () ->
    return robot.brain.get(KEY_SCORE) or {}

  changeScore = (name, diff) ->
    source = getScores()
    score = source[name] or 0
    new_score = score + diff
    source[name] = new_score

    robot.brain.set KEY_SCORE, source
    return new_score

  robot.respond /list/i, (msg) ->
    source = getScores()
    console.log source
    for name, score of source
      msg.send "#{name}: #{score}"

  robot.hear /^(.+)\+\+$/i, (msg) ->
    name = msg.match[1]
    new_score = changeScore(name, 1)
    msg.send "#{name}: #{new_score}"

  robot.hear /^(.+)--$/i, (msg) ->
    name = msg.match[1]
    new_score = changeScore(name, -1)
    msg.send "#{name}: #{new_score}"
