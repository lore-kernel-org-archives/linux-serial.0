From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/4] serial: bfin_5xx: always include DMA headers
Date: Wed, 27 Oct 2010 04:16:47 -0400
Message-ID: <1288167410-31554-2-git-send-email-vapier@gentoo.org>
References: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53080 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290Ab0J0IQn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 04:16:43 -0400
In-Reply-To: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

On Blackfin systems, peripherals that have optional DMA support always
route their interrupts through the corresponding DMA channel -- even
when DMA is not being used.  So in PIO mode, we still need to request
the DMA channel (so interrupts are delivered) which means we need to
always include the DMA header for the DMA defines/functions.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index a9eff2b..9ea8265 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -23,6 +23,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
+#include <linux/dma-mapping.h>
 
 #if defined(CONFIG_KGDB_SERIAL_CONSOLE) || \
 	defined(CONFIG_KGDB_SERIAL_CONSOLE_MODULE)
@@ -33,12 +34,10 @@
 #include <asm/gpio.h>
 #include <mach/bfin_serial_5xx.h>
 
-#ifdef CONFIG_SERIAL_BFIN_DMA
-#include <linux/dma-mapping.h>
+#include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
-#endif
 
 #ifdef CONFIG_SERIAL_BFIN_MODULE
 # undef CONFIG_EARLY_PRINTK
@@ -688,6 +687,13 @@ static int bfin_serial_startup(struct uart_port *port)
 
 # ifdef CONFIG_BF54x
 	{
+		/*
+		 * UART2 and UART3 on BF548 share interrupt PINs and DMA
+		 * controllers with SPORT2 and SPORT3. UART rx and tx
+		 * interrupts are generated in PIO mode only when configure
+		 * their peripheral mapping registers properly, which means
+		 * request corresponding DMA channels in PIO mode as well.
+		 */
 		unsigned uart_dma_ch_rx, uart_dma_ch_tx;
 
 		switch (uart->port.irq) {
-- 
1.7.3.2

