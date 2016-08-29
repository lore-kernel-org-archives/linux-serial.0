From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 6/6] ARM: sa1100/neponset: convert serial to use gpiod APIs
Date: Mon, 29 Aug 2016 13:06:17 +0100
Message-ID: <E1beLKT-0001U1-HK@rmk-PC.armlinux.org.uk>
References: <20160829120531.GG1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160829120531.GG1041@n2100.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Convert the serial modem control signals to use the gpiod APIs rather
than the private platform callbacks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c | 109 +++++++++++-----------------------------
 1 file changed, 28 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 790d8da233da..bff6efdfaeaf 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -10,7 +10,6 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/serial_core.h>
@@ -48,23 +47,8 @@
 #define IRR_SA1111	(1 << 2)
 
 #define NCR_NGPIO	7
-
-#define MDM_CTL0_RTS1	(1 << 0)
-#define MDM_CTL0_DTR1	(1 << 1)
-#define MDM_CTL0_RTS2	(1 << 2)
-#define MDM_CTL0_DTR2	(1 << 3)
 #define MDM_CTL0_NGPIO	4
-
-#define MDM_CTL1_CTS1	(1 << 0)
-#define MDM_CTL1_DSR1	(1 << 1)
-#define MDM_CTL1_DCD1	(1 << 2)
-#define MDM_CTL1_CTS2	(1 << 3)
-#define MDM_CTL1_DSR2	(1 << 4)
-#define MDM_CTL1_DCD2	(1 << 5)
 #define MDM_CTL1_NGPIO	6
-
-#define AUD_SEL_1341	(1 << 0)
-#define AUD_MUTE_1341	(1 << 1)
 #define AUD_NGPIO	2
 
 extern void sa1110_mb_disable(void);
@@ -96,6 +80,30 @@ struct neponset_drvdata {
 	struct gpio_chip *gpio[4];
 };
 
+static struct gpiod_lookup_table neponset_uart1_gpio_table = {
+	.dev_id = "sa11x0-uart.1",
+	.table = {
+		GPIO_LOOKUP("neponset-mdm-ctl0", 2, "rts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl0", 3, "dtr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl1", 3, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl1", 4, "dsr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl1", 5, "dcd", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table neponset_uart3_gpio_table = {
+	.dev_id = "sa11x0-uart.3",
+	.table = {
+		GPIO_LOOKUP("neponset-mdm-ctl0", 0, "rts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl0", 1, "dtr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl1", 0, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl1", 1, "dsr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("neponset-mdm-ctl1", 2, "dcd", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static struct gpiod_lookup_table neponset_pcmcia_table = {
 	.dev_id = "1800",
 	.table = {
@@ -123,69 +131,6 @@ void neponset_ncr_frob(unsigned int mask, unsigned int val)
 }
 EXPORT_SYMBOL(neponset_ncr_frob);
 
-static void neponset_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	struct neponset_drvdata *n = nep;
-	unsigned long mask, val = 0;
-
-	if (!n)
-		return;
-
-	if (port->mapbase == _Ser1UTCR0) {
-		mask = MDM_CTL0_RTS2 | MDM_CTL0_DTR2;
-
-		if (!(mctrl & TIOCM_RTS))
-			val |= MDM_CTL0_RTS2;
-
-		if (!(mctrl & TIOCM_DTR))
-			val |= MDM_CTL0_DTR2;
-	} else if (port->mapbase == _Ser3UTCR0) {
-		mask = MDM_CTL0_RTS1 | MDM_CTL0_DTR1;
-
-		if (!(mctrl & TIOCM_RTS))
-			val |= MDM_CTL0_RTS1;
-
-		if (!(mctrl & TIOCM_DTR))
-			val |= MDM_CTL0_DTR1;
-	}
-
-	n->gpio[1]->set_multiple(n->gpio[1], &mask, &val);
-}
-
-static u_int neponset_get_mctrl(struct uart_port *port)
-{
-	void __iomem *base = nep->base;
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-	u_int mdm_ctl1;
-
-	if (!base)
-		return ret;
-
-	mdm_ctl1 = readb_relaxed(base + MDM_CTL_1);
-	if (port->mapbase == _Ser1UTCR0) {
-		if (mdm_ctl1 & MDM_CTL1_DCD2)
-			ret &= ~TIOCM_CD;
-		if (mdm_ctl1 & MDM_CTL1_CTS2)
-			ret &= ~TIOCM_CTS;
-		if (mdm_ctl1 & MDM_CTL1_DSR2)
-			ret &= ~TIOCM_DSR;
-	} else if (port->mapbase == _Ser3UTCR0) {
-		if (mdm_ctl1 & MDM_CTL1_DCD1)
-			ret &= ~TIOCM_CD;
-		if (mdm_ctl1 & MDM_CTL1_CTS1)
-			ret &= ~TIOCM_CTS;
-		if (mdm_ctl1 & MDM_CTL1_DSR1)
-			ret &= ~TIOCM_DSR;
-	}
-
-	return ret;
-}
-
-static struct sa1100_port_fns neponset_port_fns = {
-	.set_mctrl	= neponset_set_mctrl,
-	.get_mctrl	= neponset_get_mctrl,
-};
-
 /*
  * Install handler for Neponset IRQ.  Note that we have to loop here
  * since the ETHERNET and USAR IRQs are level based, and we need to
@@ -384,6 +329,8 @@ static int neponset_probe(struct platform_device *dev)
 			   d->base + AUD_CTL, AUD_NGPIO, false,
 			   neponset_aud_names);
 
+	gpiod_add_lookup_table(&neponset_uart1_gpio_table);
+	gpiod_add_lookup_table(&neponset_uart3_gpio_table);
 	gpiod_add_lookup_table(&neponset_pcmcia_table);
 
 	/*
@@ -398,8 +345,6 @@ static int neponset_probe(struct platform_device *dev)
 		 d->irq_base, d->irq_base + NEP_IRQ_NR - 1);
 	nep = d;
 
-	sa1100_register_uart_fns(&neponset_port_fns);
-
 	/* Ensure that the memory bus request/grant signals are setup */
 	sa1110_mb_disable();
 
@@ -441,6 +386,8 @@ static int neponset_remove(struct platform_device *dev)
 		platform_device_unregister(d->smc91x);
 
 	gpiod_remove_lookup_table(&neponset_pcmcia_table);
+	gpiod_remove_lookup_table(&neponset_uart3_gpio_table);
+	gpiod_remove_lookup_table(&neponset_uart1_gpio_table);
 
 	irq_set_chained_handler(irq, NULL);
 	irq_free_descs(d->irq_base, NEP_IRQ_NR);
-- 
2.1.0
