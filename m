From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] sunzilog iomem annotations
Date: Sat, 27 Nov 2004 18:42:59 +0000
Message-ID: <20041127184259.GK26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261299AbUK0SnE
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Nov 2004 13:43:04 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-serial@vger.kernel.org

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC10-rc2-bk8-fore200e/drivers/serial/sunzilog.c RC10-rc2-bk8-sunzilog/drivers/serial/sunzilog.c
--- RC10-rc2-bk8-fore200e/drivers/serial/sunzilog.c	Tue Nov 23 19:52:12 2004
+++ RC10-rc2-bk8-sunzilog/drivers/serial/sunzilog.c	Sat Nov 27 12:58:40 2004
@@ -112,7 +112,7 @@
 #endif
 };
 
-#define ZILOG_CHANNEL_FROM_PORT(PORT)	((struct zilog_channel *)((PORT)->membase))
+#define ZILOG_CHANNEL_FROM_PORT(PORT)	((struct zilog_channel __iomem *)((PORT)->membase))
 #define UART_ZILOG(PORT)		((struct uart_sunzilog_port *)(PORT))
 
 #define ZS_IS_KEYB(UP)	((UP)->flags & SUNZILOG_FLAG_CONS_KEYB)
@@ -133,7 +133,7 @@
  * The port lock must be held and local IRQs must be disabled
  * when {read,write}_zsreg is invoked.
  */
-static unsigned char read_zsreg(struct zilog_channel *channel,
+static unsigned char read_zsreg(struct zilog_channel __iomem *channel,
 				unsigned char reg)
 {
 	unsigned char retval;
@@ -146,7 +146,7 @@
 	return retval;
 }
 
-static void write_zsreg(struct zilog_channel *channel,
+static void write_zsreg(struct zilog_channel __iomem *channel,
 			unsigned char reg, unsigned char value)
 {
 	sbus_writeb(reg, &channel->control);
@@ -155,7 +155,7 @@
 	ZSDELAY();
 }
 
-static void sunzilog_clear_fifo(struct zilog_channel *channel)
+static void sunzilog_clear_fifo(struct zilog_channel __iomem *channel)
 {
 	int i;
 
@@ -182,7 +182,7 @@
 /* This function must only be called when the TX is not busy.  The UART
  * port lock must be held and local interrupts disabled.
  */
-static void __load_zsregs(struct zilog_channel *channel, unsigned char *regs)
+static void __load_zsregs(struct zilog_channel __iomem *channel, unsigned char *regs)
 {
 	int i;
 
@@ -258,7 +258,7 @@
  * The UART port lock must be held and local interrupts disabled.
  */
 static void sunzilog_maybe_update_regs(struct uart_sunzilog_port *up,
-				       struct zilog_channel *channel)
+				       struct zilog_channel __iomem *channel)
 {
 	if (!ZS_REGS_HELD(up)) {
 		if (ZS_TX_ACTIVE(up)) {
@@ -315,7 +315,7 @@
 
 static struct tty_struct *
 sunzilog_receive_chars(struct uart_sunzilog_port *up,
-		       struct zilog_channel *channel,
+		       struct zilog_channel __iomem *channel,
 		       struct pt_regs *regs)
 {
 	struct tty_struct *tty;
@@ -419,7 +419,7 @@
 }
 
 static void sunzilog_status_handle(struct uart_sunzilog_port *up,
-				   struct zilog_channel *channel,
+				   struct zilog_channel __iomem *channel,
 				   struct pt_regs *regs)
 {
 	unsigned char status;
@@ -471,7 +471,7 @@
 }
 
 static void sunzilog_transmit_chars(struct uart_sunzilog_port *up,
-				    struct zilog_channel *channel)
+				    struct zilog_channel __iomem *channel)
 {
 	struct circ_buf *xmit;
 
@@ -548,7 +548,7 @@
 	struct uart_sunzilog_port *up = dev_id;
 
 	while (up) {
-		struct zilog_channel *channel
+		struct zilog_channel __iomem *channel
 			= ZILOG_CHANNEL_FROM_PORT(&up->port);
 		struct tty_struct *tty;
 		unsigned char r3;
@@ -609,7 +609,7 @@
  */
 static __inline__ unsigned char sunzilog_read_channel_status(struct uart_port *port)
 {
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 	unsigned long flags;
 	unsigned char status;
 
@@ -662,7 +662,7 @@
 static void sunzilog_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_sunzilog_port *up = (struct uart_sunzilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char set_bits, clear_bits;
 
 	set_bits = clear_bits = 0;
@@ -694,7 +694,7 @@
 static void sunzilog_start_tx(struct uart_port *port, unsigned int tty_start)
 {
 	struct uart_sunzilog_port *up = (struct uart_sunzilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char status;
 
 	up->flags |= SUNZILOG_FLAG_TX_ACTIVE;
@@ -736,7 +736,7 @@
 static void sunzilog_stop_rx(struct uart_port *port)
 {
 	struct uart_sunzilog_port *up = UART_ZILOG(port);
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 
 	if (ZS_IS_CONS(up))
 		return;
@@ -752,7 +752,7 @@
 static void sunzilog_enable_ms(struct uart_port *port)
 {
 	struct uart_sunzilog_port *up = (struct uart_sunzilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char new_reg;
 
 	new_reg = up->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
@@ -768,7 +768,7 @@
 static void sunzilog_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_sunzilog_port *up = (struct uart_sunzilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char set_bits, clear_bits, new_reg;
 	unsigned long flags;
 
@@ -794,7 +794,7 @@
 
 static void __sunzilog_startup(struct uart_sunzilog_port *up)
 {
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 
 	channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 	up->prev_status = sbus_readb(&channel->control);
@@ -849,7 +849,7 @@
 static void sunzilog_shutdown(struct uart_port *port)
 {
 	struct uart_sunzilog_port *up = UART_ZILOG(port);
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 	unsigned long flags;
 
 	if (ZS_IS_CONS(up))
@@ -1027,7 +1027,7 @@
 };
 
 static struct uart_sunzilog_port *sunzilog_port_table;
-static struct zilog_layout **sunzilog_chip_regs;
+static struct zilog_layout __iomem **sunzilog_chip_regs;
 
 static struct uart_sunzilog_port *sunzilog_irq_chain;
 static int zilog_irq = -1;
@@ -1053,10 +1053,10 @@
 
 static void __init sunzilog_alloc_tables(void)
 {
-	sunzilog_port_table = (struct uart_sunzilog_port *)
+	sunzilog_port_table = 
 		alloc_one_table(NUM_CHANNELS * sizeof(struct uart_sunzilog_port));
-	sunzilog_chip_regs = (struct zilog_layout **)
-		alloc_one_table(NUM_SUNZILOG * sizeof(struct zilog_layout *));
+	sunzilog_chip_regs = 
+		alloc_one_table(NUM_SUNZILOG * sizeof(struct zilog_layout __iomem *));
 
 	if (sunzilog_port_table == NULL || sunzilog_chip_regs == NULL) {
 		prom_printf("SunZilog: Cannot allocate tables.\n");
@@ -1069,7 +1069,7 @@
 /* We used to attempt to use the address property of the Zilog device node
  * but that totally is not necessary on sparc64.
  */
-static struct zilog_layout * __init get_zs_sun4u(int chip, int zsnode)
+static struct zilog_layout __iomem * __init get_zs_sun4u(int chip, int zsnode)
 {
 	unsigned long mapped_addr;
 	unsigned int sun4u_ino;
@@ -1133,7 +1133,7 @@
 		}
 	}
 
-	return (struct zilog_layout *) mapped_addr;
+	return (struct zilog_layout __iomem *) mapped_addr;
 }
 #else /* CONFIG_SPARC64 */
 
@@ -1141,10 +1141,10 @@
  * XXX The sun4d case is utterly screwed: it tries to re-walk the tree
  * (for the 3rd time) in order to find bootbus and cpu. Streamline it.
  */
-static struct zilog_layout * __init get_zs_sun4cmd(int chip, int node)
+static struct zilog_layout __iomem * __init get_zs_sun4cmd(int chip, int node)
 {
 	struct linux_prom_irqs irq_info[2];
-	unsigned long mapped_addr = 0;
+	void __iomem *mapped_addr = NULL;
 	int zsnode, cpunode, bbnode;
 	struct linux_prom_registers zsreg[4];
 	struct resource res;
@@ -1230,12 +1230,12 @@
 		prom_halt();
 	}
 
-	return (struct zilog_layout *) mapped_addr;
+	return (struct zilog_layout __iomem *) mapped_addr;
 }
 #endif /* !(CONFIG_SPARC64) */
 
 /* Get the address of the registers for SunZilog instance CHIP.  */
-static struct zilog_layout * __init get_zs(int chip, int node)
+static struct zilog_layout __iomem * __init get_zs(int chip, int node)
 {
 	if (chip < 0 || chip >= NUM_SUNZILOG) {
 		prom_printf("SunZilog: Illegal chip number %d in get_zs.\n", chip);
@@ -1261,7 +1261,7 @@
 		zilog_irq = 12;
 		res.end = (res.start + (8 - 1));
 		res.flags = IORESOURCE_IO;
-		return (struct zilog_layout *) sbus_ioremap(&res, 0, 8, "SunZilog");
+		return sbus_ioremap(&res, 0, 8, "SunZilog");
 	}
 
 	return get_zs_sun4cmd(chip, node);
@@ -1270,7 +1270,7 @@
 
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
-static void sunzilog_put_char(struct zilog_channel *channel, unsigned char ch)
+static void sunzilog_put_char(struct zilog_channel __iomem *channel, unsigned char ch)
 {
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
 
@@ -1485,7 +1485,7 @@
 static void __init sunzilog_prepare(void)
 {
 	struct uart_sunzilog_port *up;
-	struct zilog_layout *rp;
+	struct zilog_layout __iomem *rp;
 	int channel, chip;
 
 	/*
@@ -1501,8 +1501,8 @@
 
 	for (chip = 0; chip < NUM_SUNZILOG; chip++) {
 		rp = sunzilog_chip_regs[chip];
-		up[(chip * 2) + 0].port.membase = (char *) &rp->channelA;
-		up[(chip * 2) + 1].port.membase = (char *) &rp->channelB;
+		up[(chip * 2) + 0].port.membase = (void __iomem *)&rp->channelA;
+		up[(chip * 2) + 1].port.membase = (void __iomem *)&rp->channelB;
 
 		/* Channel A */
 		up[(chip * 2) + 0].port.iotype = SERIAL_IO_MEM;
@@ -1592,7 +1592,7 @@
 
 	for (i = 0; i < NUM_CHANNELS; i++) {
 		struct uart_sunzilog_port *up = &sunzilog_port_table[i];
-		struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
+		struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 		unsigned long flags;
 		int baud, brg;
 
@@ -1636,7 +1636,7 @@
 	}
 }
 
-static struct zilog_layout * __init get_zs(int chip, int node);
+static struct zilog_layout __iomem * __init get_zs(int chip, int node);
 
 static void __init sunzilog_scan_probe(struct zs_probe_scan *t, int node)
 {
