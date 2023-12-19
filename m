Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513337145;
	Tue, 19 Dec 2023 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="eg5+ieEI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=HhHbtgJLUFnfTgDCXdi3cYtYacZcjPvaik0ZgmPx/5k=; b=eg5+ieEIjziTn7rV3RSBdTZFQc
	ENwvgwAHp3L/GkvwUsDJAHJ1V1WwnWz0QaFfCccwuCsOGEhE6WLro8PONzp6NvGnFXR/7i/wVOk2Y
	4AGjYFJhCKJFuT4LmeX632Bst13yFAzsBlcTmJXDhZWCGkDCnpI+luF7Hon9a2oo9wJk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkR-0007Ao-Mo; Tue, 19 Dec 2023 12:19:16 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 19 Dec 2023 12:18:53 -0500
Message-Id: <20231219171903.3530985-10-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
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
Subject: [PATCH 09/18] serial: sc16is7xx: add macro for max number of UART ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add macro to hold the maximum number of UART ports per IC/device.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3fb99b6929f3..29844e2eefc5 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -28,6 +28,7 @@
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 #define SC16IS7XX_MAX_DEVS		8
+#define SC16IS7XX_MAX_PORTS		2 /* Maximum number of UART ports per IC. */
 
 /* SC16IS7XX register definitions */
 #define SC16IS7XX_RHR_REG		(0x00) /* RX FIFO */
@@ -1396,11 +1397,11 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 	int i;
 	int ret;
 	int count;
-	u32 irda_port[2];
+	u32 irda_port[SC16IS7XX_MAX_PORTS];
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "irda-mode-ports");
-	if (count < 0 || count > ARRAY_SIZE(irda_port))
+	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
 		return;
 
 	ret = device_property_read_u32_array(dev, "irda-mode-ports",
@@ -1423,11 +1424,11 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 	int i;
 	int ret;
 	int count;
-	u32 mctrl_port[2];
+	u32 mctrl_port[SC16IS7XX_MAX_PORTS];
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
-	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
+	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
 		return 0;
 
 	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
@@ -1471,6 +1472,8 @@ static int sc16is7xx_probe(struct device *dev,
 	int i, ret;
 	struct sc16is7xx_port *s;
 
+	WARN_ON(devtype->nr_uart > SC16IS7XX_MAX_PORTS);
+
 	for (i = 0; i < devtype->nr_uart; i++)
 		if (IS_ERR(regmaps[i]))
 			return PTR_ERR(regmaps[i]);
@@ -1730,7 +1733,7 @@ static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
 static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[2];
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
 	unsigned int i;
 	int ret;
 
@@ -1800,7 +1803,7 @@ MODULE_ALIAS("spi:sc16is7xx");
 static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 {
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[2];
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
 	unsigned int i;
 
 	devtype = (struct sc16is7xx_devtype *)i2c_get_match_data(i2c);
-- 
2.39.2

