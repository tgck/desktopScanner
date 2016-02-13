OSC Sender
===========

oscsend コマンドのシェルスクリプトラッパ。
渡した引数から、OSC型を補完して相手に送出します。

A simple shell script that routes plain message 
to OSC client.

#### つかい方

```
# 送り手
echo 123 12 10.5 string | ./sender.sh
```

```
# 受け手
$ tcpdump 1234
/foo/message1 iifs 123 12 10.500000 "string"

```

#### 制約

以下はハードコーディングです。

* 送信先アドレス `127.0.0.1`
* 送信先ポート `1234`
* メッセージのタグ `/foo/message1`
