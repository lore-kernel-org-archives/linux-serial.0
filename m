Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81523368A6;
	Fri, 17 Apr 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437636; cv=none; b=qqFggkP9v2xK8zY59hv3ieN5Yn6ahH8J3HOgebOa4E5zA94FLBS25RCbezXyT0jy8Q3ldfDD0jgW9hIB8Aq/KXdZ6gkChxlEr2CrI/i1XvyIV5v8r4yzVAsdWYqBJgP1YEuatAAmmwP8dwbb4XQ+yVXKSYwHQYxzugWCoa+hzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437636; c=relaxed/simple;
	bh=+pIaZzAs214qq7wlqYLmJOyYlaKwAUslx+SMNpjIF34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqcUe423Fo1ekEoZPqLDvC2v2Umyl7AXSBIfeQpavI2EKnvn3vyW4oZpavXM1yp+j4zOU6uD8ySl/Yn5QgycnbxTHdR0mFjxxJr4uvr3W9WrT08RhHUeg9VoXboFxDytDQw2IV+Xvk4G7OdPnlb9R7iEm52n1b0xbqb4kWN6iMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Vu3Tx5bz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Vu3Tx5bz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=dEidonsVfR94iviIc/z1aiRPexoSv2nJaBbs9rX+3KE=; b=Vu3Tx5bzoAHootUXl12wTzH56X
	WJG7gNfoo+pkT6ImfyU9KQ75Q/S44gvF4x7gh2c6ecUSV3s2AicvTcRyxNxWdwvrd5na/E93ESzUo
	MxRW+2Wt14krJdN5LW6P/E5+rqnBhwaAL4Nhrno1sk1GOKmBFIQBPO+v3WxO3ytihfeQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZm-000000006G1-3IHz;
	Fri, 17 Apr 2026 10:53:47 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:33 -0400
Subject: [PATCH 06/10] serial: max310x: use regmap_read_poll_timeout() for
 busy wait
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-6-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify busy wait stages by using regmap_read_poll_timeout().

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Note that the "val" variable is move to the function scope in prevision for
reuse by the next patch.
---
 drivers/tty/serial/max310x.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 1cd7632831a2826ddd42127b1cde2a10dfa412f0..7ab5e4bd87ee6c87dd211bc52a3a4eb169a2b202 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -241,12 +241,12 @@
 #define MAX310X_WRITE_BIT		0x80
 
 /* Port startup definitions */
-#define MAX310X_PORT_STARTUP_WAIT_RETRIES	20 /* Number of retries */
-#define MAX310X_PORT_STARTUP_WAIT_DELAY_MS	10 /* Delay between retries */
+#define MAX310X_PORT_STARTUP_SLEEP_US	10000  /* Delay between retries */
+#define MAX310X_PORT_STARTUP_TIMEOUT_US	(20 * MAX310X_PORT_STARTUP_SLEEP_US) /* Total timeout */
 
 /* Crystal-related definitions */
-#define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
-#define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
+#define MAX310X_XTAL_SLEEP_US		10000  /* Delay between retries */
+#define MAX310X_XTAL_TIMEOUT_US		(20 * MAX310X_XTAL_SLEEP_US) /* Total timeout */
 
 /* MAX3107 specific */
 #define MAX3107_REV_ID			(0xa0)
@@ -587,7 +587,7 @@ static u8 max310x_pll_mult_to_id(u8 pll_mult)
 static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned int freq, unsigned int *fref, bool xtal)
 {
-	unsigned int div, fdiv, clksrc;
+	unsigned int div, fdiv, clksrc, val;
 	struct max310x_clk_config_t cfg;
 
 	cfg.err = UINT_MAX;
@@ -629,18 +629,13 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 	/* Wait for crystal */
 	if (xtal) {
-		bool stable = false;
-		unsigned int try = 0, val = 0;
+		int ret;
 
-		do {
-			msleep(MAX310X_XTAL_WAIT_DELAY_MS);
-			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
-
-			if (val & MAX310X_STS_CLKREADY_BIT)
-				stable = true;
-		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
-
-		if (!stable)
+		ret = regmap_read_poll_timeout(s->regmap, MAX310X_STS_IRQSTS_REG,
+					       val, val & MAX310X_STS_CLKREADY_BIT,
+					       MAX310X_XTAL_SLEEP_US,
+					       MAX310X_XTAL_TIMEOUT_US);
+		if (ret)
 			return dev_err_probe(dev, -EAGAIN,
 					     "clock is not stable\n");
 	}
@@ -1346,8 +1341,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
-		bool started = false;
-		unsigned int try = 0, val = 0;
+		unsigned int val;
 
 		/* Reset port */
 		regmap_write(regmaps[i], MAX310X_MODE2_REG,
@@ -1356,15 +1350,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		regmap_write(regmaps[i], MAX310X_MODE2_REG, 0);
 
 		/* Wait for port startup */
-		do {
-			msleep(MAX310X_PORT_STARTUP_WAIT_DELAY_MS);
-			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &val);
-
-			if (val == 0x01)
-				started = true;
-		} while (!started && (++try < MAX310X_PORT_STARTUP_WAIT_RETRIES));
-
-		if (!started) {
+		ret = regmap_read_poll_timeout(regmaps[i], MAX310X_BRGDIVLSB_REG,
+					       val, val == 0x01,
+					       MAX310X_PORT_STARTUP_SLEEP_US,
+					       MAX310X_PORT_STARTUP_TIMEOUT_US);
+		if (ret) {
 			ret = dev_err_probe(dev, -EAGAIN, "port reset failed\n");
 			goto out_uart;
 		}

-- 
2.47.3

