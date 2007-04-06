From: Mikhail Zolotaryov <lebon@faust.net.ua>
Subject: [PATCH] PPC4xx UART0 (8250) problem
Date: Fri, 06 Apr 2007 18:11:37 +0300
Message-ID: <46166329.3060508@faust.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-U
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.faust.net.ua ([195.68.202.98]:38580 "EHLO
	mail.faust.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767735AbXDFPUE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Apr 2007 11:20:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: mporter@kernel.crashing.org, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On PPC4xx embedded we often have UART0 on IRQ0 but 8250 UART driver uses
IRQ0 as "no irq" hack.
It's suggested that platforms with UART on IRQ0 will redefine
is_real_interrupt(irq) macro but 8250 code anyway overrides that.
As the result, serial line on UART0 works on polling-way and we have
character loss on high baud rates.

In patch I've added check if UART0 is on IRQ0, if so we define
is_real_interrupt macro to be 1 (true).
Also, check if is_real_interrupt macro is already defined added to 8250
UART driver.

--- linux-2.6.20.5.orig/include/asm-ppc/ibm4xx.h        2007-03-23
21:52:51.000000000 +0200
+++ linux-2.6.20.5/include/asm-ppc/ibm4xx.h     2007-04-06
17:37:22.000000000 +0300
@@ -54,6 +54,12 @@
 #include <platforms/4xx/xilinx_ml403.h>
 #endif
 
+#ifdef UART0_INT
+#if (UART0_INT == 0)
+#define is_real_interrupt(irq)  (1)
+#endif
+#endif
+
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_40x
--- linux-2.6.20.5.orig/drivers/serial/8250.c   2007-03-23
21:52:51.000000000 +0200
+++ linux-2.6.20.5/drivers/serial/8250.c        2007-04-06
16:44:32.000000000 +0300
@@ -77,7 +77,10 @@
  * machine types want others as well - they're free
  * to redefine this in their header file.
  */
+
+#ifndef is_real_interrupt(irq)
 #define is_real_interrupt(irq) ((irq) != 0)
+#endif
 
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define CONFIG_SERIAL_DETECT_IRQ 1

