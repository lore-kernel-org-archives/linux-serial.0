Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C27996C;
	Thu, 21 Dec 2023 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="b5KtzAvH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=7TEnK/Z3hipz1x5knONUiV1aCkjkJZlxI+yRt9HAk+M=; b=b5KtzAvHWX5YwMloHiaXHDRnXP
	E1o52bGKL1LzovEuj8jU5Fm7mwgahKglKYZIt+fKS5RjlAdWDPLPG2t7x/jKJYW14tJvc0tCT8Goe
	7M+cT/IU6gxWnwnIdVnMbaCmJR7r1PPbt2DSd7mRukybxGzLEUNLyPNC3XRSKD1d9Fqw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJN-00025W-LT; Thu, 21 Dec 2023 18:18:42 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Dec 2023 18:18:15 -0500
Message-Id: <20231221231823.2327894-9-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221231823.2327894-1-hugo@hugovil.com>
References: <20231221231823.2327894-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 08/16] serial: sc16is7xx: use i2c_get_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use preferred i2c_get_match_data() instead of device_get_match_data()
and i2c_client_get_device_id() to get the driver match data.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 4161d692df40..e7f3184a70a1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1796,18 +1796,13 @@ MODULE_ALIAS("spi:sc16is7xx");
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
 static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	const struct sc16is7xx_devtype *devtype;
 	struct regmap *regmaps[2];
 	unsigned int i;
 
-	if (i2c->dev.of_node) {
-		devtype = device_get_match_data(&i2c->dev);
-		if (!devtype)
-			return -ENODEV;
-	} else {
-		devtype = (struct sc16is7xx_devtype *)id->driver_data;
-	}
+	devtype = i2c_get_match_data(i2c);
+	if (!devtype)
+		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
 
 	for (i = 0; i < devtype->nr_uart; i++) {
 		regcfg.name = sc16is7xx_regmap_name(i);
-- 
2.39.2

