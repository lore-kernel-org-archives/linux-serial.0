From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH] serial/8250: Add support for Exar's XR17V35x family of
 multi-port PCIe UARTs.
Date: Fri, 9 Nov 2012 16:39:14 -0600
Message-ID: <CAJp1Oe4DuffN_EWP-zVznBX+JqnE6kEAsXS1oHvfvfLC5DVOAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42477 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab2KIWjf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Nov 2012 17:39:35 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4431914vbb.19
        for <linux-serial@vger.kernel.org>; Fri, 09 Nov 2012 14:39:34 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>

From: Matt Schulte <matts@commtech-fastcom.com>

Add support for new devices - Exar's XR17V35x family of multi-port PCIe UARTs.

Built against tty-next 76cc43868c1e9d6344ad6c4992c4f6abd5204a8f

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
This is the first time I've sent in a patch so let me know if I did
something wrong.

Hopefully if this gets accepted I will be able to submit an additional
patch to add
support for my company's PCIe cards that use these UARTs.

 drivers/tty/serial/8250/8250.c     |   56 +++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c |   95 ++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h            |    3 +
 include/uapi/linux/serial_core.h   |    3 +-
 include/uapi/linux/serial_reg.h    |    6 ++
 5 files changed, 162 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 5ccbd90..b46066a 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -282,6 +282,15 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR,
 	},
+	[PORT_XR17V35X] = {
+		.name		= "XR17V35X",
+		.fifo_size	= 256,
+		.tx_loadsz	= 256,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_11 |
+				  UART_FCR_T_TRIG_11,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR |
+				  UART_CAP_SLEEP,
+	},
 	[PORT_LPC3220] = {
 		.name		= "LPC3220",
 		.fifo_size	= 64,
@@ -574,6 +583,18 @@ EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
  */
 static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
+	/*
+	 * Exar UARTs have a SLEEP register that enables or disables
+	 * each UART to enter sleep mode separately.  On the XR17V35x the
+	 * register is accessible to each UART at the UART_EXAR_SLEEP
+	 * offset but the UART channel may only write to the corresponding
+	 * bit.
+	 */
+	if (p->port.type == PORT_XR17V35X) {
+		serial_out(p, UART_EXAR_SLEEP, 0xff);
+		return;
+	}
+
 	if (p->capabilities & UART_CAP_SLEEP) {
 		if (p->capabilities & UART_CAP_EFR) {
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
@@ -882,6 +903,27 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	up->capabilities |= UART_CAP_FIFO;

 	/*
+	 * XR17V35x UARTs have an extra divisor register, DLD
+	 * that gets enabled with when DLAB is set which will
+	 * cause the device to incorrectly match and assign
+	 * port type to PORT_16650.  The EFR for this UART is
+	 * found at offset 0x09. Instead check the Deice ID (DVID)
+	 * register for a 2, 4 or 8 port UART.
+	 */
+	status1 = serial_in(up, UART_EXAR_DVID);
+	if (status1 == 0x82 || status1 == 0x84 || status1 == 0x88) {
+		if (up->port.flags & UPF_EXAR_EFR) {
+			DEBUG_AUTOCONF("Exar XR17V35x ");
+			up->port.type = PORT_XR17V35X;
+			up->capabilities |= UART_CAP_AFE | UART_CAP_EFR |
+						UART_CAP_SLEEP;
+
+			return;
+		}
+
+	}
+
+	/*
 	 * Check for presence of the EFR when DLAB is set.
 	 * Only ST16C650V1 UARTs pass this test.
 	 */
@@ -1484,6 +1526,7 @@ EXPORT_SYMBOL_GPL(serial8250_modem_status);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	unsigned char status;
+	unsigned char int0, int1, int2, int3;
 	unsigned long flags;
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
@@ -1503,6 +1546,19 @@ int serial8250_handle_irq(struct uart_port
*port, unsigned int iir)
 	if (status & UART_LSR_THRE)
 		serial8250_tx_chars(up);

+	/*
+	 * These Exar UARTs have an extra interrupt indicator that could
+	 * fire for a few unimplemented interrupts.  Put this here just
+	 * to be on the safe side that these interrupts don't go unhandled.
+	 */
+
+	if (up->port.type == PORT_XR17V35X && status == 0) {
+		int0 = serial_port_in(port, 0x80);
+		int1 = serial_port_in(port, 0x81);
+		int2 = serial_port_in(port, 0x82);
+		int3 = serial_port_in(port, 0x83);
+	}
+
 	spin_unlock_irqrestore(&port->lock, flags);
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_pci.c
b/drivers/tty/serial/8250/8250_pci.c
index 508063b..b724593 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1165,6 +1165,38 @@ pci_xr17c154_setup(struct serial_private *priv,
 }

 static int
+pci_xr17v35x_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	u8 __iomem *p;
+
+	p = pci_ioremap_bar(priv->dev, 0);
+
+	/*
+	 * Setup Multipurpose Input/Output pins.
+	 */
+
+	port->port.flags |= UPF_EXAR_EFR;
+	if (idx == 0) {
+		writeb(0x00, p + 0x8f); /*MPIOINT[7:0]*/
+		writeb(0x00, p + 0x90); /*MPIOLVL[7:0]*/
+		writeb(0x00, p + 0x91); /*MPIO3T[7:0]*/
+		writeb(0x00, p + 0x92); /*MPIOINV[7:0]*/
+		writeb(0x00, p + 0x93); /*MPIOSEL[7:0]*/
+		writeb(0x00, p + 0x94); /*MPIOOD[7:0]*/
+		writeb(0x00, p + 0x95); /*MPIOINT[15:8]*/
+		writeb(0x00, p + 0x96); /*MPIOLVL[15:8]*/
+		writeb(0x00, p + 0x97); /*MPIO3T[15:8]*/
+		writeb(0x00, p + 0x98); /*MPIOINV[15:8]*/
+		writeb(0x00, p + 0x99); /*MPIOSEL[15:8]*/
+		writeb(0x00, p + 0x9a); /*MPIOOD[15:8]*/
+	}
+	iounmap(p);
+	return pci_default_setup(priv, board, port, idx);
+}
+
+static int
 pci_wch_ch353_setup(struct serial_private *priv,
                     const struct pciserial_board *board,
                     struct uart_8250_port *port, int idx)
@@ -1622,6 +1654,27 @@ static struct pci_serial_quirk
pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17c154_setup,
 	},
+	{
+		.vendor = PCI_VENDOR_ID_EXAR,
+		.device = PCI_DEVICE_ID_EXAR_XR17V352,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_xr17v35x_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_EXAR,
+		.device = PCI_DEVICE_ID_EXAR_XR17V354,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_xr17v35x_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_EXAR,
+		.device = PCI_DEVICE_ID_EXAR_XR17V358,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_xr17v35x_setup,
+	},
 	/*
 	 * Xircom cards
 	 */
@@ -1962,6 +2015,9 @@ enum pci_board_num_t {
 	pbn_exar_XR17C152,
 	pbn_exar_XR17C154,
 	pbn_exar_XR17C158,
+	pbn_exar_XR17V352,
+	pbn_exar_XR17V354,
+	pbn_exar_XR17V358,
 	pbn_exar_ibm_saturn,
 	pbn_pasemi_1682M,
 	pbn_ni8430_2,
@@ -2580,6 +2636,30 @@ static struct pciserial_board pci_boards[]
__devinitdata = {
 		.base_baud	= 921600,
 		.uart_offset	= 0x200,
 	},
+	[pbn_exar_XR17V352] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 7812500,
+		.uart_offset	= 0x400,
+		.reg_shift	= 0,
+		.first_offset	= 0,
+	},
+	[pbn_exar_XR17V354] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 7812500,
+		.uart_offset	= 0x400,
+		.reg_shift	= 0,
+		.first_offset	= 0,
+	},
+	[pbn_exar_XR17V358] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 7812500,
+		.uart_offset	= 0x400,
+		.reg_shift	= 0,
+		.first_offset	= 0,
+	},
 	[pbn_exar_ibm_saturn] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
@@ -3826,6 +3906,21 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0,
 		0, pbn_exar_XR17C158 },
+	/*
+	 * Exar Corp. XR17V35[248] Dual/Quad/Octal PCIe UARTs
+	 */
+	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V352,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17V352 },
+	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V354,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17V354 },
+	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V358,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17V358 },

 	/*
 	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9d36b82..0199a7a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1985,6 +1985,9 @@
 #define PCI_DEVICE_ID_EXAR_XR17C152	0x0152
 #define PCI_DEVICE_ID_EXAR_XR17C154	0x0154
 #define PCI_DEVICE_ID_EXAR_XR17C158	0x0158
+#define PCI_DEVICE_ID_EXAR_XR17V352	0x0352
+#define PCI_DEVICE_ID_EXAR_XR17V354	0x0354
+#define PCI_DEVICE_ID_EXAR_XR17V358	0x0358

 #define PCI_VENDOR_ID_MICROGATE		0x13c0
 #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index ebcc73f..78f99d9 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -49,7 +49,8 @@
 #define PORT_XR17D15X	21	/* Exar XR17D15x UART */
 #define PORT_LPC3220	22	/* NXP LPC32xx SoC "Standard" UART */
 #define PORT_8250_CIR	23	/* CIR infrared port, has its own driver */
-#define PORT_MAX_8250	23	/* max port ID */
+#define PORT_XR17V35X	24	/* Exar XR17V35x UARTs */
+#define PORT_MAX_8250	24	/* max port ID */

 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 5ed325e..d0b4760 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -367,5 +367,11 @@
 #define UART_OMAP_MDR1_CIR_MODE		0x06	/* CIR mode */
 #define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */

+/*
+ * These are definitions for the XR17V35X and XR17D15X
+ */
+#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
+#define UART_EXAR_DVID		0x8d	/* Device identification */
+
 #endif /* _LINUX_SERIAL_REG_H */

-- 
1.7.2.5
