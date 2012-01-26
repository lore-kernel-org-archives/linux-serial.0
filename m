From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] serial: Kill off NO_IRQ
Date: Thu, 26 Jan 2012 17:44:09 +0000
Message-ID: <20120126174145.16858.15219.stgit@bob.linux.org.uk>
References: <20120126174121.16858.13827.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59293 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab2AZRah (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jan 2012 12:30:37 -0500
In-Reply-To: <20120126174121.16858.13827.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We transform the offenders into a test of irq <= 0 which will be ok while
the ARM people get their platform sorted. Once that is done (or in a while
if they don't do it anyway) then we will change them all to !irq checks.

For arch specific drivers that are already using NO_IRQ = 0 we just test
against zero so we don't need to re-review them later.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/hvc/hvc_beat.c         |    2 +-
 drivers/tty/hvc/hvc_rtas.c         |    2 +-
 drivers/tty/hvc/hvc_udbg.c         |    2 +-
 drivers/tty/hvc/hvc_xen.c          |    2 +-
 drivers/tty/hvc/hvcs.c             |    4 ++--
 drivers/tty/hvc/hvsi.c             |    2 +-
 drivers/tty/serial/21285.c         |    4 ++--
 drivers/tty/serial/8250/8250.c     |   21 +++++++--------------
 drivers/tty/serial/8250/m32r_sio.c |   11 ++---------
 drivers/tty/serial/mpc52xx_uart.c  |    4 ++--
 drivers/tty/serial/mux.c           |    2 +-
 drivers/tty/serial/pmac_zilog.c    |    2 +-
 drivers/tty/serial/sunzilog.c      |   10 +++++-----
 drivers/tty/serial/ucc_uart.c      |    2 +-
 drivers/tty/serial/vr41xx_siu.c    |    4 ++--
 15 files changed, 30 insertions(+), 44 deletions(-)


diff --git a/drivers/tty/hvc/hvc_beat.c b/drivers/tty/hvc/hvc_beat.c
index 5fe4631..1560d23 100644
--- a/drivers/tty/hvc/hvc_beat.c
+++ b/drivers/tty/hvc/hvc_beat.c
@@ -113,7 +113,7 @@ static int __init hvc_beat_init(void)
 	if (!firmware_has_feature(FW_FEATURE_BEAT))
 		return -ENODEV;
 
-	hp = hvc_alloc(0, NO_IRQ, &hvc_beat_get_put_ops, 16);
+	hp = hvc_alloc(0, 0, &hvc_beat_get_put_ops, 16);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 	hvc_beat_dev = hp;
diff --git a/drivers/tty/hvc/hvc_rtas.c b/drivers/tty/hvc/hvc_rtas.c
index 61c4a61..0069bb8 100644
--- a/drivers/tty/hvc/hvc_rtas.c
+++ b/drivers/tty/hvc/hvc_rtas.c
@@ -94,7 +94,7 @@ static int __init hvc_rtas_init(void)
 
 	/* Allocate an hvc_struct for the console device we instantiated
 	 * earlier.  Save off hp so that we can return it on exit */
-	hp = hvc_alloc(hvc_rtas_cookie, NO_IRQ, &hvc_rtas_get_put_ops, 16);
+	hp = hvc_alloc(hvc_rtas_cookie, 0, &hvc_rtas_get_put_ops, 16);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 
diff --git a/drivers/tty/hvc/hvc_udbg.c b/drivers/tty/hvc/hvc_udbg.c
index b0957e6..4c9b13e 100644
--- a/drivers/tty/hvc/hvc_udbg.c
+++ b/drivers/tty/hvc/hvc_udbg.c
@@ -69,7 +69,7 @@ static int __init hvc_udbg_init(void)
 
 	BUG_ON(hvc_udbg_dev);
 
-	hp = hvc_alloc(0, NO_IRQ, &hvc_udbg_ops, 16);
+	hp = hvc_alloc(0, 0, &hvc_udbg_ops, 16);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 52fdf60..a1b0a75 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -176,7 +176,7 @@ static int __init xen_hvc_init(void)
 		xencons_irq = bind_evtchn_to_irq(xen_start_info->console.domU.evtchn);
 	}
 	if (xencons_irq < 0)
-		xencons_irq = 0; /* NO_IRQ */
+		xencons_irq = 0;
 	else
 		irq_set_noprobe(xencons_irq);
 
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index b9040be..df7e7a0 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1203,7 +1203,7 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 {
 	struct hvcs_struct *hvcsd;
 	unsigned long flags;
-	int irq = NO_IRQ;
+	int irq;
 
 	/*
 	 * Is someone trying to close the file associated with this device after
@@ -1264,7 +1264,7 @@ static void hvcs_hangup(struct tty_struct * tty)
 	struct hvcs_struct *hvcsd = tty->driver_data;
 	unsigned long flags;
 	int temp_open_count;
-	int irq = NO_IRQ;
+	int irq;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 	/* Preserve this so that we know how many kref refs to put */
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index cdfa3e0..1b5f28b 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1237,7 +1237,7 @@ static int __init hvsi_console_init(void)
 		hp->state = HVSI_CLOSED;
 		hp->vtermno = *vtermno;
 		hp->virq = irq_create_mapping(NULL, irq[0]);
-		if (hp->virq == NO_IRQ) {
+		if (hp->virq == 0) {
 			printk(KERN_ERR "%s: couldn't create irq mapping for 0x%x\n",
 				__func__, irq[0]);
 			continue;
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 1b37626..f899996 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -331,7 +331,7 @@ static int serial21285_verify_port(struct uart_port *port, struct serial_struct
 	int ret = 0;
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_21285)
 		ret = -EINVAL;
-	if (ser->irq != NO_IRQ)
+	if (ser->irq <= 0)
 		ret = -EINVAL;
 	if (ser->baud_base != port->uartclk / 16)
 		ret = -EINVAL;
@@ -360,7 +360,7 @@ static struct uart_ops serial21285_ops = {
 static struct uart_port serial21285_port = {
 	.mapbase	= 0x42000160,
 	.iotype		= UPIO_MEM,
-	.irq		= NO_IRQ,
+	.irq		= 0,
 	.fifosize	= 16,
 	.ops		= &serial21285_ops,
 	.flags		= UPF_BOOT_AUTOCONF,
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 9f50c4e..b0eb961 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -86,13 +86,6 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define BOTH_EMPTY 	(UART_LSR_TEMT | UART_LSR_THRE)
 
 
-/*
- * We default to IRQ0 for the "no irq" hack.   Some
- * machine types want others as well - they're free
- * to redefine this in their header file.
- */
-#define is_real_interrupt(irq)	((irq) != 0)
-
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define CONFIG_SERIAL_DETECT_IRQ 1
 #endif
@@ -1750,7 +1743,7 @@ static void serial8250_backup_timeout(unsigned long data)
 	 * Must disable interrupts or else we risk racing with the interrupt
 	 * based handler.
 	 */
-	if (is_real_interrupt(up->port.irq)) {
+	if (up->port.irq) {
 		ier = serial_in(up, UART_IER);
 		serial_out(up, UART_IER, 0);
 	}
@@ -1775,7 +1768,7 @@ static void serial8250_backup_timeout(unsigned long data)
 	if (!(iir & UART_IIR_NO_INT))
 		serial8250_tx_chars(up);
 
-	if (is_real_interrupt(up->port.irq))
+	if (up->port.irq)
 		serial_out(up, UART_IER, ier);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -2028,7 +2021,7 @@ static int serial8250_startup(struct uart_port *port)
 		serial_outp(up, UART_LCR, 0);
 	}
 
-	if (is_real_interrupt(up->port.irq)) {
+	if (up->port.irq) {
 		unsigned char iir1;
 		/*
 		 * Test for UARTs that do not reassert THRE when the
@@ -2083,7 +2076,7 @@ static int serial8250_startup(struct uart_port *port)
 	 * hardware interrupt, we use a timer-based system.  The original
 	 * driver used to do this with IRQ0.
 	 */
-	if (!is_real_interrupt(up->port.irq)) {
+	if (!up->port.irq) {
 		up->timer.data = (unsigned long)up;
 		mod_timer(&up->timer, jiffies + uart_poll_timeout(port));
 	} else {
@@ -2099,13 +2092,13 @@ static int serial8250_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (up->port.flags & UPF_FOURPORT) {
-		if (!is_real_interrupt(up->port.irq))
+		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
 	} else
 		/*
 		 * Most PC uarts need OUT2 raised to enable interrupts.
 		 */
-		if (is_real_interrupt(up->port.irq))
+		if (up->port.irq)
 			up->port.mctrl |= TIOCM_OUT2;
 
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
@@ -2223,7 +2216,7 @@ static void serial8250_shutdown(struct uart_port *port)
 
 	del_timer_sync(&up->timer);
 	up->timer.function = serial8250_timeout;
-	if (is_real_interrupt(up->port.irq))
+	if (up->port.irq)
 		serial_unlink_irq_chain(up);
 }
 
diff --git a/drivers/tty/serial/8250/m32r_sio.c b/drivers/tty/serial/8250/m32r_sio.c
index 94a6792..e465dda 100644
--- a/drivers/tty/serial/8250/m32r_sio.c
+++ b/drivers/tty/serial/8250/m32r_sio.c
@@ -70,13 +70,6 @@
 
 #define PASS_LIMIT	256
 
-/*
- * We default to IRQ0 for the "no irq" hack.   Some
- * machine types want others as well - they're free
- * to redefine this in their header file.
- */
-#define is_real_interrupt(irq)	((irq) != 0)
-
 #define BASE_BAUD	115200
 
 /* Standard COM flags */
@@ -640,7 +633,7 @@ static int m32r_sio_startup(struct uart_port *port)
 	 * hardware interrupt, we use a timer-based system.  The original
 	 * driver used to do this with IRQ0.
 	 */
-	if (!is_real_interrupt(up->port.irq)) {
+	if (!up->port.irq) {
 		unsigned int timeout = up->port.timeout;
 
 		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
@@ -687,7 +680,7 @@ static void m32r_sio_shutdown(struct uart_port *port)
 
 	sio_init();
 
-	if (!is_real_interrupt(up->port.irq))
+	if (!up->port.irq)
 		del_timer_sync(&up->timer);
 	else
 		serial_unlink_irq_chain(up);
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 1093a88..e9a770d 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -507,7 +507,7 @@ static int __init mpc512x_psc_fifoc_init(void)
 
 	psc_fifoc_irq = irq_of_parse_and_map(np, 0);
 	of_node_put(np);
-	if (psc_fifoc_irq == NO_IRQ) {
+	if (psc_fifoc_irq == 0) {
 		pr_err("%s: Can't get FIFOC irq\n", __func__);
 		iounmap(psc_fifoc);
 		return -ENODEV;
@@ -1354,7 +1354,7 @@ static int __devinit mpc52xx_uart_of_probe(struct platform_device *op)
 	}
 
 	psc_ops->get_irq(port, op->dev.of_node);
-	if (port->irq == NO_IRQ) {
+	if (port->irq == 0) {
 		dev_dbg(&op->dev, "Could not get irq\n");
 		return -EINVAL;
 	}
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 06f6aef..c61d950 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -499,7 +499,7 @@ static int __init mux_probe(struct parisc_device *dev)
 		port->membase	= ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
 		port->iotype	= UPIO_MEM;
 		port->type	= PORT_MUX;
-		port->irq	= NO_IRQ;
+		port->irq	= 0;
 		port->uartclk	= 0;
 		port->fifosize	= MUX_FIFO_SIZE;
 		port->ops	= &mux_pops;
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index e9c2dfe4..08ebe90 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1506,7 +1506,7 @@ no_dma:
 	 * fixed up interrupt info, but we use the device-tree directly
 	 * here due to early probing so we need the fixup too.
 	 */
-	if (uap->port.irq == NO_IRQ &&
+	if (uap->port.irq == 0 &&
 	    np->parent && np->parent->parent &&
 	    of_device_is_compatible(np->parent->parent, "gatwick")) {
 		/* IRQs on gatwick are offset by 64 */
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 8e916e7..5a47d1b 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1397,7 +1397,7 @@ static void __devinit sunzilog_init_hw(struct uart_sunzilog_port *up)
 #endif
 }
 
-static int zilog_irq = -1;
+static int zilog_irq;
 
 static int __devinit zs_probe(struct platform_device *op)
 {
@@ -1425,7 +1425,7 @@ static int __devinit zs_probe(struct platform_device *op)
 
 	rp = sunzilog_chip_regs[inst];
 
-	if (zilog_irq == -1)
+	if (!zilog_irq)
 		zilog_irq = op->archdata.irqs[0];
 
 	up = &sunzilog_port_table[inst * 2];
@@ -1580,7 +1580,7 @@ static int __init sunzilog_init(void)
 	if (err)
 		goto out_unregister_uart;
 
-	if (zilog_irq != -1) {
+	if (!zilog_irq) {
 		struct uart_sunzilog_port *up = sunzilog_irq_chain;
 		err = request_irq(zilog_irq, sunzilog_interrupt, IRQF_SHARED,
 				  "zs", sunzilog_irq_chain);
@@ -1621,7 +1621,7 @@ static void __exit sunzilog_exit(void)
 {
 	platform_driver_unregister(&zs_driver);
 
-	if (zilog_irq != -1) {
+	if (!zilog_irq) {
 		struct uart_sunzilog_port *up = sunzilog_irq_chain;
 
 		/* Disable Interrupts */
@@ -1637,7 +1637,7 @@ static void __exit sunzilog_exit(void)
 		}
 
 		free_irq(zilog_irq, sunzilog_irq_chain);
-		zilog_irq = -1;
+		zilog_irq = 0;
 	}
 
 	if (sunzilog_reg.nr) {
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 2ebe606..f99b0c9 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1360,7 +1360,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	}
 
 	qe_port->port.irq = irq_of_parse_and_map(np, 0);
-	if (qe_port->port.irq == NO_IRQ) {
+	if (qe_port->port.irq == 0) {
 		dev_err(&ofdev->dev, "could not map IRQ for UCC%u\n",
 		       qe_port->ucc_num + 1);
 		ret = -EINVAL;
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 83148e7..cf0d948 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -61,7 +61,7 @@
 static struct uart_port siu_uart_ports[SIU_PORTS_MAX] = {
 	[0 ... SIU_PORTS_MAX-1] = {
 		.lock	= __SPIN_LOCK_UNLOCKED(siu_uart_ports->lock),
-		.irq	= -1,
+		.irq	= 0,
 	},
 };
 
@@ -171,7 +171,7 @@ static inline unsigned int siu_check_type(struct uart_port *port)
 {
 	if (port->line == 0)
 		return PORT_VR41XX_SIU;
-	if (port->line == 1 && port->irq != -1)
+	if (port->line == 1 && port->irq)
 		return PORT_VR41XX_DSIU;
 
 	return PORT_UNKNOWN;

