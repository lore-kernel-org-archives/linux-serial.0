From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] serial: SERIAL_IFX6X60 should depend on HAS_DMA
Date: Thu, 23 Apr 2015 16:15:41 +0200
Message-ID: <1429798541-32252-3-git-send-email-geert@linux-m68k.org>
References: <1429798541-32252-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429798541-32252-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If NO_DMA=y:

    drivers/built-in.o: In function `ifx_spi_free_device':
    ifx6x60.c:(.text+0x96d9a): undefined reference to `dma_free_coherent'
    drivers/built-in.o: In function `ifx_spi_spi_probe':
    ifx6x60.c:(.text+0x978a2): undefined reference to `dma_alloc_coherent'

While DMA is optional in this driver, and is used only if
ifx_modem_platform_data.use_dma is set, there are currently no in-tree
users of ifx_modem_platform_data (and thus of this driver), so just make
it depend on HAS_DMA.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1bde14760f..daee183386368149 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1349,7 +1349,7 @@ config SERIAL_ALTERA_UART_CONSOLE
 
 config SERIAL_IFX6X60
         tristate "SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)"
-	depends on GPIOLIB && SPI
+	depends on GPIOLIB && SPI && HAS_DMA
 	help
 	  Support for the IFX6x60 modem devices on Intel MID platforms.
 
-- 
1.9.1
