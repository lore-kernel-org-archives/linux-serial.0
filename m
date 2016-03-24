From: Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH] MIPS: ath79: make bootconsole wait for both THRE and TEMT
Date: Thu, 24 Mar 2016 16:02:52 +0100
Message-ID: <f1ba020af5076172c9d29006a747ccf40027fedc.1458831772.git.mschiffer@universe-factory.net>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This makes the ath79 bootconsole behave the same way as the generic 8250
bootconsole.

Also waiting for TEMT (transmit buffer is empty) instead of just THRE
(transmit buffer is not full) ensures that all characters have been
transmitted before the real serial driver starts reconfiguring the serial
controller (which would sometimes result in garbage being transmitted.)
This change does not cause a visible performance loss.

In addition, this seems to fix a hang observed in certain configurations on
many AR7xxx/AR9xxx SoCs during autoconfig of the real serial driver.

A more complete follow-up patch will disable 8250 autoconfig for ath79
altogether (the serial controller is detected as a 16550A, which is not
fully compatible with the ath79 serial, and the autoconfig may lead to
undefined behavior on ath79.)

Cc: <stable@vger.kernel.org>
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 arch/mips/ath79/early_printk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index b955faf..d1adc59 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -31,13 +31,15 @@ static inline void prom_putchar_wait(void __iomem *reg, u32 mask, u32 val)
 	} while (1);
 }
 
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
 static void prom_putchar_ar71xx(unsigned char ch)
 {
 	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
 
-	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_THRE, UART_LSR_THRE);
+	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
 	__raw_writel(ch, base + UART_TX * 4);
-	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_THRE, UART_LSR_THRE);
+	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
 }
 
 static void prom_putchar_ar933x(unsigned char ch)
-- 
2.7.4
