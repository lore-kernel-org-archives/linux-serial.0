From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] serial: SERIAL_ATMEL should depend on HAS_DMA
Date: Mon,  9 Nov 2015 10:31:14 +0100
Message-ID: <1447061476-19518-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If NO_DMA=y:

    drivers/built-in.o: In function `atmel_release_rx_dma':
    atmel_serial.c:(.text+0x2502e): undefined reference to `dma_unmap_sg'
    drivers/built-in.o: In function `atmel_release_tx_dma':
    atmel_serial.c:(.text+0x25080): undefined reference to `dma_unmap_sg'
    drivers/built-in.o: In function `atmel_tx_dma':
    atmel_serial.c:(.text+0x2517a): undefined reference to `dma_sync_sg_for_cpu'
    drivers/built-in.o: In function `atmel_release_tx_pdc':
    atmel_serial.c:(.text+0x252e6): undefined reference to `dma_unmap_single'
    drivers/built-in.o: In function `atmel_prepare_tx_pdc':
    atmel_serial.c:(.text+0x2531a): undefined reference to `dma_map_single'
    drivers/built-in.o: In function `atmel_release_rx_pdc':
    atmel_serial.c:(.text+0x25362): undefined reference to `dma_unmap_single'
    drivers/built-in.o: In function `atmel_tx_pdc':
    atmel_serial.c:(.text+0x25722): undefined reference to `dma_sync_single_for_cpu'
    drivers/built-in.o: In function `atmel_rx_from_pdc':
    atmel_serial.c:(.text+0x2601a): undefined reference to `dma_sync_single_for_cpu'
    drivers/built-in.o: In function `atmel_rx_from_dma':
    atmel_serial.c:(.text+0x261b2): undefined reference to `dma_sync_sg_for_cpu'
    atmel_serial.c:(.text+0x26264): undefined reference to `dma_sync_sg_for_cpu'
    drivers/built-in.o: In function `atmel_prepare_rx_pdc':
    atmel_serial.c:(.text+0x262de): undefined reference to `dma_unmap_single'
    atmel_serial.c:(.text+0x26308): undefined reference to `dma_map_single'

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1aec4404062d8f19..a6f64fdb023854ad 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -115,6 +115,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 / AT32 on-chip serial port support"
+	depends on HAS_DMA
 	depends on ARCH_AT91 || AVR32 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
-- 
1.9.1
