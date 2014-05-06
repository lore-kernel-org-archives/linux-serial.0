From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: SERIAL_FSL_LPUART should depend on HAS_DMA
Date: Tue,  6 May 2014 14:41:19 +0200
Message-ID: <1399380079-2471-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If NO_DMA=y:

drivers/built-in.o: In function `lpuart_dma_rx_free':
fsl_lpuart.c:(.text+0x7da28): undefined reference to `dma_unmap_single'
drivers/built-in.o: In function `lpuart_dma_tx_free':
fsl_lpuart.c:(.text+0x7da60): undefined reference to `dma_unmap_single'
drivers/built-in.o: In function `lpuart_dma_rx':
fsl_lpuart.c:(.text+0x7dab8): undefined reference to `dma_sync_single_for_cpu'
drivers/built-in.o: In function `lpuart_dma_tx':
fsl_lpuart.c:(.text+0x7db7e): undefined reference to `dma_sync_single_for_cpu'
drivers/built-in.o: In function `lpuart_copy_rx_to_tty':
fsl_lpuart.c:(.text+0x7dcd4): undefined reference to `dma_sync_single_for_cpu'
make[3]: *** [vmlinux] Error 1

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5d9b01aa54f4..84b83d50e859 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1479,6 +1479,7 @@ config SERIAL_RP2_NR_UARTS
 
 config SERIAL_FSL_LPUART
 	tristate "Freescale lpuart serial port support"
+	depends on HAS_DMA
 	select SERIAL_CORE
 	help
 	  Support for the on-chip lpuart on some Freescale SOCs.
-- 
1.7.9.5
