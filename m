Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="KEht41Db"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911310EF;
	Thu, 30 Nov 2023 11:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=3PnQzZfqCWVmo+CDz3VaUAypnIbooDxJULrp2OY6blg=; b=KEht41DbYffU6ijOAh53f96ftD
	AtlM0PWbyApl6BpKhSjnIk8GaKfOhHkaFIMzykvAEh+Nz3YVTYbdP1eNdKytpd2/XY9Rljim+MgFn
	UCu6enfHxXSXkGRjSha326AhtlLEAKQ66xFvDQTyam8RV3PuQjZPggn9YlRrFmNY02/s=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r8mR7-0003sb-Qr; Thu, 30 Nov 2023 14:10:58 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com
Date: Thu, 30 Nov 2023 14:10:46 -0500
Message-Id: <20231130191050.3165862-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130191050.3165862-1-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
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
Subject: [PATCH 4/7] serial: sc16is7xx: add macro for max number of UART ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add macro to hold the maximum number of UART ports per IC/device.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index eb2c0dcd3775..750c55b93f5e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -28,6 +28,7 @@
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 #define SC16IS7XX_MAX_DEVS		8
+#define SC16IS7XX_MAX_PORTS		2 /* Maximum number of UART ports per IC. */
 
 /* SC16IS7XX register definitions */
 #define SC16IS7XX_RHR_REG		(0x00) /* RX FIFO */
@@ -1399,7 +1400,7 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 	int i;
 	int ret;
 	int count;
-	u32 irda_port[2];
+	u32 irda_port[SC16IS7XX_MAX_PORTS];
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "irda-mode-ports");
@@ -1426,7 +1427,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 	int i;
 	int ret;
 	int count;
-	u32 mctrl_port[2];
+	u32 mctrl_port[SC16IS7XX_MAX_PORTS];
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
@@ -1716,7 +1717,7 @@ static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
 static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[2];
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
 	unsigned int i;
 	int ret;
 
@@ -1791,7 +1792,7 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[2];
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
 	unsigned int i;
 
 	if (i2c->dev.of_node) {
-- 
2.39.2

