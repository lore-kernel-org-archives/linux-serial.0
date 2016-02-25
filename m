From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: sa1100: make sa1100_register_uart_fns a function
Date: Thu, 25 Feb 2016 15:33:46 +0100
Message-ID: <1456410835-3808962-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Calling sa1100_register_uart_fns() leaves the port structure
unused when CONFIG_SERIAL_SA1100 is disabled, and we get a
compiler warning about that:

arch/arm/mach-sa1100/badge4.c:317:31: warning: 'badge4_port_fns' defined but not used [-Wunused-variable]
 static struct sa1100_port_fns badge4_port_fns __initdata = {

This turns the two empty macros into empty inline functions,
which has the same effect, but lets the compiler know that the
variables are intentionally unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/platform_data/sa11x0-serial.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/sa11x0-serial.h b/include/linux/platform_data/sa11x0-serial.h
index 4504d5d592f0..009e1d83fe39 100644
--- a/include/linux/platform_data/sa11x0-serial.h
+++ b/include/linux/platform_data/sa11x0-serial.h
@@ -26,8 +26,12 @@ struct sa1100_port_fns {
 void sa1100_register_uart_fns(struct sa1100_port_fns *fns);
 void sa1100_register_uart(int idx, int port);
 #else
-#define sa1100_register_uart_fns(fns) do { } while (0)
-#define sa1100_register_uart(idx,port) do { } while (0)
+static inline void sa1100_register_uart_fns(struct sa1100_port_fns *fns)
+{
+}
+static inline void sa1100_register_uart(int idx, int port)
+{
+}
 #endif
 
 #endif
-- 
2.7.0
