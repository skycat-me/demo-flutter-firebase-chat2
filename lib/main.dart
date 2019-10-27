import 'package:chat/chat.dart'; // 今回に必要な依存のあるライブラリを読み込みます
import 'package:flutter/material.dart'; // マテリアルデザインのUIコンポーネント

// メイン、最初に実行されます
void main() => ({
      WidgetsFlutterBinding.ensureInitialized(),
      runApp(MyApp()),
    });

/*

    runAppでMyAppを呼び出している。これが実態。
    > app.dartへ。

    注意：
    Flutter 1.9.4からネイティブプラグイン使っている場合は、
    `WidgetsFlutterBinding.ensureInitialized()`を初めに呼ぶ必要ができた(　´･‿･｀)
    dev/masterチャンネルの場合注意(　´･‿･｀)
    https://twitter.com/_mono/status/1165511095949283328
 */
