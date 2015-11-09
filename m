From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] serial: SERIAL_MXS_AUART should depend on HAS_DMA
Date: Mon,  9 Nov 2015 10:31:16 +0100
Message-ID: <1447061476-19518-3-git-send-email-geert@linux-m68k.org>
References: <1447061476-19518-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447061476-19518-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If NO_DMA=y:

    ERROR: "dma_unmap_sg" [drivers/tty/serial/mxs-auart.ko] undefined!
    ERROR: "dma_map_sg" [drivers/tty/serial/mxs-auart.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 67b6d8d47d776b7b..29040e88bd6898a3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1411,8 +1411,9 @@ config SERIAL_PCH_UART_CONSOLE
 	  warnings and which allows logins in single user mode).
 
 config SERIAL_MXS_AUART
-	depends on ARCH_MXS || COMPILE_TEST
 	tristate "MXS AUART support"
+	depends on HAS_DMA
+	depends on ARCH_MXS || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
-- 
1.9.1
