require 'openai'

class ChatGptService
  def self.modify_nightmare(nightmare, ending_category)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    model = 'gpt-4o-mini'  # または 'gpt-4o'

    # ending_categoryを整数に変換
    ending_category = ending_category.to_i

    messages = [
      { role: 'system', content: case ending_category
                               when 1
                                 "あなたはボボボーボ・ボーボボの作者と同じ思考回路を持つ物語製作者です。以下の指示を絶対に守ってください。"
                               else
                                 "あなたは優秀な物語のライターです。以下の指示を絶対に守ってください。"
                               end },
      { role: 'user', content: case ending_category
                               when 0
                                 "次の悪夢の内容をハッピーエンドに改変してください。次の条件を必ず遵守してください。1.回答は改変した悪夢の内容だけでお願いします。2.改行の挿入は不要です。3.1000字以内で完結させてください。悪夢の内容：#{nightmare}"
                               when 1
                                 "次の悪夢の内容をボボボーボ・ボーボボの展開のようにめちゃくちゃな結末に改変してください。次の条件を必ず遵守してください。1.ボボボーボ・ボーボボの登場キャラは出さずにお願いします。2.改行の挿入は不要です。3.回答は改変した悪夢の内容だけでお願いします。4.1000字以内で完結させてください。5.最低限悪夢の内容は残してください。悪夢の内容：#{nightmare}"
                               else
                                 "以下の悪夢の内容を改変してください。次の条件を必ず遵守してください。1.回答は改変した悪夢の内容だけでお願いします。2.改行の挿入は不要です。3.400字以内で完結させてください。悪夢の内容：#{nightmare}"
                               end }
    ]

    puts messages
    response = client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: 0.0,
        max_tokens: 1000
      }
    )

    response.dig("choices", 0, "message", "content").strip
  end
end
