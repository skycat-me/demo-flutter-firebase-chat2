# chat

## About

Flutter で Firebase Auth/Firestore を利用したデモプロジェクトです。

[Flutter アプリに Firebase を追加する | Firebase](https://firebase.google.com/docs/flutter/setup?hl=ja) を参考にプロジェクトに Firebase を追加してください。

(BundleIDは `com.example.app.firebase.chat` になります)

iOS は `GoogleService-Info.plist`, Android は `google-services.json` が 必要です。

また、iOS は `Runner/info.plist` の `CFBundleURLTypes->CFBundleURLSchemes` の中身を利用するプロジェクトの`REVERSED_CLIENT_ID`にする必要があります
(`REVERSED_CLIENT_ID`は`GoogleService-Info.plist`にあります)。
