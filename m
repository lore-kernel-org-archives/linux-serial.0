From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
Date: Wed,  6 Jun 2018 18:47:04 +0000
Message-ID: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-serial@vger.kernel.org

This patch fix the following build error on M68K:
drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'

So 8250_dw need to depend on COMMON_CLK.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f005eaf8bc57..37d4ec5f3cc9 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -351,7 +351,7 @@ config SERIAL_8250_FSL
 
 config SERIAL_8250_DW
 	tristate "Support for Synopsys DesignWare 8250 quirks"
-	depends on SERIAL_8250
+	depends on SERIAL_8250 && COMMON_CLK
 	help
 	  Selecting this option will enable handling of the extra features
 	  present in the Synopsys DesignWare APB UART.
-- 
2.16.4
