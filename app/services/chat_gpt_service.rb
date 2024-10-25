require 'openai'

class ChatGptService
  def self.modify_nightmare(nightmare, ending_type)
    client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY'])
    model = 'gpt-4o' # もしくは 'gpt-4o-mini'

    prompt = case ending_type
             when 0
               "あなたは優秀な物語のライターです。次の悪夢の内容をハッピーエンドに改変してください。
                悪夢の内容：#{nightmare}"
             when 1
               "あなたはボボボーボ・ボーボボの原作者と同じ思考回路を持ったAIです。次の悪夢の内容を予想外の結末に改変してください。
                ただし、ボボボーボ・ボーボボの登場キャラは出さずにお願いします。
                悪夢の内容：#{nightmare}"
             else
               "以下の悪夢の内容を改変してください。悪夢の内容：#{nightmare}"
             end

    response = client.completions(
      model: model,
      prompt: prompt,
      max_tokens: 300
    )

    response['choices'][0]['text'].strip
  end
end
