# 使用するベースイメージ（JDK 17）
FROM eclipse-temurin:17-jdk AS build

# 作業ディレクトリを作成
WORKDIR /app

# プロジェクトのソースコードをコンテナにコピー
COPY . .

# Gradle Wrapper（gradlew）に実行権限を付与
RUN chmod +x ./gradlew

# Gradleを実行してアプリをビルド（ログを出力しやすくする）
RUN ./gradlew bootJar --stacktrace --info