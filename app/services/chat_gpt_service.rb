require 'openai'

class ChatGptService
  def self.modify_nightmare(nightmare, ending_type)
    client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY'])
    model = 'gpt-4o'
#    model = 'gpt-4o-mini'

    prompt = case ending_type
             when 0
               "あなたは優秀な物語のライターです。\n次の悪夢の内容をはじめからまるごとハッピーエンドに改変してください。\n悪夢の内容：#{nightmare}"
             when 1
               "あなたはボボボーボ・ボーボボの原作者と同じ思考回路を持ったAIです。\n次の悪夢の内容をボボボーボ・ボーボボの展開のようにめちゃくちゃな内容にはじめからまるごと改変してください。\nただし、ボボボーボ・ボーボボの登場キャラは出さずにお願いします。\n悪夢の内容：#{nightmare}"
             else
               "以下の悪夢の内容を改変してください。\n悪夢の内容：#{nightmare}"
             end

    response = client.completions(
      model: model,
      prompt: prompt,
      max_tokens: 300
    )

    response['choices'][0]['text'].strip
  end
end
