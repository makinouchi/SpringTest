# 使用するベースイメージ（JDK 21）
FROM eclipse-temurin:21-jdk AS build

# 作業ディレクトリを作成
WORKDIR /app

# プロジェクトのソースコードをコンテナにコピー
COPY . .

# Gradle Wrapper（gradlew）に実行権限を付与
RUN chmod +x ./gradlew

# Gradleを実行してアプリをビルド
RUN ./gradlew bootJar

# 実行用の軽量イメージを使用（JREのみ）
FROM eclipse-temurin:21-jre

# 作業ディレクトリを作成
WORKDIR /app

# ビルド済みのJARファイルをコピー
COPY --from=build /app/build/libs/*.jar app.jar

# アプリを実行
CMD ["java", "-jar", "app.jar"]