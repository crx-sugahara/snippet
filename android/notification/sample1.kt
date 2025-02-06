 override fun onMessageReceived(remoteMessage: RemoteMessage) {
        // プッシュ通知受信時の処理

        // ペイロードを解析
        if (remoteMessage.notification != null) {
            val title = remoteMessage.notification!!.title
            val body = remoteMessage.notification!!.body
            val url = remoteMessage.data["url"]

            // WebView を開く
            if (url != null) {
                val intent = Intent(this, WebViewActivity::class.java)
                intent.putExtra("url", url)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
            }
        }
    }