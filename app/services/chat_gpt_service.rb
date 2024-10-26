require 'openai'

class ChatGptService
  def self.modify_nightmare(nightmare, ending_category)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    model = 'gpt-4o'  # または 'gpt-4-turbo'
    messages = [
      { role: 'system', content: case ending_category
                               when 1
                                 "あなたはボボボーボ・ボーボボの作者と同じ思考回路を持つ物語製作者です。"
                               else
                                 "あなたは優秀な物語のライターです。"
                               end },
      { role: 'user', content: case ending_category
                               when 0
                                 "次の悪夢の内容をはじめからまるごとハッピーエンドに改変してください。回答は改変した悪夢の内容だけでお願いします。改行の挿入は不要です。文字数は500字以内でお願いします。悪夢の内容：#{nightmare}"
                               when 1
                                 "次の悪夢の内容をボボボーボ・ボーボボの展開のようにめちゃくちゃな内容にはじめからまるごと改変してください。 ただし、ボボボーボ・ボーボボの登場キャラは出さずにお願いします。 改行の挿入は不要です。回答は改変した悪夢の内容だけでお願いします。文字数は500字以内でお願いします。悪夢の内容：#{nightmare}"
                               else
                                 "以下の悪夢の内容を改変してください。悪夢の内容：#{nightmare}"
                               end }
    ]

    response = client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: 0.8,
        max_tokens: 300
      }
    )

    # temperatureパラメータは、AIモデルの応答の創造性や多様性を制御するためのものです。
    # 値が0.0に近いほど、モデルはより決定的（予測可能）な応答を生成します。
    # 逆に、値が1.0に近いほど、生成される応答はより創造的で予測不可能になります。
    response.dig("choices", 0, "message", "content").strip
  end
end
