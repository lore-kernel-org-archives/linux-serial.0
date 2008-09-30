From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 4/6] serial: introduce uart_handle_dsr_change()
Date: Tue, 30 Sep 2008 14:41:59 -0400
Message-ID: <20080930184157.272633055@ruivo.org>
References: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54570 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbYI3SmU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:20 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id 07BF0526E2
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:56 -0400 (EDT)
Content-Disposition: inline; filename=serial_core-prepare_for_dtr.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch introduces uart_handle_dsr_change() and change drivers to use it.
Currently the drivers will simply count the DSR changes but won't report
this to the serial_core. This is needed for using DSR for flow control.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 drivers/serial/8250.c          |    2 -
 drivers/serial/amba-pl010.c    |    2 -
 drivers/serial/amba-pl011.c    |    2 -
 drivers/serial/atmel_serial.c  |    2 -
 drivers/serial/dz.c            |    2 -
 drivers/serial/icom.c          |    7 ++---
 drivers/serial/imx.c           |    2 -
 drivers/serial/ip22zilog.c     |    4 +-
 drivers/serial/pmac_zilog.c    |    4 +-
 drivers/serial/pnx8xxx_uart.c  |    2 -
 drivers/serial/pxa.c           |    2 -
 drivers/serial/sa1100.c        |    2 -
 drivers/serial/sb1250-duart.c  |    2 -
 drivers/serial/serial_ks8695.c |    2 -
 drivers/serial/sunsab.c        |    2 -
 drivers/serial/sunsu.c         |    2 -
 drivers/serial/sunzilog.c      |    4 +-
 drivers/serial/vr41xx_siu.c    |    2 -
 drivers/serial/zs.c            |    5 ++-
 include/linux/serial_core.h    |   55 ++++++++++++++++++++++++++++-------------
 20 files changed, 65 insertions(+), 42 deletions(-)

--- linux-next.orig/include/linux/serial_core.h	2008-09-24 13:09:48.000000000 -0400
+++ linux-next/include/linux/serial_core.h	2008-09-24 13:23:19.000000000 -0400
@@ -510,6 +510,43 @@ uart_handle_dcd_change(struct uart_port 
 	}
 }
 
+static inline void
+uart_handle_flow_control_change(struct uart_port *port, unsigned int pin,
+				unsigned int status)
+{
+	struct uart_info *info = port->info;
+	struct tty_struct *tty = info->port.tty;
+
+	if (!(pin & port->flags))
+		return;
+
+	if (tty->hw_stopped) {
+		if (status) {
+			tty->hw_stopped = 0;
+			port->ops->start_tx(port);
+			uart_write_wakeup(port);
+		}
+	} else {
+		if (!status) {
+			tty->hw_stopped = 1;
+			port->ops->stop_tx(port);
+		}
+	}
+}
+
+/**
+ *	uart_handle_dsr_change - handle a change of data-set-ready state
+ *	@port: uart_port structure for the open port
+ *	@status: new clear to send status, nonzero if active
+ */
+static inline void
+uart_handle_dsr_change(struct uart_port *port, unsigned int status)
+{
+	port->icount.dsr++;
+
+	uart_handle_flow_control_change(port, UPF_FLOW_DSRXON, status);
+}
+
 /**
  *	uart_handle_cts_change - handle a change of clear-to-send state
  *	@port: uart_port structure for the open port
@@ -518,25 +555,9 @@ uart_handle_dcd_change(struct uart_port 
 static inline void
 uart_handle_cts_change(struct uart_port *port, unsigned int status)
 {
-	struct uart_info *info = port->info;
-	struct tty_struct *tty = info->port.tty;
-
 	port->icount.cts++;
 
-	if (info->flags & UIF_CTS_FLOW) {
-		if (tty->hw_stopped) {
-			if (status) {
-				tty->hw_stopped = 0;
-				port->ops->start_tx(port);
-				uart_write_wakeup(port);
-			}
-		} else {
-			if (!status) {
-				tty->hw_stopped = 1;
-				port->ops->stop_tx(port);
-			}
-		}
-	}
+	uart_handle_flow_control_change(port, UPF_FLOW_CTSXON, status);
 }
 
 #include <linux/tty_flip.h>
--- linux-next.orig/drivers/serial/8250.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/8250.c	2008-09-24 13:23:19.000000000 -0400
@@ -1413,7 +1413,7 @@ static unsigned int check_modem_status(s
 		if (status & UART_MSR_TERI)
 			up->port.icount.rng++;
 		if (status & UART_MSR_DDSR)
-			up->port.icount.dsr++;
+			uart_handle_dsr_change(&up->port, status & UART_MSR_DSR);
 		if (status & UART_MSR_DDCD)
 			uart_handle_dcd_change(&up->port, status & UART_MSR_DCD);
 		if (status & UART_MSR_DCTS)
--- linux-next.orig/drivers/serial/amba-pl010.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/amba-pl010.c	2008-09-24 13:23:19.000000000 -0400
@@ -220,7 +220,7 @@ static void pl010_modem_status(struct ua
 		uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
 
 	if (delta & UART01x_FR_DSR)
-		uap->port.icount.dsr++;
+		uart_handle_dsr_change(&uap->port, status & UART01x_FR_DSR);
 
 	if (delta & UART01x_FR_CTS)
 		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
--- linux-next.orig/drivers/serial/amba-pl011.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/amba-pl011.c	2008-09-24 13:23:19.000000000 -0400
@@ -204,7 +204,7 @@ static void pl011_modem_status(struct ua
 		uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
 
 	if (delta & UART01x_FR_DSR)
-		uap->port.icount.dsr++;
+		uart_handle_dsr_change(&uap->port, status & UART01x_FR_DSR);
 
 	if (delta & UART01x_FR_CTS)
 		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
--- linux-next.orig/drivers/serial/atmel_serial.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/atmel_serial.c	2008-09-24 13:23:19.000000000 -0400
@@ -769,7 +769,7 @@ static void atmel_tasklet_func(unsigned 
 		if (status_change & ATMEL_US_RI)
 			port->icount.rng++;
 		if (status_change & ATMEL_US_DSR)
-			port->icount.dsr++;
+			uart_handle_dsr_change(port, !(status & ATMEL_US_DSR));
 		if (status_change & ATMEL_US_DCD)
 			uart_handle_dcd_change(port, !(status & ATMEL_US_DCD));
 		if (status_change & ATMEL_US_CTS)
--- linux-next.orig/drivers/serial/dz.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/dz.c	2008-09-24 13:23:19.000000000 -0400
@@ -329,7 +329,7 @@ static inline void check_modem_status(st
 
 	/* it's easy, since DSR2 is the only bit in the register */
 	if (status)
-		dport->port.icount.dsr++;
+		uart_handle_dsr_change(dport->port, status);
 }
 
 /*
--- linux-next.orig/drivers/serial/icom.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/icom.c	2008-09-24 13:23:19.000000000 -0400
@@ -681,13 +681,14 @@ static inline void check_modem_status(st
 		if (delta_status & ICOM_RI)
 			icom_port->uart_port.icount.rng++;
 		if (delta_status & ICOM_DSR)
-			icom_port->uart_port.icount.dsr++;
+			uart_handle_dsr_change(&icom_port->uart_port,
+					       status & ICOM_DSR);
 		if (delta_status & ICOM_DCD)
 			uart_handle_dcd_change(&icom_port->uart_port,
-					       delta_status & ICOM_DCD);
+					       status & ICOM_DCD);
 		if (delta_status & ICOM_CTS)
 			uart_handle_cts_change(&icom_port->uart_port,
-					       delta_status & ICOM_CTS);
+					       status & ICOM_CTS);
 
 		wake_up_interruptible(&icom_port->uart_port.info->
 				      delta_msr_wait);
--- linux-next.orig/drivers/serial/imx.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/imx.c	2008-09-24 13:23:19.000000000 -0400
@@ -233,7 +233,7 @@ static void imx_mctrl_check(struct imx_p
 	if (changed & TIOCM_RI)
 		sport->port.icount.rng++;
 	if (changed & TIOCM_DSR)
-		sport->port.icount.dsr++;
+		uart_handle_dsr_change(&sport->port, status & TIOCM_DSR);
 	if (changed & TIOCM_CAR)
 		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
 	if (changed & TIOCM_CTS)
--- linux-next.orig/drivers/serial/ip22zilog.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/ip22zilog.c	2008-09-24 13:23:19.000000000 -0400
@@ -340,8 +340,8 @@ static void ip22zilog_status_handle(stru
 	}
 
 	if (ZS_WANTS_MODEM_STATUS(up)) {
-		if (status & SYNC)
-			up->port.icount.dsr++;
+		if ((status ^ up->prev_status) ^ SYNC)
+			uart_handle_dsr_change(&up->port, status & SYNC);
 
 		/* The Zilog just gives us an interrupt when DCD/CTS/etc. change.
 		 * But it does not tell us which bit has changed, we have to keep
--- linux-next.orig/drivers/serial/pmac_zilog.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/pmac_zilog.c	2008-09-24 13:23:19.000000000 -0400
@@ -354,8 +354,8 @@ static void pmz_status_handle(struct uar
 	zssync(uap);
 
 	if (ZS_IS_OPEN(uap) && ZS_WANTS_MODEM_STATUS(uap)) {
-		if (status & SYNC_HUNT)
-			uap->port.icount.dsr++;
+		if ((status ^ uap->prev_status) & SYNC)
+			uart_handle_dsr_change(&uap->port, status & SYNC);
 
 		/* The Zilog just gives us an interrupt when DCD/CTS/etc. change.
 		 * But it does not tell us which bit has changed, we have to keep
--- linux-next.orig/drivers/serial/pnx8xxx_uart.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/pnx8xxx_uart.c	2008-09-24 13:23:19.000000000 -0400
@@ -94,7 +94,7 @@ static void pnx8xxx_mctrl_check(struct p
 	if (changed & TIOCM_RI)
 		sport->port.icount.rng++;
 	if (changed & TIOCM_DSR)
-		sport->port.icount.dsr++;
+		uart_handle_dsr_change(&sport->port, status & TIOCM_DSR);
 	if (changed & TIOCM_CAR)
 		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
 	if (changed & TIOCM_CTS)
--- linux-next.orig/drivers/serial/sa1100.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/sa1100.c	2008-09-24 13:23:19.000000000 -0400
@@ -111,7 +111,7 @@ static void sa1100_mctrl_check(struct sa
 	if (changed & TIOCM_RI)
 		sport->port.icount.rng++;
 	if (changed & TIOCM_DSR)
-		sport->port.icount.dsr++;
+		uart_handle_dsr_change(&sport->port, status & TIOCM_DSR);
 	if (changed & TIOCM_CAR)
 		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
 	if (changed & TIOCM_CTS)
--- linux-next.orig/drivers/serial/sb1250-duart.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/sb1250-duart.c	2008-09-24 13:23:19.000000000 -0400
@@ -436,7 +436,7 @@ static void sbd_status_handle(struct sbd
 		uart_handle_cts_change(uport, !(delta & M_DUART_IN_PIN0_VAL));
 
 	if (delta & (M_DUART_IN_PIN2_VAL << S_DUART_IN_PIN_CHNG))
-		uport->icount.dsr++;
+		uart_handle_dsr_change(uport, !(delta & M_DUART_IN_PIN2_VAL));
 
 	if (delta & ((M_DUART_IN_PIN2_VAL | M_DUART_IN_PIN0_VAL) <<
 		     S_DUART_IN_PIN_CHNG))
--- linux-next.orig/drivers/serial/serial_ks8695.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/serial_ks8695.c	2008-09-24 13:23:19.000000000 -0400
@@ -212,7 +212,7 @@ static irqreturn_t ks8695uart_modem_stat
 		uart_handle_dcd_change(port, status & URMS_URDDCD);
 
 	if (status & URMS_URDDST)
-		port->icount.dsr++;
+		uart_handle_dsr_change(port, status & URMS_URDDST);
 
 	if (status & URMS_URDCTS)
 		uart_handle_cts_change(port, status & URMS_URDCTS);
--- linux-next.orig/drivers/serial/sunsab.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/sunsab.c	2008-09-24 13:23:19.000000000 -0400
@@ -294,7 +294,7 @@ static void check_status(struct uart_sun
 
 	if ((readb(&up->regs->r.pvr) & up->pvr_dsr_bit) ^ up->dsr) {
 		up->dsr = (readb(&up->regs->r.pvr) & up->pvr_dsr_bit) ? 0 : 1;
-		up->port.icount.dsr++;
+		uart_handle_dsr_change(&up->port, up->dsr);
 	}
 
 	wake_up_interruptible(&up->port.info->delta_msr_wait);
--- linux-next.orig/drivers/serial/sunzilog.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/sunzilog.c	2008-09-24 13:23:19.000000000 -0400
@@ -437,8 +437,8 @@ static void sunzilog_status_handle(struc
 	}
 
 	if (ZS_WANTS_MODEM_STATUS(up)) {
-		if (status & SYNC)
-			up->port.icount.dsr++;
+		if ((status ^ up->prev_status) ^ SYNC)
+			uart_handle_dsr_change(&up->port, status & SYNC);
 
 		/* The Zilog just gives us an interrupt when DCD/CTS/etc. change.
 		 * But it does not tell us which bit has changed, we have to keep
--- linux-next.orig/drivers/serial/zs.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/zs.c	2008-09-24 13:23:19.000000000 -0400
@@ -681,9 +681,10 @@ static void zs_status_handle(struct zs_p
 			uart_handle_dcd_change(uport,
 					       zport->mctrl & TIOCM_CAR);
 		if (delta & TIOCM_RNG)
-			uport->icount.dsr++;
-		if (delta & TIOCM_DSR)
 			uport->icount.rng++;
+		if (delta & TIOCM_DSR)
+			uart_handle_dsr_change(uport,
+					       zport->mctrl & TIOCM_DSR);
 
 		if (delta)
 			wake_up_interruptible(&uport->info->delta_msr_wait);
--- linux-next.orig/drivers/serial/pxa.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/pxa.c	2008-09-24 13:23:19.000000000 -0400
@@ -219,7 +219,7 @@ static inline void check_modem_status(st
 	if (status & UART_MSR_TERI)
 		up->port.icount.rng++;
 	if (status & UART_MSR_DDSR)
-		up->port.icount.dsr++;
+		uart_handle_dsr_change(&up->port, status & UART_MSR_DSR);
 	if (status & UART_MSR_DDCD)
 		uart_handle_dcd_change(&up->port, status & UART_MSR_DCD);
 	if (status & UART_MSR_DCTS)
--- linux-next.orig/drivers/serial/sunsu.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/sunsu.c	2008-09-24 13:23:19.000000000 -0400
@@ -435,7 +435,7 @@ static void check_modem_status(struct ua
 	if (status & UART_MSR_TERI)
 		up->port.icount.rng++;
 	if (status & UART_MSR_DDSR)
-		up->port.icount.dsr++;
+		uart_handle_dsr_change(&up->port, status & UART_MSR_DSR);
 	if (status & UART_MSR_DDCD)
 		uart_handle_dcd_change(&up->port, status & UART_MSR_DCD);
 	if (status & UART_MSR_DCTS)
--- linux-next.orig/drivers/serial/vr41xx_siu.c	2008-09-24 11:54:07.000000000 -0400
+++ linux-next/drivers/serial/vr41xx_siu.c	2008-09-24 13:23:19.000000000 -0400
@@ -382,7 +382,7 @@ static inline void check_modem_status(st
 	if (msr & UART_MSR_TERI)
 		port->icount.rng++;
 	if (msr & UART_MSR_DDSR)
-		port->icount.dsr++;
+		uart_handle_dsr_change(port, msr & UART_MSR_DSR);
 	if (msr & UART_MSR_DCTS)
 		uart_handle_cts_change(port, msr & UART_MSR_CTS);
 

-- 
Aristeu

