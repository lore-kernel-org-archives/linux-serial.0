From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: SERIAL_STM32 should depend on HAS_DMA
Date: Thu,  6 Oct 2016 15:55:24 +0200
Message-ID: <1475762124-16609-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If NO_DMA=y:

    drivers/built-in.o: In function `stm32_serial_remove':
    stm32-usart.c:(.text+0xcea1a): undefined reference to `bad_dma_ops'
    stm32-usart.c:(.text+0xcea7a): undefined reference to `bad_dma_ops'

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index c7831407a882d2bb..25c1d7bc010043b1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1625,6 +1625,7 @@ config SERIAL_SPRD_CONSOLE
 config SERIAL_STM32
 	tristate "STMicroelectronics STM32 serial port support"
 	select SERIAL_CORE
+	depends on HAS_DMA
 	depends on ARM || COMPILE_TEST
 	help
 	  This driver is for the on-chip Serial Controller on
-- 
1.9.1
