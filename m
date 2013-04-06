From: Jonas Gorski <jogo@openwrt.org>
Subject: [PATCH] MIPS: BCM63XX: merge bcm63xx_clk.h into bcm63xx/clk.c
Date: Sat,  6 Apr 2013 13:31:02 +0200
Message-ID: <1365247862-19358-1-git-send-email-jogo@openwrt.org>
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
To: linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, John Crispin <blogic@openwrt.org>, Maxime Bizon <mbizon@freebox.fr>, Florian Fainelli <florian@openwrt.org>, Kevin Cernekee <cernekee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

All the header file does is provide the internal structure of clk,
which shouldn't be used by anyone except clk.c itself anyway.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/clk.c                          |    8 +++++++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h |   11 -----------
 drivers/tty/serial/bcm63xx_uart.c                |    1 -
 3 files changed, 7 insertions(+), 13 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index e357d55..6601214 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -15,7 +15,13 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_reset.h>
-#include <bcm63xx_clk.h>
+
+struct clk {
+	void		(*set)(struct clk *, int);
+	unsigned int	rate;
+	unsigned int	usage;
+	int		id;
+};
 
 static DEFINE_MUTEX(clocks_mutex);
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h
deleted file mode 100644
index 8fcf8df..0000000
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef BCM63XX_CLK_H_
-#define BCM63XX_CLK_H_
-
-struct clk {
-	void		(*set)(struct clk *, int);
-	unsigned int	rate;
-	unsigned int	usage;
-	int		id;
-};
-
-#endif /* ! BCM63XX_CLK_H_ */
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 52a3ecd..6fa2ae7 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -30,7 +30,6 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
-#include <bcm63xx_clk.h>
 #include <bcm63xx_irq.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
-- 
1.7.10.4
