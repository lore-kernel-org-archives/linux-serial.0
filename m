From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/5] tty: serial: bcm63xx_uart: use linux/serial_bcm63xx.h
Date: Thu, 5 Dec 2013 18:26:07 -0800
Message-ID: <1386296768-20204-5-git-send-email-florian@openwrt.org>
References: <1386296768-20204-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1386296768-20204-1-git-send-email-florian@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org, mbizon@freebox.fr, cernekee@gmail.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, Florian Fainelli <florian@openwrt.org>
List-Id: linux-serial@vger.kernel.org

Now that the UART block defines have been moved to a separate file,
include that one and do not longer rely on the MIPS-specific
bcm63xx_regs.h header file.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/tty/serial/bcm63xx_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 6d773a3..78e82b0 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -29,8 +29,7 @@
 #include <linux/sysrq.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
-
-#include <bcm63xx_regs.h>
+#include <linux/serial_bcm63xx.h>
 
 #define BCM63XX_NR_UARTS	2
 
-- 
1.8.3.2
