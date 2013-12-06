From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/5] MIPS: BCM63XX: use linux/serial_bcm63xx.h
Date: Thu, 5 Dec 2013 18:26:08 -0800
Message-ID: <1386296768-20204-6-git-send-email-florian@openwrt.org>
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

Update the early_printk code to include linux/serial_bcm63xx.h which
provides the definitions for the UART block registers. While at it,
remove the inclusion of serial_bcm63xx.h which was just there to allow
smooth transition.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/early_printk.c                  | 2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/early_printk.c b/arch/mips/bcm63xx/early_printk.c
index aa8f7f9..f92f1a2 100644
--- a/arch/mips/bcm63xx/early_printk.c
+++ b/arch/mips/bcm63xx/early_printk.c
@@ -8,7 +8,7 @@
 
 #include <linux/init.h>
 #include <bcm63xx_io.h>
-#include <bcm63xx_regs.h>
+#include <linux/serial_bcm63xx.h>
 
 static void wait_xfered(void)
 {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 96a2d2c..ab427f8 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -463,13 +463,6 @@
 #define WDT_SOFTRESET_REG		0xc
 
 /*************************************************************************
- * _REG relative to RSET_UARTx
- *************************************************************************/
-
-#include <linux/serial_bcm63xx.h>
-
-
-/*************************************************************************
  * _REG relative to RSET_GPIO
  *************************************************************************/
 
-- 
1.8.3.2
