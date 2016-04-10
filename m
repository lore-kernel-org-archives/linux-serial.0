From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/8] tty: Replace ASYNC_CTS_FLOW bit and update atomically
Date: Sat,  9 Apr 2016 17:53:21 -0700
Message-ID: <1460249607-8014-3-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Replace ASYNC_CTS_FLOW bit in the tty_port::flags field with
TTY_PORT_CTS_FLOW bit in the tty_port::iflags field. Add
tty_port_set_cts_flow() helper to abstract the atomic bit ops.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/char/pcmcia/synclink_cs.c  |  5 +----
 drivers/tty/amiserial.c            |  6 ++----
 drivers/tty/cyclades.c             | 10 ++++------
 drivers/tty/isicom.c               |  6 ++----
 drivers/tty/mxser.c                |  4 +---
 drivers/tty/synclink.c             |  7 ++-----
 drivers/tty/synclink_gt.c          |  5 +----
 drivers/tty/synclinkmp.c           |  5 +----
 include/linux/tty.h                | 12 ++++++++++--
 net/irda/ircomm/ircomm_tty_ioctl.c |  3 +--
 10 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index bcae5bb..bdf41ac 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1466,10 +1466,7 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 	}
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
-	if (cflag & CRTSCTS)
-		info->port.flags |= ASYNC_CTS_FLOW;
-	else
-		info->port.flags &= ~ASYNC_CTS_FLOW;
+	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
 
 	if (cflag & CLOCAL)
 		info->port.flags &= ~ASYNC_CHECK_CD;
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index e68208e..92717b0 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -727,11 +727,9 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	info->IER &= ~UART_IER_MSI;
 	if (port->flags & ASYNC_HARDPPS_CD)
 		info->IER |= UART_IER_MSI;
-	if (cflag & CRTSCTS) {
-		port->flags |= ASYNC_CTS_FLOW;
+	tty_port_set_cts_flow(port, cflag & CRTSCTS);
+	if (cflag & CRTSCTS)
 		info->IER |= UART_IER_MSI;
-	} else
-		port->flags &= ~ASYNC_CTS_FLOW;
 	if (cflag & CLOCAL)
 		port->flags &= ~ASYNC_CHECK_CD;
 	else {
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index d67e542..1a12776 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -2083,13 +2083,11 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 			info->cor1 |= CyPARITY_NONE;
 
 		/* CTS flow control flag */
-		if (cflag & CRTSCTS) {
-			info->port.flags |= ASYNC_CTS_FLOW;
+		tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
+		if (cflag & CRTSCTS)
 			info->cor2 |= CyCtsAE;
-		} else {
-			info->port.flags &= ~ASYNC_CTS_FLOW;
+		else
 			info->cor2 &= ~CyCtsAE;
-		}
 		if (cflag & CLOCAL)
 			info->port.flags &= ~ASYNC_CHECK_CD;
 		else
@@ -2234,7 +2232,7 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 		}
 		/* As the HW flow control is done in firmware, the driver
 		   doesn't need to care about it */
-		info->port.flags &= ~ASYNC_CTS_FLOW;
+		tty_port_set_cts_flow(&info->port, 0);
 
 		/* XON/XOFF/XANY flow control flags */
 		sw_flow = 0;
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 8bf6763..c5f06b5 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -765,11 +765,9 @@ static void isicom_config_port(struct tty_struct *tty)
 
 	/* flow control settings ...*/
 	flow_ctrl = 0;
-	port->port.flags &= ~ASYNC_CTS_FLOW;
-	if (C_CRTSCTS(tty)) {
-		port->port.flags |= ASYNC_CTS_FLOW;
+	tty_port_set_cts_flow(&port->port, C_CRTSCTS(tty));
+	if (C_CRTSCTS(tty))
 		flow_ctrl |= ISICOM_CTSRTS;
-	}
 	if (I_IXON(tty))
 		flow_ctrl |= ISICOM_RESPOND_XONXOFF;
 	if (I_IXOFF(tty))
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index f23c2a1..8f3fdad 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -711,8 +711,8 @@ static int mxser_change_speed(struct tty_struct *tty,
 	/* CTS flow control flag and modem status interrupts */
 	info->IER &= ~UART_IER_MSI;
 	info->MCR &= ~UART_MCR_AFE;
+	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
 	if (cflag & CRTSCTS) {
-		info->port.flags |= ASYNC_CTS_FLOW;
 		info->IER |= UART_IER_MSI;
 		if ((info->type == PORT_16550A) || (info->board->chip_flag)) {
 			info->MCR |= UART_MCR_AFE;
@@ -744,8 +744,6 @@ static int mxser_change_speed(struct tty_struct *tty,
 				}
 			}
 		}
-	} else {
-		info->port.flags &= ~ASYNC_CTS_FLOW;
 	}
 	outb(info->MCR, info->ioaddr + UART_MCR);
 	if (cflag & CLOCAL) {
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 3768e5c..0e42901 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1966,11 +1966,8 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	}
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
-	if (cflag & CRTSCTS)
-		info->port.flags |= ASYNC_CTS_FLOW;
-	else
-		info->port.flags &= ~ASYNC_CTS_FLOW;
-		
+	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
+
 	if (cflag & CLOCAL)
 		info->port.flags &= ~ASYNC_CHECK_CD;
 	else
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index ceeaeb7..5da69d3 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -2576,10 +2576,7 @@ static void change_params(struct slgt_info *info)
 	}
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
-	if (cflag & CRTSCTS)
-		info->port.flags |= ASYNC_CTS_FLOW;
-	else
-		info->port.flags &= ~ASYNC_CTS_FLOW;
+	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
 
 	if (cflag & CLOCAL)
 		info->port.flags &= ~ASYNC_CHECK_CD;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index b0cce4b..7a21491 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -2813,10 +2813,7 @@ static void change_params(SLMP_INFO *info)
 	}
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
-	if (cflag & CRTSCTS)
-		info->port.flags |= ASYNC_CTS_FLOW;
-	else
-		info->port.flags &= ~ASYNC_CTS_FLOW;
+	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
 
 	if (cflag & CLOCAL)
 		info->port.flags &= ~ASYNC_CHECK_CD;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4e0dbda0..989d755b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -255,7 +255,6 @@ struct tty_port {
 #define TTY_PORT_CTS_FLOW	3	/* h/w flow control enabled */
 #define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
 
-
 /*
  * Where all of the state associated with a tty is kept while the tty
  * is open.  Since the termios state should be kept even if the tty
@@ -561,9 +560,18 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
 /* If the cts flow control is enabled, return true. */
 static inline bool tty_port_cts_enabled(struct tty_port *port)
 {
-	return port->flags & ASYNC_CTS_FLOW;
+	return test_bit(TTY_PORT_CTS_FLOW, &port->iflags);
 }
 
+static inline void tty_port_set_cts_flow(struct tty_port *port, bool val)
+{
+	if (val)
+		set_bit(TTY_PORT_CTS_FLOW, &port->iflags);
+	else
+		clear_bit(TTY_PORT_CTS_FLOW, &port->iflags);
+}
+
+
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index 8d8fd28..1220973 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -86,15 +86,14 @@ static void ircomm_tty_change_speed(struct ircomm_tty_cb *self,
 	ircomm_param_request(self, IRCOMM_DATA_RATE, FALSE);
 
 	/* CTS flow control flag and modem status interrupts */
+	tty_port_set_cts_flow(&self->port, cflag & CRTSCTS);
 	if (cflag & CRTSCTS) {
-		self->port.flags |= ASYNC_CTS_FLOW;
 		self->settings.flow_control |= IRCOMM_RTS_CTS_IN;
 		/* This got me. Bummer. Jean II */
 		if (self->service_type == IRCOMM_3_WIRE_RAW)
 			net_warn_ratelimited("%s(), enabling RTS/CTS on link that doesn't support it (3-wire-raw)\n",
 					     __func__);
 	} else {
-		self->port.flags &= ~ASYNC_CTS_FLOW;
 		self->settings.flow_control &= ~IRCOMM_RTS_CTS_IN;
 	}
 	if (cflag & CLOCAL)
-- 
2.8.1
