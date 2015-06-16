From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH] serial: stm32-usart: Fix SysRq support
Date: Tue, 16 Jun 2015 11:12:19 +0200
Message-ID: <1434445939-8102-1-git-send-email-mcoquelin.stm32@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, andreas.ruprecht@fau.de
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

SysRq support activation depends on CONFIG_SERIAL_STM32_USART_CONSOLE, but
this config flag does not exists.

This patch fix this by depending on the valid config flag, which is
SERIAL_STM32_CONSOLE.

Reported-by: Andreas Ruprecht <andreas.ruprecht@fau.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4a6eab6..e3de9c6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -6,7 +6,7 @@
  * Inspired by st-asc.c from STMicroelectronics (c)
  */
 
-#if defined(CONFIG_SERIAL_STM32_USART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if defined(CONFIG_SERIAL_STM32_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
 
-- 
1.9.1
