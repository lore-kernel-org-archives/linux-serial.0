Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F05BC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Dec 2021 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhLPR6F (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:58:05 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:54179 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhLPR6D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Dec 2021 12:58:03 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 12:58:02 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id EF87810193E7B;
        Thu, 16 Dec 2021 18:52:17 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C501F606FAEC;
        Thu, 16 Dec 2021 18:52:17 +0100 (CET)
X-Mailbox-Line: From af967f273724aff4cff3c49470110a48f790794e Mon Sep 17 00:00:00 2001
Message-Id: <af967f273724aff4cff3c49470110a48f790794e.1639676574.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Dec 2021 18:52:00 +0100
Subject: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

struct uart_8250_port contains mcr_mask and mcr_force members whose
sole purpose is to work around an alpha-specific quirk.  This code
doesn't belong in the core where it is executed by everyone else,
so move it to a proper ->set_mctrl callback which is used on alpha only.

The alpha-specific quirk was introduced in January 1995:
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/drivers/char/serial.c?h=1.1.83

The members in struct uart_8250_port were added in 2002:
https://git.kernel.org/history/history/c/4524aad27854

The quirk applies to non-PCI alphas and arch/alpha/Kconfig specifies
"select FORCE_PCI if !ALPHA_JENSEN".  So apparently the only affected
machine is the EISA-based Jensen that Linus was working on back then:
https://lore.kernel.org/all/CAHk-=wj1JWZ3sCrGz16nxEj7=0O+srMg6Ah3iPTDXSPKEws_SA@mail.gmail.com/

Up until now the quirk is not applied unless CONFIG_PCI is disabled.
If users forget to do that, the serial ports aren't usable on Jensen
and the machine may not boot in the first place.  Avoid by confining
the quirk to CONFIG_ALPHA_JENSEN instead.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Compile-tested only.

 drivers/tty/serial/8250/8250.h       | 11 +----------
 drivers/tty/serial/8250/8250_alpha.c | 15 +++++++++++++++
 drivers/tty/serial/8250/8250_core.c  |  8 +++-----
 drivers/tty/serial/8250/8250_port.c  |  2 +-
 drivers/tty/serial/8250/Makefile     |  1 +
 include/linux/serial_8250.h          |  2 --
 6 files changed, 21 insertions(+), 18 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_alpha.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 6473361525d1..ec5f9f4da6d3 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -241,16 +241,7 @@ static inline int serial8250_in_MCR(struct uart_8250_port *up)
 	return mctrl;
 }
 
-#if defined(__alpha__) && !defined(CONFIG_PCI)
-/*
- * Digital did something really horribly wrong with the OUT1 and OUT2
- * lines on at least some ALPHA's.  The failure mode is that if either
- * is cleared, the machine locks up with endless interrupts.
- */
-#define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
-#else
-#define ALPHA_KLUDGE_MCR 0
-#endif
+void alpha_8250_set_mctrl(struct uart_port *port, unsigned int mctrl);
 
 #ifdef CONFIG_SERIAL_8250_PNP
 int serial8250_pnp_init(void);
diff --git a/drivers/tty/serial/8250/8250_alpha.c b/drivers/tty/serial/8250/8250_alpha.c
new file mode 100644
index 000000000000..c87a5a6e0ee1
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_alpha.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/serial_8250.h>
+
+void alpha_8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/*
+	 * Digital did something really horribly wrong with the OUT1 and OUT2
+	 * lines on Alpha Jensen.  The failure mode is that if either is
+	 * cleared, the machine locks up with endless interrupts.
+	 */
+	mctrl |= TIOCM_OUT1 | TIOCM_OUT2;
+
+	serial8250_do_set_mctrl(port, mctrl);
+}
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 1ce193daea7f..92f92ac7c2be 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -509,11 +509,9 @@ static void __init serial8250_isa_init_ports(void)
 
 		up->ops = &univ8250_driver_ops;
 
-		/*
-		 * ALPHA_KLUDGE_MCR needs to be killed.
-		 */
-		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
-		up->mcr_force = ALPHA_KLUDGE_MCR;
+		if (IS_ENABLED(CONFIG_ALPHA_JENSEN))
+			port->set_mctrl = alpha_8250_set_mctrl;
+
 		serial8250_set_defaults(up);
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5d9a0e9f75d4..3b12bfc1ed67 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2026,7 +2026,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	mcr = serial8250_TIOCM_to_MCR(mctrl);
 
-	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
+	mcr |= up->mcr;
 
 	serial8250_out_MCR(up, mcr);
 }
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index b9bcd73c8997..043beae6f71b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-y					:= 8250_core.o
+8250-$(CONFIG_ALPHA_JENSEN)		+= 8250_alpha.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 5db211f43b29..ff84a3ed10ea 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -104,8 +104,6 @@ struct uart_8250_port {
 	unsigned char		ier;
 	unsigned char		lcr;
 	unsigned char		mcr;
-	unsigned char		mcr_mask;	/* mask of user bits */
-	unsigned char		mcr_force;	/* mask of forced bits */
 	unsigned char		cur_iotype;	/* Running I/O type */
 	unsigned int		rpm_tx_active;
 	unsigned char		canary;		/* non-zero during system sleep
-- 
2.33.0

