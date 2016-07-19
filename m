From: Florian Vallee <fvallee@eukrea.fr>
Subject: [PATCH] sc16is7xx: make sure device is in suspend once probed
Date: Tue, 19 Jul 2016 16:29:36 +0200
Message-ID: <1468938576-19508-1-git-send-email-fvallee@eukrea.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Vallee <fvallee@eukrea.fr>
List-Id: linux-serial@vger.kernel.org

  Previously sc16is7xx_power was called in order to set the device to a
  low power mode.

  However since SC16IS7XX_EFR_ENABLE_BIT was not set beforehand this
  suspend request had not effect.

  Also, soft-reset the device prior to port initialization. It may
  otherwise be in a state (interrupt pending, fifo not empty) which
  prevents it from sleeping.

Signed-off-by: Florian Vallee <fvallee@eukrea.fr>
---
 drivers/tty/serial/sc16is7xx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index f36e6df..a9d94f7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1205,6 +1205,10 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 #endif
 
+	/* reset device, purging any pending irq / data */
+	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
+			SC16IS7XX_IOCONTROL_SRESET_BIT);
+
 	for (i = 0; i < devtype->nr_uart; ++i) {
 		s->p[i].line		= i;
 		/* Initialize port data */
@@ -1234,6 +1238,22 @@ static int sc16is7xx_probe(struct device *dev,
 		init_kthread_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
 		/* Register port */
 		uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
+
+		/* Enable EFR */
+		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
+				     SC16IS7XX_LCR_CONF_MODE_B);
+
+		regcache_cache_bypass(s->regmap, true);
+
+		/* Enable write access to enhanced features */
+		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFR_REG,
+				     SC16IS7XX_EFR_ENABLE_BIT);
+
+		regcache_cache_bypass(s->regmap, false);
+
+		/* Restore access to general registers */
+		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
+
 		/* Go to suspend mode */
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
-- 
2.7.4
