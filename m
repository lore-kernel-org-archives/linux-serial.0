From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 56/79] TTY: irq: Remove IRQF_DISABLED
Date: Wed, 26 Oct 2011 14:13:01 +0200
Message-ID: <1319631204-23262-56-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32827 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899Ab1JZMNz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:55 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Yong Zhang <yong.zhang0@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Yong Zhang <yong.zhang0@gmail.com>

Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/amiserial.c              |    2 +-
 drivers/tty/cyclades.c               |    2 +-
 drivers/tty/hvc/hvc_irq.c            |    2 +-
 drivers/tty/hvc/hvcs.c               |    2 +-
 drivers/tty/hvc/hvsi.c               |    2 +-
 drivers/tty/isicom.c                 |    2 +-
 drivers/tty/serial/68328serial.c     |    2 +-
 drivers/tty/serial/altera_jtaguart.c |    2 +-
 drivers/tty/serial/altera_uart.c     |    2 +-
 drivers/tty/serial/bfin_sport_uart.c |    2 +-
 drivers/tty/serial/bfin_uart.c       |    8 ++++----
 drivers/tty/serial/crisv10.c         |   18 +++++++++---------
 drivers/tty/serial/icom.c            |    2 +-
 drivers/tty/serial/lantiq.c          |    6 +++---
 drivers/tty/serial/mcf.c             |    2 +-
 drivers/tty/serial/mpc52xx_uart.c    |    2 +-
 drivers/tty/serial/serial_ks8695.c   |    8 ++++----
 drivers/tty/serial/sh-sci.c          |    2 +-
 drivers/tty/serial/sn_console.c      |    2 +-
 19 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 6d43f55..b84c834 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -2017,7 +2017,7 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	if (error)
 		goto fail_unregister;
 
-	error = request_irq(IRQ_AMIGA_RBF, ser_rx_int, IRQF_DISABLED,
+	error = request_irq(IRQ_AMIGA_RBF, ser_rx_int, 0,
 			    "serial RX", state);
 	if (error)
 		goto fail_free_irq;
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 5beef49..c9bf779 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -3367,7 +3367,7 @@ static int __init cy_detect_isa(void)
 
 		/* allocate IRQ */
 		if (request_irq(cy_isa_irq, cyy_interrupt,
-				IRQF_DISABLED, "Cyclom-Y", &cy_card[j])) {
+				0, "Cyclom-Y", &cy_card[j])) {
 			printk(KERN_ERR "Cyclom-Y/ISA found at 0x%lx, but "
 				"could not allocate IRQ#%d.\n",
 				(unsigned long)cy_isa_address, cy_isa_irq);
diff --git a/drivers/tty/hvc/hvc_irq.c b/drivers/tty/hvc/hvc_irq.c
index 2623e17..c9adb05 100644
--- a/drivers/tty/hvc/hvc_irq.c
+++ b/drivers/tty/hvc/hvc_irq.c
@@ -28,7 +28,7 @@ int notifier_add_irq(struct hvc_struct *hp, int irq)
 		hp->irq_requested = 0;
 		return 0;
 	}
-	rc = request_irq(irq, hvc_handle_interrupt, IRQF_DISABLED,
+	rc = request_irq(irq, hvc_handle_interrupt, 0,
 			   "hvc_console", hp);
 	if (!rc)
 		hp->irq_requested = 1;
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index e523773..55882b5 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1057,7 +1057,7 @@ static int hvcs_enable_device(struct hvcs_struct *hvcsd, uint32_t unit_address,
 	 * the conn was registered and now.
 	 */
 	if (!(rc = request_irq(irq, &hvcs_handle_interrupt,
-				IRQF_DISABLED, "ibmhvcs", hvcsd))) {
+				0, "ibmhvcs", hvcsd))) {
 		/*
 		 * It is possible the vty-server was removed after the irq was
 		 * requested but before we have time to enable interrupts.
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index c94e2f5..cdfa3e0 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1105,7 +1105,7 @@ static int __init hvsi_init(void)
 		struct hvsi_struct *hp = &hvsi_ports[i];
 		int ret = 1;
 
-		ret = request_irq(hp->virq, hvsi_interrupt, IRQF_DISABLED, "hvsi", hp);
+		ret = request_irq(hp->virq, hvsi_interrupt, 0, "hvsi", hp);
 		if (ret)
 			printk(KERN_ERR "HVSI: couldn't reserve irq 0x%x (error %i)\n",
 				hp->virq, ret);
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index db1cf9c..e5c295a 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -1598,7 +1598,7 @@ static int __devinit isicom_probe(struct pci_dev *pdev,
 	}
 
 	retval = request_irq(board->irq, isicom_interrupt,
-			IRQF_SHARED | IRQF_DISABLED, ISICOM_NAME, board);
+			IRQF_SHARED, ISICOM_NAME, board);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "Could not install handler at Irq %d. "
 			"Card%d will be disabled.\n", board->irq, index + 1);
diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index f549231..a88ef97 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -1306,7 +1306,7 @@ rs68328_init(void)
 
 	    if (request_irq(uart_irqs[i],
 			    rs_interrupt,
-			    IRQF_DISABLED,
+			    0,
 			    "M68328_UART", info))
                 panic("Unable to attach 68328 serial interrupt\n");
 	}
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 60e049b..00a73ec 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -218,7 +218,7 @@ static int altera_jtaguart_startup(struct uart_port *port)
 	unsigned long flags;
 	int ret;
 
-	ret = request_irq(port->irq, altera_jtaguart_interrupt, IRQF_DISABLED,
+	ret = request_irq(port->irq, altera_jtaguart_interrupt, 0,
 			DRV_NAME, port);
 	if (ret) {
 		pr_err(DRV_NAME ": unable to attach Altera JTAG UART %d "
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 50bc5a5..d902558 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -315,7 +315,7 @@ static int altera_uart_startup(struct uart_port *port)
 		return 0;
 	}
 
-	ret = request_irq(port->irq, altera_uart_interrupt, IRQF_DISABLED,
+	ret = request_irq(port->irq, altera_uart_interrupt, 0,
 			DRV_NAME, port);
 	if (ret) {
 		pr_err(DRV_NAME ": unable to attach Altera UART %d "
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 891d194..ee101c0 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -294,7 +294,7 @@ static int sport_startup(struct uart_port *port)
 		if (request_irq(gpio_to_irq(up->cts_pin),
 			sport_mctrl_cts_int,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-			IRQF_DISABLED, "BFIN_SPORT_UART_CTS", up)) {
+			0, "BFIN_SPORT_UART_CTS", up)) {
 			up->cts_pin = -1;
 			dev_info(port->dev, "Unable to attach BlackFin UART over SPORT CTS interrupt. So, disable it.\n");
 		}
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index c7e592d..66afb98 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -667,14 +667,14 @@ static int bfin_serial_startup(struct uart_port *port)
 		kgdboc_break_enabled = 0;
 	else {
 # endif
-	if (request_irq(uart->rx_irq, bfin_serial_rx_int, IRQF_DISABLED,
+	if (request_irq(uart->rx_irq, bfin_serial_rx_int, 0,
 	     "BFIN_UART_RX", uart)) {
 		printk(KERN_NOTICE "Unable to attach BlackFin UART RX interrupt\n");
 		return -EBUSY;
 	}
 
 	if (request_irq
-	    (uart->tx_irq, bfin_serial_tx_int, IRQF_DISABLED,
+	    (uart->tx_irq, bfin_serial_tx_int, 0,
 	     "BFIN_UART_TX", uart)) {
 		printk(KERN_NOTICE "Unable to attach BlackFin UART TX interrupt\n");
 		free_irq(uart->rx_irq, uart);
@@ -734,7 +734,7 @@ static int bfin_serial_startup(struct uart_port *port)
 		if (request_irq(gpio_to_irq(uart->cts_pin),
 			bfin_serial_mctrl_cts_int,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-			IRQF_DISABLED, "BFIN_UART_CTS", uart)) {
+			0, "BFIN_UART_CTS", uart)) {
 			uart->cts_pin = -1;
 			pr_info("Unable to attach BlackFin UART CTS interrupt. So, disable it.\n");
 		}
@@ -745,7 +745,7 @@ static int bfin_serial_startup(struct uart_port *port)
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
 	if (uart->cts_pin >= 0 && request_irq(uart->status_irq,
 		bfin_serial_mctrl_cts_int,
-		IRQF_DISABLED, "BFIN_UART_MODEM_STATUS", uart)) {
+		0, "BFIN_UART_MODEM_STATUS", uart)) {
 		uart->cts_pin = -1;
 		pr_info("Unable to attach BlackFin UART Modem Status interrupt.\n");
 	}
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index a931524..b743504 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -258,7 +258,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_out_enabled = 1,
 	  .dma_out_nbr = SER0_TX_DMA_NBR,
 	  .dma_out_irq_nbr = SER0_DMA_TX_IRQ_NBR,
-	  .dma_out_irq_flags = IRQF_DISABLED,
+	  .dma_out_irq_flags = 0,
 	  .dma_out_irq_description = "serial 0 dma tr",
 #else
 	  .dma_out_enabled = 0,
@@ -271,7 +271,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_in_enabled = 1,
 	  .dma_in_nbr = SER0_RX_DMA_NBR,
 	  .dma_in_irq_nbr = SER0_DMA_RX_IRQ_NBR,
-	  .dma_in_irq_flags = IRQF_DISABLED,
+	  .dma_in_irq_flags = 0,
 	  .dma_in_irq_description = "serial 0 dma rec",
 #else
 	  .dma_in_enabled = 0,
@@ -313,7 +313,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_out_enabled = 1,
 	  .dma_out_nbr = SER1_TX_DMA_NBR,
 	  .dma_out_irq_nbr = SER1_DMA_TX_IRQ_NBR,
-	  .dma_out_irq_flags = IRQF_DISABLED,
+	  .dma_out_irq_flags = 0,
 	  .dma_out_irq_description = "serial 1 dma tr",
 #else
 	  .dma_out_enabled = 0,
@@ -326,7 +326,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_in_enabled = 1,
 	  .dma_in_nbr = SER1_RX_DMA_NBR,
 	  .dma_in_irq_nbr = SER1_DMA_RX_IRQ_NBR,
-	  .dma_in_irq_flags = IRQF_DISABLED,
+	  .dma_in_irq_flags = 0,
 	  .dma_in_irq_description = "serial 1 dma rec",
 #else
 	  .dma_in_enabled = 0,
@@ -369,7 +369,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_out_enabled = 1,
 	  .dma_out_nbr = SER2_TX_DMA_NBR,
 	  .dma_out_irq_nbr = SER2_DMA_TX_IRQ_NBR,
-	  .dma_out_irq_flags = IRQF_DISABLED,
+	  .dma_out_irq_flags = 0,
 	  .dma_out_irq_description = "serial 2 dma tr",
 #else
 	  .dma_out_enabled = 0,
@@ -382,7 +382,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_in_enabled = 1,
 	  .dma_in_nbr = SER2_RX_DMA_NBR,
 	  .dma_in_irq_nbr = SER2_DMA_RX_IRQ_NBR,
-	  .dma_in_irq_flags = IRQF_DISABLED,
+	  .dma_in_irq_flags = 0,
 	  .dma_in_irq_description = "serial 2 dma rec",
 #else
 	  .dma_in_enabled = 0,
@@ -423,7 +423,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_out_enabled = 1,
 	  .dma_out_nbr = SER3_TX_DMA_NBR,
 	  .dma_out_irq_nbr = SER3_DMA_TX_IRQ_NBR,
-	  .dma_out_irq_flags = IRQF_DISABLED,
+	  .dma_out_irq_flags = 0,
 	  .dma_out_irq_description = "serial 3 dma tr",
 #else
 	  .dma_out_enabled = 0,
@@ -436,7 +436,7 @@ static struct e100_serial rs_table[] = {
 	  .dma_in_enabled = 1,
 	  .dma_in_nbr = SER3_RX_DMA_NBR,
 	  .dma_in_irq_nbr = SER3_DMA_RX_IRQ_NBR,
-	  .dma_in_irq_flags = IRQF_DISABLED,
+	  .dma_in_irq_flags = 0,
 	  .dma_in_irq_description = "serial 3 dma rec",
 #else
 	  .dma_in_enabled = 0,
@@ -4558,7 +4558,7 @@ static int __init rs_init(void)
 	/* hook the irq's for DMA channel 6 and 7, serial output and input, and some more... */
 
 	if (request_irq(SERIAL_IRQ_NBR, ser_interrupt,
-			IRQF_SHARED | IRQF_DISABLED, "serial ", driver))
+			IRQF_SHARED, "serial ", driver))
 		panic("%s: Failed to request irq8", __func__);
 
 #endif
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 8a869e5..d55709a 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1554,7 +1554,7 @@ static int __devinit icom_probe(struct pci_dev *dev,
 
 	 /* save off irq and request irq line */
 	 if ( (retval = request_irq(dev->irq, icom_interrupt,
-				   IRQF_DISABLED | IRQF_SHARED, ICOM_DRIVER_NAME,
+				   IRQF_SHARED, ICOM_DRIVER_NAME,
 				   (void *) icom_adapter))) {
 		  goto probe_exit2;
 	 }
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 58cf279..9e2d42b 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -338,21 +338,21 @@ lqasc_startup(struct uart_port *port)
 		ASCCON_ROEN, port->membase + LTQ_ASC_CON);
 
 	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
-		IRQF_DISABLED, "asc_tx", port);
+		0, "asc_tx", port);
 	if (retval) {
 		pr_err("failed to request lqasc_tx_int\n");
 		return retval;
 	}
 
 	retval = request_irq(ltq_port->rx_irq, lqasc_rx_int,
-		IRQF_DISABLED, "asc_rx", port);
+		0, "asc_rx", port);
 	if (retval) {
 		pr_err("failed to request lqasc_rx_int\n");
 		goto err1;
 	}
 
 	retval = request_irq(ltq_port->err_irq, lqasc_err_int,
-		IRQF_DISABLED, "asc_err", port);
+		0, "asc_err", port);
 	if (retval) {
 		pr_err("failed to request lqasc_err_int\n");
 		goto err2;
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 3394b7c..9afca09 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -380,7 +380,7 @@ static void mcf_config_port(struct uart_port *port, int flags)
 	/* Clear mask, so no surprise interrupts. */
 	writeb(0, port->membase + MCFUART_UIMR);
 
-	if (request_irq(port->irq, mcf_interrupt, IRQF_DISABLED, "UART", port))
+	if (request_irq(port->irq, mcf_interrupt, 0, "UART", port))
 		printk(KERN_ERR "MCF: unable to attach ColdFire UART %d "
 			"interrupt vector=%d\n", port->line, port->irq);
 }
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index c395520..1093a88 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -274,7 +274,7 @@ static unsigned int mpc5200b_psc_set_baudrate(struct uart_port *port,
 
 static void mpc52xx_psc_get_irq(struct uart_port *port, struct device_node *np)
 {
-	port->irqflags = IRQF_DISABLED;
+	port->irqflags = 0;
 	port->irq = irq_of_parse_and_map(np, 0);
 }
 
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index 5551f7a..7c13639 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -337,19 +337,19 @@ static int ks8695uart_startup(struct uart_port *port)
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(KS8695_IRQ_UART_TX, ks8695uart_tx_chars, IRQF_DISABLED, "UART TX", port);
+	retval = request_irq(KS8695_IRQ_UART_TX, ks8695uart_tx_chars, 0, "UART TX", port);
 	if (retval)
 		goto err_tx;
 
-	retval = request_irq(KS8695_IRQ_UART_RX, ks8695uart_rx_chars, IRQF_DISABLED, "UART RX", port);
+	retval = request_irq(KS8695_IRQ_UART_RX, ks8695uart_rx_chars, 0, "UART RX", port);
 	if (retval)
 		goto err_rx;
 
-	retval = request_irq(KS8695_IRQ_UART_LINE_STATUS, ks8695uart_rx_chars, IRQF_DISABLED, "UART LineStatus", port);
+	retval = request_irq(KS8695_IRQ_UART_LINE_STATUS, ks8695uart_rx_chars, 0, "UART LineStatus", port);
 	if (retval)
 		goto err_ls;
 
-	retval = request_irq(KS8695_IRQ_UART_MODEM_STATUS, ks8695uart_modem_status, IRQF_DISABLED, "UART ModemStatus", port);
+	retval = request_irq(KS8695_IRQ_UART_MODEM_STATUS, ks8695uart_modem_status, 0, "UART ModemStatus", port);
 	if (retval)
 		goto err_ms;
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2ec57b2..ca1a4c3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1961,7 +1961,7 @@ static int __devinit sci_init_single(struct platform_device *dev,
 	 * For the muxed case there's nothing more to do.
 	 */
 	port->irq		= p->irqs[SCIx_RXI_IRQ];
-	port->irqflags		= IRQF_DISABLED;
+	port->irqflags		= 0;
 
 	port->serial_in		= sci_serial_in;
 	port->serial_out	= sci_serial_out;
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 7320507..238c7df 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -738,7 +738,7 @@ static void __init sn_sal_switch_to_interrupts(struct sn_cons_port *port)
 		DPRINTF("sn_console: switching to interrupt driven console\n");
 
 		if (request_irq(SGI_UART_VECTOR, sn_sal_interrupt,
-				IRQF_DISABLED | IRQF_SHARED,
+				IRQF_SHARED,
 				"SAL console driver", port) >= 0) {
 			spin_lock_irqsave(&port->sc_port.lock, flags);
 			port->sc_port.irq = SGI_UART_VECTOR;
-- 
1.7.7

