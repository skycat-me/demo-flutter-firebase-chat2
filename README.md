# chat

## About

Flutter で Firebase Auth/Firestore を利用したデモプロジェクトです。

[Flutter アプリに Firebase を追加する | Firebase](https://firebase.google.com/docs/flutter/setup?hl=ja) を参考にプロジェクトに Firebase を追加してください。

iOS は `google-services.json`, Android は `GoogleService-Info.plist` が 必要です。

また、iOS は `Runner/info.plist` の `CFBundleURLTypes->CFBundleURLSchemes` の中身を利用するプロジェクトの`REVERSED_CLIENT_ID`にする必要があります
(`REVERSED_CLIENT_ID`は`GoogleService-Info.plist`にあります)。
