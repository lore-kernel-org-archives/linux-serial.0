From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] serial: SERIAL_IMX_AUART should depend on HAS_DMA
Date: Mon,  9 Nov 2015 10:31:15 +0100
Message-ID: <1447061476-19518-2-git-send-email-geert@linux-m68k.org>
References: <1447061476-19518-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447061476-19518-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If NO_DMA=y:

    ERROR: "dma_unmap_sg" [drivers/tty/serial/imx.ko] undefined!
    ERROR: "dma_map_sg" [drivers/tty/serial/imx.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a6f64fdb023854ad..67b6d8d47d776b7b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -572,6 +572,7 @@ config BFIN_UART3_CTSRTS
 
 config SERIAL_IMX
 	tristate "IMX serial port support"
+	depends on HAS_DMA
 	depends on ARCH_MXC || COMPILE_TEST
 	select SERIAL_CORE
 	select RATIONAL
-- 
1.9.1
