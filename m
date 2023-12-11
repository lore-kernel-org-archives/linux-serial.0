Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="DUFKQAyL"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE81C4;
	Mon, 11 Dec 2023 09:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=4MZPg2i3rujQttpfPCL8eU07qXSR85CK/sdmzfjW7BA=; b=DUFKQAyLz+HfJDVdVEG9kezmd1
	DA0UHuh7jjvotZvmvN2lncQl85w3Cs6fH26SE4WIdJ+N125wW2QF7oCEi3+NoZ4dXbs42vroZtyfo
	uH//9auPztSjt3smMtoD7aEVsT2XAIMndYWmo3jVS1Jpv1Ph8LhxZtrsnCwARhD4CdZU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56730 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjqy-0003yC-T5; Mon, 11 Dec 2023 12:14:01 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com,
	tomasz.mon@camlingroup.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	stable@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Dec 2023 12:13:49 -0500
Message-Id: <20231211171353.2901416-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211171353.2901416-1-hugo@hugovil.com>
References: <20231211171353.2901416-1-hugo@hugovil.com>
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
Subject: [PATCH v2 2/6] serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Remove global struct regmap so that it is more obvious that this
regmap is to be used only in the probe function.

Also add a comment to that effect in probe function.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc: stable@vger.kernel.org
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8d1de4982b65..a4ad3ae8cae2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -334,7 +334,6 @@ struct sc16is7xx_one {
 
 struct sc16is7xx_port {
 	const struct sc16is7xx_devtype	*devtype;
-	struct regmap			*regmap;
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
@@ -1434,7 +1433,8 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 /*
  * Configure ports designated to operate as modem control lines.
  */
-static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
+static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
+				       struct regmap *regmap)
 {
 	int i;
 	int ret;
@@ -1463,7 +1463,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
 
 	if (s->mctrl_mask)
 		regmap_update_bits(
-			s->regmap,
+			regmap,
 			SC16IS7XX_IOCONTROL_REG,
 			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
 			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
@@ -1495,6 +1495,10 @@ static int sc16is7xx_probe(struct device *dev,
 	 * This device does not have an identification register that would
 	 * tell us if we are really connected to the correct device.
 	 * The best we can do is to check if communication is at all possible.
+	 *
+	 * Note: regmap[0] is used in the probe function to access registers
+	 * common to all channels/ports, as it is guaranteed to be present on
+	 * all variants.
 	 */
 	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
 	if (ret < 0)
@@ -1530,7 +1534,6 @@ static int sc16is7xx_probe(struct device *dev,
 			return -EINVAL;
 	}
 
-	s->regmap = regmaps[0];
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 	mutex_init(&s->efr_lock);
@@ -1545,7 +1548,7 @@ static int sc16is7xx_probe(struct device *dev,
 	sched_set_fifo(s->kworker_task);
 
 	/* reset device, purging any pending irq / data */
-	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG,
+	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
@@ -1616,7 +1619,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	sc16is7xx_setup_irda_ports(s);
 
-	ret = sc16is7xx_setup_mctrl_ports(s);
+	ret = sc16is7xx_setup_mctrl_ports(s, regmaps[0]);
 	if (ret)
 		goto out_ports;
 
-- 
2.39.2

