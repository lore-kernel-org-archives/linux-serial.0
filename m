From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 11/13] serial: lpc32xx: allow compile testing
Date: Fri,  9 Aug 2019 16:40:37 +0200
Message-ID: <20190809144043.476786-12-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>, linux-serial@vger.kernel.org, Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The lpc32xx_loopback_set() function in hte lpc32xx_hs driver is the
one thing that relies on platform header files. Move that into the
core platform code so we only need a variable declaration for it,
and enable COMPILE_TEST building.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-lpc32xx/serial.c       | 30 ++++++++++++++++++++++++
 drivers/tty/serial/lpc32xx_hs.c      | 35 ++++------------------------
 include/linux/soc/nxp/lpc32xx-misc.h |  4 ++++
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index 3f9b30df9f0e..cfb35e5691cd 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -60,6 +60,36 @@ static struct uartinit uartinit_data[] __initdata = {
 	},
 };
 
+/* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
+void lpc32xx_loopback_set(resource_size_t mapbase, int state)
+{
+	int bit;
+	u32 tmp;
+
+	switch (mapbase) {
+	case LPC32XX_HS_UART1_BASE:
+		bit = 0;
+		break;
+	case LPC32XX_HS_UART2_BASE:
+		bit = 1;
+		break;
+	case LPC32XX_HS_UART7_BASE:
+		bit = 6;
+		break;
+	default:
+		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
+		return;
+	}
+
+	tmp = readl(LPC32XX_UARTCTL_CLOOP);
+	if (state)
+		tmp |= (1 << bit);
+	else
+		tmp &= ~(1 << bit);
+	writel(tmp, LPC32XX_UARTCTL_CLOOP);
+}
+EXPORT_SYMBOL_GPL(lpc32xx_loopback_set);
+
 void __init lpc32xx_serial_init(void)
 {
 	u32 tmp, clkmodes = 0;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 7f14cd8fac47..d3843f722182 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -25,6 +25,8 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/sizes.h>
+#include <linux/soc/nxp/lpc32xx-misc.h>
 
 /*
  * High Speed UART register offsets
@@ -79,6 +81,8 @@
 #define LPC32XX_HSU_TX_TL8B			(0x2 << 0)
 #define LPC32XX_HSU_TX_TL16B			(0x3 << 0)
 
+#define LPC32XX_MAIN_OSC_FREQ			13000000
+
 #define MODNAME "lpc32xx_hsuart"
 
 struct lpc32xx_hsuart_port {
@@ -149,8 +153,6 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static void lpc32xx_loopback_set(resource_size_t mapbase, int state);
-
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
 					       char *options)
 {
@@ -437,35 +439,6 @@ static void serial_lpc32xx_break_ctl(struct uart_port *port,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-/* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
-static void lpc32xx_loopback_set(resource_size_t mapbase, int state)
-{
-	int bit;
-	u32 tmp;
-
-	switch (mapbase) {
-	case LPC32XX_HS_UART1_BASE:
-		bit = 0;
-		break;
-	case LPC32XX_HS_UART2_BASE:
-		bit = 1;
-		break;
-	case LPC32XX_HS_UART7_BASE:
-		bit = 6;
-		break;
-	default:
-		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
-		return;
-	}
-
-	tmp = readl(LPC32XX_UARTCTL_CLOOP);
-	if (state)
-		tmp |= (1 << bit);
-	else
-		tmp &= ~(1 << bit);
-	writel(tmp, LPC32XX_UARTCTL_CLOOP);
-}
-
 /* port->lock is not held.  */
 static int serial_lpc32xx_startup(struct uart_port *port)
 {
diff --git a/include/linux/soc/nxp/lpc32xx-misc.h b/include/linux/soc/nxp/lpc32xx-misc.h
index af4f82f6cf3b..699c6f1e3aab 100644
--- a/include/linux/soc/nxp/lpc32xx-misc.h
+++ b/include/linux/soc/nxp/lpc32xx-misc.h
@@ -14,6 +14,7 @@
 #ifdef CONFIG_ARCH_LPC32XX
 extern u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr);
 extern void lpc32xx_set_phy_interface_mode(phy_interface_t mode);
+extern void lpc32xx_loopback_set(resource_size_t mapbase, int state);
 #else
 static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
 {
@@ -24,6 +25,9 @@ static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaadd
 static inline void lpc32xx_set_phy_interface_mode(phy_interface_t mode)
 {
 }
+static inline void lpc32xx_loopback_set(resource_size_t mapbase, int state)
+{
+}
 #endif
 
 #endif  /* __SOC_LPC32XX_MISC_H */
-- 
2.20.0
