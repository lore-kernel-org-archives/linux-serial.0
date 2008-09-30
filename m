From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 6/6] serial: convert drivers to use uart_flow_output_allowed()
Date: Tue, 30 Sep 2008 14:42:01 -0400
Message-ID: <20080930184157.796569534@ruivo.org>
References: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54580 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbYI3Sml (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:41 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id 97FF3526F7
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:56 -0400 (EDT)
Content-Disposition: inline; filename=serial-generalize_wait_for_xmitr.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch modifies serial drivers to use uart_flow_output_allowed() making
the flow control decision to serial_core.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 drivers/serial/8250.c        |   18 +++++++-----------
 drivers/serial/pxa.c         |   12 ++++++------
 drivers/serial/samsung.c     |    6 +++---
 drivers/serial/serial_txx9.c |   12 ++++++------
 drivers/serial/sunsu.c       |   12 ++++++------
 drivers/serial/vr41xx_siu.c  |   15 ++++++---------
 6 files changed, 34 insertions(+), 41 deletions(-)

--- linux-next.orig/drivers/serial/8250.c	2008-09-24 13:30:30.000000000 -0400
+++ linux-next/drivers/serial/8250.c	2008-09-24 13:30:54.000000000 -0400
@@ -1779,17 +1779,13 @@ static void wait_for_xmitr(struct uart_8
 	} while ((status & bits) != bits);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
-		unsigned int tmout;
-		for (tmout = 1000000; tmout; tmout--) {
-			unsigned int msr = serial_in(up, UART_MSR);
-			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
-			if (msr & UART_MSR_CTS)
-				break;
-			udelay(1);
-			touch_nmi_watchdog();
-		}
-	}
+	tmout = 1000000;
+	do {
+		if (uart_flow_output_allowed(&up->port))
+			break;
+		udelay(1);
+		touch_nmi_watchdog();
+	} while(tmout--);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
--- linux-next.orig/drivers/serial/pxa.c	2008-09-24 13:30:30.000000000 -0400
+++ linux-next/drivers/serial/pxa.c	2008-09-24 13:30:54.000000000 -0400
@@ -617,12 +617,12 @@ static inline void wait_for_xmitr(struct
 	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
-		tmout = 1000000;
-		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
-			udelay(1);
-	}
+	tmout = 1000000;
+	do {
+		if (uart_flow_output_allowed(&up->port))
+			break;
+		udelay(1);
+	} while(tmout--);
 }
 
 static void serial_pxa_console_putchar(struct uart_port *port, int ch)
--- linux-next.orig/drivers/serial/serial_txx9.c	2008-09-24 13:30:30.000000000 -0400
+++ linux-next/drivers/serial/serial_txx9.c	2008-09-24 13:30:54.000000000 -0400
@@ -475,12 +475,12 @@ static void wait_for_xmitr(struct uart_t
 		udelay(1);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
-		tmout = 1000000;
-		while (--tmout &&
-		       (sio_in(up, TXX9_SICISR) & TXX9_SICISR_CTSS))
-			udelay(1);
-	}
+	tmout = 1000000;
+	do {
+		if (uart_flow_output_allowed(&up->port))
+			break;
+		udelay(1);
+	} while(tmout--);
 }
 #endif
 
--- linux-next.orig/drivers/serial/sunsu.c	2008-09-24 13:30:30.000000000 -0400
+++ linux-next/drivers/serial/sunsu.c	2008-09-24 13:30:54.000000000 -0400
@@ -1265,12 +1265,12 @@ static __inline__ void wait_for_xmitr(st
 	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
-		tmout = 1000000;
-		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
-			udelay(1);
-	}
+	tmout = 1000000;
+	do {
+		if (uart_flow_output_allowed(&up->port))
+			break;
+		udelay(1);
+	} while(tmout--);
 }
 
 static void sunsu_console_putchar(struct uart_port *port, int ch)
--- linux-next.orig/drivers/serial/vr41xx_siu.c	2008-09-24 13:30:30.000000000 -0400
+++ linux-next/drivers/serial/vr41xx_siu.c	2008-09-24 13:30:54.000000000 -0400
@@ -751,15 +751,12 @@ static void wait_for_xmitr(struct uart_p
 			break;
 	} while (timeout-- > 0);
 
-	if (port->flags & UPF_CONS_FLOW) {
-		timeout = 1000000;
-
-		do {
-			msr = siu_read(port, UART_MSR);
-			if ((msr & UART_MSR_CTS) != 0)
-				break;
-		} while (timeout-- > 0);
-	}
+	timeout = 1000000;
+	do {
+		if (uart_flow_output_allowed(port))
+			break;
+		udelay(1);
+	} while(timeout--);
 }
 
 static void siu_console_putchar(struct uart_port *port, int ch)
--- linux-next.orig/drivers/serial/samsung.c	2008-09-24 13:30:30.000000000 -0400
+++ linux-next/drivers/serial/samsung.c	2008-09-24 13:30:54.000000000 -0400
@@ -139,7 +139,7 @@ static void s3c24xx_serial_stop_tx(struc
 	if (tx_enabled(port)) {
 		disable_irq(TX_IRQ(port));
 		tx_enabled(port) = 0;
-		if (port->flags & UPF_CONS_FLOW)
+		if (uart_has_hw_flow_control(port))
 			s3c24xx_serial_rx_enable(port);
 	}
 }
@@ -147,7 +147,7 @@ static void s3c24xx_serial_stop_tx(struc
 static void s3c24xx_serial_start_tx(struct uart_port *port)
 {
 	if (!tx_enabled(port)) {
-		if (port->flags & UPF_CONS_FLOW)
+		if (uart_has_hw_flow_control(port))
 			s3c24xx_serial_rx_disable(port);
 
 		enable_irq(TX_IRQ(port));
@@ -216,7 +216,7 @@ s3c24xx_serial_rx_chars(int irq, void *d
 		uerstat = rd_regl(port, S3C2410_UERSTAT);
 		ch = rd_regb(port, S3C2410_URXH);
 
-		if (port->flags & UPF_CONS_FLOW) {
+		if (uart_has_hw_flow_control(port)) {
 			int txe = s3c24xx_serial_txempty_nofifo(port);
 
 			if (rx_enabled(port)) {

-- 
Aristeu

