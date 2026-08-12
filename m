Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2054470E92
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548383; cv=none; b=e1If9dlI9GYrodD/K+tz11Aub+Jd12w5UngYfrqbjwiCWHgb2qz082+jLler6lYm4KusOeMrFHPenJhDXAhH1P64mjk1SZ3DswRLEFX98Bn1U8mXrHtapX4MicIXuvMbFxMC/TJRlzlj0lHgNz5nQCC4XFj7aGti6deo6O0kIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548383; c=relaxed/simple;
	bh=mIEIYQbxzNIkZ3zcjSnONFWqLSp6osN6SN3mzfx33Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLaavkufgCQKbMamiWysLC6uwOccjxzXrKHB4JxfGwlEh2rD06VpaSmRYA3gsE5ocVqaMtmhXDYLb+fysCDswbmkZ4FvJc9qlT9Odocih7ag99C6jocKPCoFjFZ/ugjwm0TUavcbrYSBxwguYeCVHngS4uSZ4Xnj3bupl5Gq7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DecKbe3q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DecKbe3q"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so642354f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786548373; x=1787153173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J92dMQs6IMyTDyAGWTnLdC2/ApicW6giGlkFuqEPXcY=;
        b=DecKbe3q6NAyJGvTBifchrb5MjXNKdFtIDsZgec5NEeZqnb8CyOoeDFEDlVJB/jALP
         Bi5IgQdRVgMR940txmb4GL0oD9KJ3KB1xma73EjE1JjlHq/gSRFdyxYtHTWbyI5ve93X
         Xsne2KciZQEx6Cnv0iXI8YCQqS33VRML8ZuzqZ9jrSL/vrmwjF6hbAX5cayVD8dj6b9y
         TlamzNm3iA61KSDAW0sXQ6xnpcaqyAoMUBE9AWhrk7K4Jh3xvq+AV52RB4HsBIP2J8Va
         8oWOdzGk6taOcBxsJLvU3btOKcTC4N+ROHR/90ntf2OOqLKZRzpn8vkz2Ut+X8aE5yE9
         rVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548373; x=1787153173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J92dMQs6IMyTDyAGWTnLdC2/ApicW6giGlkFuqEPXcY=;
        b=Q3uBxnwx3BPSa4QqDtTbL42LZqY2aXTCIBv2QMgRh34IsyGkIGzKNORPE5UeJCXoGL
         BjvHVey1qe5B7jFo+oKt7mUYaRoAlF+LKWXVBVh06FD9WLOKXOthN71XbUKWEGYOGFGp
         ZdB9/uTpDCbsnwEEv1cXQnzoX7ysuO2PTQzyhY0dMssOxd7tLny4i5iBMPy+WLBPOCMx
         n4Vj5BRu84kRxW2GiNr1ycT33LCOkoekvU6S2zdPBRMgN60Mz95bpDlehuBOJCoUFcwB
         qPQfJv0qiZJ8cucuA4YpdllgbGjIMQ3aYI+78lvvEOb1g1dBaSxUdmv676m3BKldWXlS
         Pjgg==
X-Forwarded-Encrypted: i=1; AHgh+RqFUuI10ZbPz2wJ5okjFjogqnAuqswxOvS7dLlxvA2r52aFIqQFgC7uiqGTf6MVZ2b3nTk0QHm5Rl/J3PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOP0+FyQbTs+0Phu+ovJnHUFzgqq+2pe6fXtk3JiYW+tdB+43
	GlGQl/6wYX0gqvbgyJjTYM9PFKdYudlsuXf9rFgHCjtirnqIDElOdeF21uViyx+7Dyc=
X-Gm-Gg: AR+sD12tnWRm+TPxtSgFMRcLvJFRfdmHvy0JHr3liIvUDs7of9yNkCHfcWqQ81hoW4k
	04Y4epF15P6GZc0GBQYlfpQYiOlhESv3HugkeA7BHA4WTrKtoQfXKxFhQq39/t2fgtMr67Q5Cz2
	4Ectm7w4XSvP8CfPwyTu/0SYjXjx7dZq5cC5unR+/BtNy8dVS41mgNwf0M1Gy0lSvViMtjY8uI5
	sauRTY+uK+Tcbb+jWbOVvN7ocOg4COlMhZHGrUujaeN3IHFIZZHSLgT/kd5ryfgjbC4nP/rGk0o
	AOgL6aXA5F9xo11+1d6boi6zSRU6LxpNu5xccL2YGMRwU5g152QMCvX9m52qsBAV6xMTVelI459
	Vt3QUytjeH4LZIvqMVkbseZIZecaPgw284I428q/M8UArUKhQcwXmU3hAQ/zFIXrRB//C/kLySR
	YeoOelPD0VDjERLrS8OrkVUj1jWPacp2EkgOWbSBGZI2AF44/YHrBKnlGUf3AU/pTKEVRhbHsci
	wf7mNe09UkMvcni+4Naq7hESPsR8z8XFH8+gDjK//5/EpFSJBk=
X-Received: by 2002:a05:6000:2a0c:b0:47d:ea8a:d224 with SMTP id ffacd0b85a97d-48152b10331mr7156134f8f.23.1786548372494;
        Wed, 12 Aug 2026 08:26:12 -0700 (PDT)
Received: from localhost (p200300f65f017104d1b8d865063c5703.dip0.t-ipconnect.de. [2003:f6:5f01:7104:d1b8:d865:63c:5703])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48150d4e3f5sm8088682f8f.22.2026.08.12.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:26:11 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/3] serial: tegra-tcu: Make use of dev_err_probe() in .probe()
Date: Wed, 12 Aug 2026 17:25:53 +0200
Message-ID:  <e5a1565edc2b8c0241827f4b9c40c53fca064415.1786547950.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
References: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=mIEIYQbxzNIkZ3zcjSnONFWqLSp6osN6SN3mzfx33Xk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqfJCEBLM6FoaOCMow0JlUmDXcZnMO3v90qiKo0 R6NLHlaYpeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanyQhAAKCRCPgPtYfRL+ Tu1/CAC5Jp/w5ghH9LWrObkngzLmqfCUxpWMs8xqi7KPxprHgYlu59s3evVCVUEPX3S8IiTFeoe 9PHOWGJ4iGzXVFbu9yCk+i1brPxmWkNV8MCMaog/karEzt8Qg8qdurcFOIoJHLSX91P/HaFwhkX Gsx+YjxvpV22hgO2dkjxGeNtvAImWpduVuibxBT1eyLaVTcKF2Qo25jDEvLtSVlZ8rzvvvm7SLe A/yhY2vN4bRbJ15W8O2+hrrSGFXGiSKP/wBvr+eARi8vR+jx1aFdDjb2BQxjts/zK9uxMZ+DBx9 UopMsiwi40s0+AB3b5/JSlkIqrc79PYoXHR/CGAM7UxUPOns
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Usage of dev_err_probe() is (sometimes) a bit more compact than
dev_err(), it properly handles ENOMEM and EPROBE_DEFER and emits the
error code symbolically.

Also introduce a variable to hold &pdev->dev to reduce line length a
bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/tegra-tcu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 7033dbfe8ba1..077023ce1842 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -179,9 +179,10 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	struct tegra_tcu *tcu;
+	struct device *dev = &pdev->dev;
 	int err;
 
-	tcu = devm_kzalloc(&pdev->dev, sizeof(*tcu), GFP_KERNEL);
+	tcu = devm_kzalloc(dev, sizeof(*tcu), GFP_KERNEL);
 	if (!tcu)
 		return -ENOMEM;
 
@@ -190,11 +191,9 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	tcu->rx_client.rx_callback = tegra_tcu_receive;
 
 	tcu->tx = mbox_request_channel_byname(&tcu->tx_client, "tx");
-	if (IS_ERR(tcu->tx)) {
-		err = PTR_ERR(tcu->tx);
-		dev_err(&pdev->dev, "failed to get tx mailbox: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(tcu->tx))
+		return dev_err_probe(dev, PTR_ERR(tcu->tx),
+				     "failed to get tx mailbox\n");
 
 #if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
 	/* setup the console */
@@ -218,15 +217,14 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 
 	err = uart_register_driver(&tcu->driver);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register UART driver: %d\n",
-			err);
+		dev_err_probe(dev, err, "failed to register UART driver\n");
 		goto free_tx;
 	}
 
 	/* setup the port */
 	port = &tcu->port;
 	spin_lock_init(&port->lock);
-	port->dev = &pdev->dev;
+	port->dev = dev;
 	port->type = PORT_TEGRA_TCU;
 	port->ops = &tegra_tcu_uart_ops;
 	port->fifosize = 1;
@@ -236,7 +234,7 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 
 	err = uart_add_one_port(&tcu->driver, port);
 	if (err) {
-		dev_err(&pdev->dev, "failed to add UART port: %d\n", err);
+		dev_err_probe(dev, err, "failed to add UART port\n");
 		goto unregister_uart;
 	}
 
@@ -246,8 +244,8 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	 */
 	tcu->rx = mbox_request_channel_byname(&tcu->rx_client, "rx");
 	if (IS_ERR(tcu->rx)) {
-		err = PTR_ERR(tcu->rx);
-		dev_err(&pdev->dev, "failed to get rx mailbox: %d\n", err);
+		err = dev_err_probe(dev, PTR_ERR(tcu->rx),
+				    "failed to get rx mailbox\n");
 		goto remove_uart_port;
 	}
 
-- 
2.47.3

