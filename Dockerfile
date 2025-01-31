# 使用するベースイメージ（JDK 17）
FROM eclipse-temurin:17-jdk AS build

# 作業ディレクトリを作成
WORKDIR /app

# プロジェクトのソースコードをコンテナにコピー
COPY . .

# Gradleを実行してアプリをビルド
RUN ./gradlew bootJar

# 実行用の軽量イメージを使用（JREのみ）
FROM eclipse-temurin:17-jre

# 作業ディレクトリを作成
WORKDIR /app

# ビルド済みのJARファイルをコピー
COPY --from=build /app/build/libs/*.jar app.jar

# アプリを実行
CMD ["java", "-jar", "app.jar"]