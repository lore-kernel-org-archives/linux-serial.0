From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC 5/8] serial: amba-pl011: Pass on FIQ information to KGDB.
Date: Wed, 14 May 2014 16:58:42 +0100
Message-ID: <1400083125-1464-6-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, Frederic Weisbecker <fweisbec@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-serial@vger.kernel.org

It is important this information comes from the serial driver because, by
doing so, the driver offers "permission" for KGDB to route its interrupt
signal from the drivers own handler to KGDBs FIQ handler (which will
handle the interrupt signal by making polled I/O callbacks).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index dacf0a0..aac817a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -58,6 +58,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
+#include <linux/kgdb.h>
 
 #define UART_NR			14
 
@@ -2091,6 +2092,18 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
 	return ret;
 }
 
+#ifdef CONFIG_KGDB_FIQ
+/* Register with KGDB if there is a FIQ linked to this device */
+static void pl011_register_fiq(struct amba_device *dev)
+{
+	int fiq = dev->irq[1];
+	if (fiq > 0)
+		kgdb_register_fiq(fiq);
+}
+#else
+static void pl011_register_fiq(struct platform_device *pdev) {}
+#endif
+
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
@@ -2164,11 +2177,14 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	ret = uart_add_one_port(&amba_reg, &uap->port);
-	if (ret) {
+	if (0 == ret) {
+		pl011_register_fiq(dev);
+	} else {
 		amba_ports[i] = NULL;
 		uart_unregister_driver(&amba_reg);
 		pl011_dma_remove(uap);
 	}
+
  out:
 	return ret;
 }
-- 
1.9.0
