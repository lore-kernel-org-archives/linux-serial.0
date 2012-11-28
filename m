From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Thu, 29 Nov 2012 09:03:00 +1030
Message-ID: <20121128223300.GA24713@marvin.atrad.com.au>
References: <20121114060724.GN30156@marvin.atrad.com.au>
 <20121114121222.3e42860f@pyramind.ukuu.org.uk>
 <20121114231054.GC4505@marvin.atrad.com.au>
 <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
 <20121115001110.GE4505@marvin.atrad.com.au>
 <20121115155347.4be3dce8@pyramind.ukuu.org.uk>
 <20121128022917.GD28558@marvin.atrad.com.au>
 <20121128132419.1094d2d3@pyramind.ukuu.org.uk>
 <20121128134140.GA29452@marvin.atrad.com.au>
 <20121128173010.GC32286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:47813 "EHLO
	server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945911Ab2K1WdW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 17:33:22 -0500
Content-Disposition: inline
In-Reply-To: <20121128173010.GC32286@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>

On Wed, Nov 28, 2012 at 09:30:10AM -0800, Greg KH wrote:
> On Thu, Nov 29, 2012 at 12:11:40AM +1030, Jonathan Woithe wrote:
> > On Wed, Nov 28, 2012 at 01:24:19PM +0000, Alan Cox wrote:
> > > Can we get a Signed-off-by: for the first patch so we can try and get it
> > > into 3.8 ?
> > 
> > Sure.  See below.  The rest of the previous commit message was fine so I
> > haven't replicated it here.
> 
> Please do, otherwise I have to hand-edit the patch to add it back, and
> odds are, I will get it wrong...

No problem.  See below.  I took the opportunity to tweak the commit message
a touch.

jonathan


From: Alan Cox <alan@linux.intel.com>

quatech: add the other serial identifiers and preliminary control code
    
Jonathan Woithe posted an out of tree enabler/control module for these
cards.  Lift the relevant identifiers and put them in the 8250_pci driver
along with code used to control custom registers on these cards.
    
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Jonathan Woithe <jwoithe@just42.net>

---
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 17b7d26..43c6b4f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1040,6 +1040,253 @@ static int pci_asix_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+/* Quatech devices have their own extra interface features */
+
+struct quatech_feature {
+	u16 devid;
+	bool amcc;
+};
+
+#define QPCR_TEST_FOR1		0x3F
+#define QPCR_TEST_GET1		0x00
+#define QPCR_TEST_FOR2		0x40
+#define QPCR_TEST_GET2		0x40
+#define QPCR_TEST_FOR3		0x80
+#define QPCR_TEST_GET3		0x40
+#define QPCR_TEST_FOR4		0xC0
+#define QPCR_TEST_GET4		0x80
+
+#define QOPR_CLOCK_X1		0x0000
+#define QOPR_CLOCK_X2		0x0001
+#define QOPR_CLOCK_X4		0x0002
+#define QOPR_CLOCK_X8		0x0003
+#define QOPR_CLOCK_RATE_MASK	0x0003
+
+
+static struct quatech_feature quatech_cards[] = {
+	{ PCI_DEVICE_ID_QUATECH_QSC100,   1 },
+	{ PCI_DEVICE_ID_QUATECH_DSC100,   1 },
+	{ PCI_DEVICE_ID_QUATECH_DSC100E,  0 },
+	{ PCI_DEVICE_ID_QUATECH_DSC200,   1 },
+	{ PCI_DEVICE_ID_QUATECH_DSC200E,  0 },
+	{ PCI_DEVICE_ID_QUATECH_ESC100D,  1 },
+	{ PCI_DEVICE_ID_QUATECH_ESC100M,  1 },
+	{ PCI_DEVICE_ID_QUATECH_QSCP100,  1 },
+	{ PCI_DEVICE_ID_QUATECH_DSCP100,  1 },
+	{ PCI_DEVICE_ID_QUATECH_QSCP200,  1 },
+	{ PCI_DEVICE_ID_QUATECH_DSCP200,  1 },
+	{ PCI_DEVICE_ID_QUATECH_ESCLP100, 0 },
+	{ PCI_DEVICE_ID_QUATECH_QSCLP100, 0 },
+	{ PCI_DEVICE_ID_QUATECH_DSCLP100, 0 },
+	{ PCI_DEVICE_ID_QUATECH_SSCLP100, 0 },
+	{ PCI_DEVICE_ID_QUATECH_QSCLP200, 0 },
+	{ PCI_DEVICE_ID_QUATECH_DSCLP200, 0 },
+	{ PCI_DEVICE_ID_QUATECH_SSCLP200, 0 },
+	{ PCI_DEVICE_ID_QUATECH_SPPXP_100, 0 },
+	{ 0, }
+};
+
+static int pci_quatech_amcc(u16 devid)
+{
+	struct quatech_feature *qf = &quatech_cards[0];
+	while (qf->devid) {
+		if (qf->devid == devid)
+			return qf->amcc;
+		qf++;
+	}
+	pr_err("quatech: unknown port type '0x%04X'.\n", devid);
+	return 0;
+};
+
+static int pci_quatech_rqopr(struct uart_8250_port *port)
+{
+	unsigned long base = port->port.iobase;
+	u8 LCR, val;
+
+	LCR = inb(base + UART_LCR);
+	outb(0xBF, base + UART_LCR);
+	val = inb(base + UART_SCR);
+	outb(LCR, base + UART_LCR);
+	return val;
+}
+
+static void pci_quatech_wqopr(struct uart_8250_port *port, u8 qopr)
+{
+	unsigned long base = port->port.iobase;
+	u8 LCR, val;
+
+	LCR = inb(base + UART_LCR);
+	outb(0xBF, base + UART_LCR);
+	val = inb(base + UART_SCR);
+	outb(qopr, base + UART_SCR);
+	outb(LCR, base + UART_LCR);
+}
+
+static int pci_quatech_rqmcr(struct uart_8250_port *port)
+{
+	unsigned long base = port->port.iobase;
+	u8 LCR, val, qmcr;
+
+	LCR = inb(base + UART_LCR);
+	outb(0xBF, base + UART_LCR);
+	val = inb(base + UART_SCR);
+	outb(val | 0x10, base + UART_SCR);
+	qmcr = inb(base + UART_MCR);
+	outb(val, base + UART_SCR);
+	outb(LCR, base + UART_LCR);
+
+	return qmcr;
+}
+
+static void pci_quatech_wqmcr(struct uart_8250_port *port, u8 qmcr)
+{
+	unsigned long base = port->port.iobase;
+	u8 LCR, val;
+
+	LCR = inb(base + UART_LCR);
+	outb(0xBF, base + UART_LCR);
+	val = inb(base + UART_SCR);
+	outb(val | 0x10, base + UART_SCR);
+	outb(qmcr, base + UART_MCR);
+	outb(val, base + UART_SCR);
+	outb(LCR, base + UART_LCR);
+}
+
+static int pci_quatech_has_qmcr(struct uart_8250_port *port)
+{
+	unsigned long base = port->port.iobase;
+	u8 LCR, val;
+
+	LCR = inb(base + UART_LCR);
+	outb(0xBF, base + UART_LCR);
+	val = inb(base + UART_SCR);
+	if (val & 0x20) {
+		outb(0x80, UART_LCR);
+		if (!(inb(UART_SCR) & 0x20)) {
+			outb(LCR, base + UART_LCR);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int pci_quatech_test(struct uart_8250_port *port)
+{
+	u8 reg;
+	u8 qopr = pci_quatech_rqopr(port);
+	pci_quatech_wqopr(port, qopr & QPCR_TEST_FOR1);
+	reg = pci_quatech_rqopr(port) & 0xC0;
+	if (reg != QPCR_TEST_GET1)
+		return -EINVAL;
+	pci_quatech_wqopr(port, (qopr & QPCR_TEST_FOR1)|QPCR_TEST_FOR2);
+	reg = pci_quatech_rqopr(port) & 0xC0;
+	if (reg != QPCR_TEST_GET2)
+		return -EINVAL;
+	pci_quatech_wqopr(port, (qopr & QPCR_TEST_FOR1)|QPCR_TEST_FOR3);
+	reg = pci_quatech_rqopr(port) & 0xC0;
+	if (reg != QPCR_TEST_GET3)
+		return -EINVAL;
+	pci_quatech_wqopr(port, (qopr & QPCR_TEST_FOR1)|QPCR_TEST_FOR4);
+	reg = pci_quatech_rqopr(port) & 0xC0;
+	if (reg != QPCR_TEST_GET4)
+		return -EINVAL;
+
+	pci_quatech_wqopr(port, qopr);
+	return 0;	
+}
+
+static int pci_quatech_clock(struct uart_8250_port *port)
+{
+	u8 qopr, reg, set;
+	unsigned long clock;
+
+	if (pci_quatech_test(port) < 0)
+		return 1843200;
+
+	qopr = pci_quatech_rqopr(port);
+
+	pci_quatech_wqopr(port, qopr & ~QOPR_CLOCK_X8);
+	reg = pci_quatech_rqopr(port);
+	if (reg & QOPR_CLOCK_X8) {
+		clock = 1843200;
+		goto out;
+	}
+	pci_quatech_wqopr(port, qopr | QOPR_CLOCK_X8);
+	reg = pci_quatech_rqopr(port);
+	if (!(reg & QOPR_CLOCK_X8)) {
+		clock = 1843200;
+		goto out;
+	}
+	reg &= QOPR_CLOCK_X8;
+	if (reg == QOPR_CLOCK_X2) {
+		clock =  3685400;
+		set = QOPR_CLOCK_X2;
+	} else if (reg == QOPR_CLOCK_X4) {
+		clock = 7372800;
+		set = QOPR_CLOCK_X4;
+	} else if (reg == QOPR_CLOCK_X8) {
+		clock = 14745600;
+		set = QOPR_CLOCK_X8;
+	} else {
+		clock = 1843200;
+		set = QOPR_CLOCK_X1;
+	}
+	qopr &= ~QOPR_CLOCK_RATE_MASK;
+	qopr |= set;
+
+out:
+	pci_quatech_wqopr(port, qopr);
+	return clock;
+}
+
+static int pci_quatech_rs422(struct uart_8250_port *port)
+{
+	u8 qmcr;
+	int rs422 = 0;
+
+	if (!pci_quatech_has_qmcr(port))
+		return 0;
+	qmcr = pci_quatech_rqmcr(port);
+	pci_quatech_wqmcr(port, 0xFF);
+	if (pci_quatech_rqmcr(port))
+		rs422 = 1;
+	pci_quatech_wqmcr(port, qmcr);
+	return rs422;
+}
+
+static int pci_quatech_init(struct pci_dev *dev)
+{
+	if (pci_quatech_amcc(dev->device)) {
+		unsigned long base = pci_resource_start(dev, 0);
+		if (base) {
+			u32 tmp;
+			outl(inl(base + 0x38), base + 0x38);
+			tmp = inl(base + 0x3c);
+			outl(tmp | 0x01000000, base + 0x3c);
+			outl(tmp, base + 0x3c);
+		}
+	}
+	return 0;
+}
+
+static int pci_quatech_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	/* Needed by pci_quatech calls below */
+	port->port.iobase = pci_resource_start(priv->dev, FL_GET_BASE(board->flags));
+	/* Set up the clocking */
+	port->port.uartclk = pci_quatech_clock(port);
+	/* For now just warn about RS422 */
+	if (pci_quatech_rs422(port)) 
+		pr_warn( "quatech: software control of RS422 features not currently supported.\n");
+	return pci_default_setup(priv, board, port, idx);
+}
+
+static void __devexit pci_quatech_exit(struct pci_dev *dev)
+{
+}
+
 static int pci_default_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
@@ -1503,6 +1750,16 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_default_setup,
 		.exit		= __devexit_p(pci_plx9050_exit),
 	},
+	/* Quatech */
+	{
+		.vendor		= PCI_VENDOR_ID_QUATECH,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_quatech_init,
+		.setup		= pci_quatech_setup,
+		.exit		= __devexit_p(pci_quatech_exit),
+	},
 	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 232
 	 */
@@ -3257,18 +3514,70 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,
 		0x10b5, 0x106a, 0, 0,
 		pbn_plx_romulus },
+	/*
+	 * Quatech cards. These actually have configurable clocks but for
+	 * now we just use the default.
+	 *
+	 * 100 series are RS232, 200 series RS422, 
+	 */
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b1_4_115200 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b1_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC200E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_4_115200 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100D,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b1_8_115200 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100M,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b1_8_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCP100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_4_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCP100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCP200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_4_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCP200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESCLP100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_8_115200 },
+
 	{	PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,
 		PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4,
 		0, 0,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9d36b82..ce45006 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1867,8 +1867,23 @@
 #define PCI_VENDOR_ID_QUATECH		0x135C
 #define PCI_DEVICE_ID_QUATECH_QSC100	0x0010
 #define PCI_DEVICE_ID_QUATECH_DSC100	0x0020
+#define PCI_DEVICE_ID_QUATECH_DSC200	0x0030
+#define PCI_DEVICE_ID_QUATECH_QSC200	0x0040
 #define PCI_DEVICE_ID_QUATECH_ESC100D	0x0050
 #define PCI_DEVICE_ID_QUATECH_ESC100M	0x0060
+#define PCI_DEVICE_ID_QUATECH_QSCP100	0x0120
+#define PCI_DEVICE_ID_QUATECH_DSCP100	0x0130
+#define PCI_DEVICE_ID_QUATECH_QSCP200	0x0140
+#define PCI_DEVICE_ID_QUATECH_DSCP200	0x0150
+#define PCI_DEVICE_ID_QUATECH_QSCLP100	0x0170
+#define PCI_DEVICE_ID_QUATECH_DSCLP100	0x0180
+#define PCI_DEVICE_ID_QUATECH_DSC100E	0x0181
+#define PCI_DEVICE_ID_QUATECH_SSCLP100	0x0190
+#define PCI_DEVICE_ID_QUATECH_QSCLP200	0x01A0
+#define PCI_DEVICE_ID_QUATECH_DSCLP200	0x01B0
+#define PCI_DEVICE_ID_QUATECH_DSC200E	0x01B1
+#define PCI_DEVICE_ID_QUATECH_SSCLP200	0x01C0
+#define PCI_DEVICE_ID_QUATECH_ESCLP100	0x01E0
 #define PCI_DEVICE_ID_QUATECH_SPPXP_100 0x0278
 
 #define PCI_VENDOR_ID_SEALEVEL		0x135e
