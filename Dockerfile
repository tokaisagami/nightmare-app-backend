# ベースイメージの指定
FROM ruby:3.1.4

# 環境変数の設定
ENV LANG=C.UTF-8 \
    APP_HOME=/app

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client && apt-get clean

# アプリケーションの作業ディレクトリを作成
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerのインストール
RUN gem install bundler
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . .

# コンテナ起動時にserver.pidを削除
RUN rm -f /app/tmp/pids/server.pid

# デフォルトのポートを指定
EXPOSE 3000

# アプリケーションの起動コマンド（必要に応じて変更）
CMD ["rails", "server", "-b", "0.0.0.0"]
