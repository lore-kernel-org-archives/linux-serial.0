From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 4/8] tty: Replace ASYNC_CHECK_CD and update atomically
Date: Sat,  9 Apr 2016 17:53:23 -0700
Message-ID: <1460249607-8014-5-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Replace ASYNC_CHECK_CD bit in the tty_port::flags field with
TTY_PORT_CHECK_CD bit in the tty_port::iflags field. Introduce helpers
tty_port_set_check_carrier() and tty_port_check_carrier() to abstract
the atomic bit ops.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/char/pcmcia/synclink_cs.c   |  8 ++------
 drivers/isdn/i4l/isdn_tty.c         |  8 ++------
 drivers/tty/amiserial.c             |  9 +++------
 drivers/tty/cyclades.c              | 14 ++++----------
 drivers/tty/isicom.c                |  7 ++-----
 drivers/tty/mxser.c                 |  9 +++------
 drivers/tty/synclink.c              |  8 ++------
 drivers/tty/synclink_gt.c           |  8 ++------
 drivers/tty/synclinkmp.c            |  8 ++------
 include/linux/tty.h                 | 13 +++++++++++++
 net/irda/ircomm/ircomm_tty.c        |  4 ++--
 net/irda/ircomm/ircomm_tty_attach.c |  2 +-
 net/irda/ircomm/ircomm_tty_ioctl.c  |  5 +----
 13 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index bdf41ac..bf54f4e 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1101,7 +1101,7 @@ static void dcd_change(MGSLPC_INFO *info, struct tty_struct *tty)
 	wake_up_interruptible(&info->status_event_wait_q);
 	wake_up_interruptible(&info->event_wait_q);
 
-	if (info->port.flags & ASYNC_CHECK_CD) {
+	if (tty_port_check_carrier(&info->port)) {
 		if (debug_level >= DEBUG_LEVEL_ISR)
 			printk("%s CD now %s...", info->device_name,
 			       (info->serial_signals & SerialSignal_DCD) ? "on" : "off");
@@ -1467,11 +1467,7 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
-
-	if (cflag & CLOCAL)
-		info->port.flags &= ~ASYNC_CHECK_CD;
-	else
-		info->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 	/* process tty input control flags */
 
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index d8468f3..023a350a 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1043,11 +1043,7 @@ isdn_tty_change_speed(modem_info *info)
 	if (!(cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 
-	if (cflag & CLOCAL)
-		port->flags &= ~ASYNC_CHECK_CD;
-	else {
-		port->flags |= ASYNC_CHECK_CD;
-	}
+	tty_port_set_check_carrier(port, ~cflag & CLOCAL);
 }
 
 static int
@@ -2526,7 +2522,7 @@ isdn_tty_modem_result(int code, modem_info *info)
 		if (info->closing || (!info->port.tty))
 			return;
 
-		if (info->port.flags & ASYNC_CHECK_CD)
+		if (tty_port_check_carrier(&info->port))
 			tty_hangup(info->port.tty);
 	}
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 80d6165..b4ab97d 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -398,7 +398,7 @@ static void check_modem_status(struct serial_state *info)
 		wake_up_interruptible(&port->delta_msr_wait);
 	}
 
-	if ((port->flags & ASYNC_CHECK_CD) && (dstatus & SER_DCD)) {
+	if (tty_port_check_carrier(port) && (dstatus & SER_DCD)) {
 #if (defined(SERIAL_DEBUG_OPEN) || defined(SERIAL_DEBUG_INTR))
 		printk("ttyS%d CD now %s...", info->line,
 		       (!(status & SER_DCD)) ? "on" : "off");
@@ -730,12 +730,9 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	tty_port_set_cts_flow(port, cflag & CRTSCTS);
 	if (cflag & CRTSCTS)
 		info->IER |= UART_IER_MSI;
-	if (cflag & CLOCAL)
-		port->flags &= ~ASYNC_CHECK_CD;
-	else {
-		port->flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(port, ~cflag & CLOCAL);
+	if (~cflag & CLOCAL)
 		info->IER |= UART_IER_MSI;
-	}
 	/* TBD:
 	 * Does clearing IER_MSI imply that we should disable the VBL interrupt ?
 	 */
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 1a12776..9d1e19b 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -714,7 +714,7 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 		wake_up_interruptible(&info->port.delta_msr_wait);
 	}
 
-	if ((mdm_change & CyDCD) && (info->port.flags & ASYNC_CHECK_CD)) {
+	if ((mdm_change & CyDCD) && tty_port_check_carrier(&info->port)) {
 		if (mdm_status & CyDCD)
 			wake_up_interruptible(&info->port.open_wait);
 		else
@@ -1119,7 +1119,7 @@ static void cyz_handle_cmd(struct cyclades_card *cinfo)
 		case C_CM_MDCD:
 			info->icount.dcd++;
 			delta_count++;
-			if (info->port.flags & ASYNC_CHECK_CD) {
+			if (tty_port_check_carrier(&info->port)) {
 				u32 dcd = fw_ver > 241 ? param :
 					readl(&info->u.cyz.ch_ctrl->rs_status);
 				if (dcd & C_RS_DCD)
@@ -2088,10 +2088,7 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 			info->cor2 |= CyCtsAE;
 		else
 			info->cor2 &= ~CyCtsAE;
-		if (cflag & CLOCAL)
-			info->port.flags &= ~ASYNC_CHECK_CD;
-		else
-			info->port.flags |= ASYNC_CHECK_CD;
+		tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 	 /***********************************************
 	    The hardware option, CyRtsAO, presents RTS when
@@ -2250,10 +2247,7 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 		}
 
 		/* CD sensitivity */
-		if (cflag & CLOCAL)
-			info->port.flags &= ~ASYNC_CHECK_CD;
-		else
-			info->port.flags |= ASYNC_CHECK_CD;
+		tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 		if (baud == 0) {	/* baud rate is zero, turn off line */
 			cy_writel(&ch_ctrl->rs_control,
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index c5f06b5..0b2bae1 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -577,7 +577,7 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 		header = inw(base);
 		switch (header & 0xff) {
 		case 0:	/* Change in EIA signals */
-			if (port->port.flags & ASYNC_CHECK_CD) {
+			if (tty_port_check_carrier(&port->port)) {
 				if (port->status & ISI_DCD) {
 					if (!(header & ISI_DCD)) {
 					/* Carrier has been lost  */
@@ -758,10 +758,7 @@ static void isicom_config_port(struct tty_struct *tty)
 		outw(channel_setup, base);
 		InterruptTheCard(base);
 	}
-	if (C_CLOCAL(tty))
-		port->port.flags &= ~ASYNC_CHECK_CD;
-	else
-		port->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&port->port, !C_CLOCAL(tty));
 
 	/* flow control settings ...*/
 	flow_ctrl = 0;
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8f3fdad..ab618ef 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -746,12 +746,9 @@ static int mxser_change_speed(struct tty_struct *tty,
 		}
 	}
 	outb(info->MCR, info->ioaddr + UART_MCR);
-	if (cflag & CLOCAL) {
-		info->port.flags &= ~ASYNC_CHECK_CD;
-	} else {
-		info->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
+	if (~cflag & CLOCAL)
 		info->IER |= UART_IER_MSI;
-	}
 	outb(info->IER, info->ioaddr + UART_IER);
 
 	/*
@@ -824,7 +821,7 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 	port->mon_data.modem_status = status;
 	wake_up_interruptible(&port->port.delta_msr_wait);
 
-	if ((port->port.flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
+	if (tty_port_check_carrier(&port->port) && (status & UART_MSR_DDCD)) {
 		if (status & UART_MSR_DCD)
 			wake_up_interruptible(&port->port.open_wait);
 	}
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index b55f846..b67b54a 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1340,7 +1340,7 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 		wake_up_interruptible(&info->status_event_wait_q);
 		wake_up_interruptible(&info->event_wait_q);
 
-		if ( (info->port.flags & ASYNC_CHECK_CD) && 
+		if (tty_port_check_carrier(&info->port) &&
 		     (status & MISCSTATUS_DCD_LATCHED) ) {
 			if ( debug_level >= DEBUG_LEVEL_ISR )
 				printk("%s CD now %s...", info->device_name,
@@ -1967,11 +1967,7 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
-
-	if (cflag & CLOCAL)
-		info->port.flags &= ~ASYNC_CHECK_CD;
-	else
-		info->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 	/* process tty input control flags */
 	
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c76f546..333652a 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -2080,7 +2080,7 @@ static void dcd_change(struct slgt_info *info, unsigned short status)
 	wake_up_interruptible(&info->event_wait_q);
 	info->pending_bh |= BH_STATUS;
 
-	if (info->port.flags & ASYNC_CHECK_CD) {
+	if (tty_port_check_carrier(&info->port)) {
 		if (info->signals & SerialSignal_DCD)
 			wake_up_interruptible(&info->port.open_wait);
 		else {
@@ -2577,11 +2577,7 @@ static void change_params(struct slgt_info *info)
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
-
-	if (cflag & CLOCAL)
-		info->port.flags &= ~ASYNC_CHECK_CD;
-	else
-		info->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 	/* process tty input control flags */
 
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 95eddc4..17bab5f 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -2463,7 +2463,7 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
 		wake_up_interruptible(&info->status_event_wait_q);
 		wake_up_interruptible(&info->event_wait_q);
 
-		if ( (info->port.flags & ASYNC_CHECK_CD) &&
+		if (tty_port_check_carrier(&info->port) &&
 		     (status & MISCSTATUS_DCD_LATCHED) ) {
 			if ( debug_level >= DEBUG_LEVEL_ISR )
 				printk("%s CD now %s...", info->device_name,
@@ -2814,11 +2814,7 @@ static void change_params(SLMP_INFO *info)
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
-
-	if (cflag & CLOCAL)
-		info->port.flags &= ~ASYNC_CHECK_CD;
-	else
-		info->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 	/* process tty input control flags */
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index dbeeb86..4254dfb 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -584,6 +584,19 @@ static inline void tty_port_set_active(struct tty_port *port, bool val)
 		clear_bit(TTY_PORT_ACTIVE, &port->iflags);
 }
 
+static inline bool tty_port_check_carrier(struct tty_port *port)
+{
+	return test_bit(TTY_PORT_CHECK_CD, &port->iflags);
+}
+
+static inline void tty_port_set_check_carrier(struct tty_port *port, bool val)
+{
+	if (val)
+		set_bit(TTY_PORT_CHECK_CD, &port->iflags);
+	else
+		clear_bit(TTY_PORT_CHECK_CD, &port->iflags);
+}
+
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index 681fe0b..5b7ce59 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -999,7 +999,7 @@ void ircomm_tty_check_modem_status(struct ircomm_tty_cb *self)
 	if (status & IRCOMM_DCE_DELTA_ANY) {
 		/*wake_up_interruptible(&self->delta_msr_wait);*/
 	}
-	if ((self->port.flags & ASYNC_CHECK_CD) && (status & IRCOMM_DELTA_CD)) {
+	if (tty_port_check_carrier(&self->port) && (status & IRCOMM_DELTA_CD)) {
 		pr_debug("%s(), ircomm%d CD now %s...\n", __func__ , self->line,
 			 (status & IRCOMM_CD) ? "on" : "off");
 
@@ -1255,7 +1255,7 @@ static void ircomm_tty_line_info(struct ircomm_tty_cb *self, struct seq_file *m)
 		seq_printf(m, "%cASYNC_CTS_FLOW", sep);
 		sep = '|';
 	}
-	if (self->port.flags & ASYNC_CHECK_CD) {
+	if (tty_port_check_carrier(&self->port)) {
 		seq_printf(m, "%cASYNC_CHECK_CD", sep);
 		sep = '|';
 	}
diff --git a/net/irda/ircomm/ircomm_tty_attach.c b/net/irda/ircomm/ircomm_tty_attach.c
index 61137f8..0a41101 100644
--- a/net/irda/ircomm/ircomm_tty_attach.c
+++ b/net/irda/ircomm/ircomm_tty_attach.c
@@ -968,7 +968,7 @@ static int ircomm_tty_state_ready(struct ircomm_tty_cb *self,
 		ircomm_tty_next_state(self, IRCOMM_TTY_SEARCH);
 		ircomm_tty_start_watchdog_timer(self, 3*HZ);
 
-		if (self->port.flags & ASYNC_CHECK_CD) {
+		if (tty_port_check_carrier(&self->port)) {
 			/* Drop carrier */
 			self->settings.dce = IRCOMM_DELTA_CD;
 			ircomm_tty_check_modem_status(self);
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index 1220973..e24724d 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -96,10 +96,7 @@ static void ircomm_tty_change_speed(struct ircomm_tty_cb *self,
 	} else {
 		self->settings.flow_control &= ~IRCOMM_RTS_CTS_IN;
 	}
-	if (cflag & CLOCAL)
-		self->port.flags &= ~ASYNC_CHECK_CD;
-	else
-		self->port.flags |= ASYNC_CHECK_CD;
+	tty_port_set_check_carrier(&self->port, ~cflag & CLOCAL);
 #if 0
 	/*
 	 * Set up parity check flag
-- 
2.8.1
