From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 4/7] serial: exar: Move Commtech adapters to 8250_exar as well
Date: Wed,  8 Feb 2017 17:09:06 +0100
Message-ID: <5cfee2a023528c43a187bda4116717cd1c518ac1.1486570149.git.jan.kiszka@siemens.com>
References: <cover.1486570149.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486570149.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486570149.git.jan.kiszka@siemens.com>
References: <cover.1486570149.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Those are Exar-based, too.

With the required refactoring of the code to fit into 8250_exar, we
automatically fix the same issue pci_xr17v35x_setup had before: 8XMODE,
FCTL, TXTRG and RXTRG were always only set for port 0. Now they are
initialized for the correct target port by using port.membase.

Now we can also cleanly fix the blacklist of 8250_pci so that all
Commtech devices are rejected and 8250_exar can handle them.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c |  83 +++++++++++++++++++--
 drivers/tty/serial/8250/8250_pci.c  | 139 +-----------------------------------
 2 files changed, 79 insertions(+), 143 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index f489f25..9af4266 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -24,11 +24,15 @@
 
 #include "8250.h"
 
-#define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
-#define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021
-#define PCI_DEVICE_ID_COMMTECH_4222PCIE	0x0022
-#define PCI_DEVICE_ID_EXAR_XR17V4358	0x4358
-#define PCI_DEVICE_ID_EXAR_XR17V8358	0x8358
+#define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
+#define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
+#define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
+#define PCI_DEVICE_ID_COMMTECH_2328PCI335	0x000b
+#define PCI_DEVICE_ID_COMMTECH_4224PCIE		0x0020
+#define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
+#define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022
+#define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
+#define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
 
 #define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
 #define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
@@ -84,6 +88,55 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 }
 
 static int
+pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+		     struct uart_8250_port *port, int idx)
+{
+	unsigned int offset = idx * 0x200;
+	unsigned int baud = 1843200;
+	u8 __iomem *p;
+	int err;
+
+	port->port.flags |= UPF_EXAR_EFR;
+	port->port.uartclk = baud * 16;
+
+	err = default_setup(priv, pcidev, idx, offset, port);
+	if (err)
+		return err;
+
+	p = port->port.membase;
+
+	writeb(0x00, p + UART_EXAR_8XMODE);
+	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
+	writeb(32, p + UART_EXAR_TXTRG);
+	writeb(32, p + UART_EXAR_RXTRG);
+
+	/*
+	 * Setup Multipurpose Input/Output pins.
+	 */
+	if (idx == 0) {
+		switch (pcidev->device) {
+		case PCI_DEVICE_ID_COMMTECH_4222PCI335:
+		case PCI_DEVICE_ID_COMMTECH_4224PCI335:
+			writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
+			writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+			writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+			break;
+		case PCI_DEVICE_ID_COMMTECH_2324PCI335:
+		case PCI_DEVICE_ID_COMMTECH_2328PCI335:
+			writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+			writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
+			writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
+			break;
+		}
+		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
+	}
+
+	return 0;
+}
+
+static int
 pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		       struct uart_8250_port *port, int idx)
 {
@@ -291,6 +344,21 @@ static int __maybe_unused exar_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
+static const struct exar8250_board pbn_fastcom335_2 = {
+	.num_ports	= 2,
+	.setup		= pci_fastcom335_setup,
+};
+
+static const struct exar8250_board pbn_fastcom335_4 = {
+	.num_ports	= 4,
+	.setup		= pci_fastcom335_setup,
+};
+
+static const struct exar8250_board pbn_fastcom335_8 = {
+	.num_ports	= 8,
+	.setup		= pci_fastcom335_setup,
+};
+
 static const struct exar8250_board pbn_connect = {
 	.setup		= pci_connect_tech_setup,
 };
@@ -375,6 +443,11 @@ static struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V35x),
 	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V35x),
 	EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V35x),
+
+	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCI335, pbn_fastcom335_2),
+	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCI335, pbn_fastcom335_4),
+	EXAR_DEVICE(COMMTECH, COMMTECH_2324PCI335, pbn_fastcom335_4),
+	EXAR_DEVICE(COMMTECH, COMMTECH_2328PCI335, pbn_fastcom335_8),
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0b63109..56768f5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1610,67 +1610,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
 #endif
 }
 
-#define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
-#define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
-#define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
-#define UART_EXAR_MPIOINV_7_0	0x92	/* MPIOINV[7:0] */
-#define UART_EXAR_MPIOSEL_7_0	0x93	/* MPIOSEL[7:0] */
-#define UART_EXAR_MPIOOD_7_0	0x94	/* MPIOOD[7:0] */
-#define UART_EXAR_MPIOINT_15_8	0x95	/* MPIOINT[15:8] */
-#define UART_EXAR_MPIOLVL_15_8	0x96	/* MPIOLVL[15:8] */
-#define UART_EXAR_MPIO3T_15_8	0x97	/* MPIO3T[15:8] */
-#define UART_EXAR_MPIOINV_15_8	0x98	/* MPIOINV[15:8] */
-#define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
-#define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
-#define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
-#define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
-#define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a
-#define PCI_DEVICE_ID_COMMTECH_2328PCI335 0x000b
-
-static int
-pci_fastcom335_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	u8 __iomem *p;
-
-	p = pci_ioremap_bar(priv->dev, 0);
-	if (p == NULL)
-		return -ENOMEM;
-
-	port->port.flags |= UPF_EXAR_EFR;
-
-	/*
-	 * Setup Multipurpose Input/Output pins.
-	 */
-	if (idx == 0) {
-		switch (priv->dev->device) {
-		case PCI_DEVICE_ID_COMMTECH_4222PCI335:
-		case PCI_DEVICE_ID_COMMTECH_4224PCI335:
-			writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
-			writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-			writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
-			break;
-		case PCI_DEVICE_ID_COMMTECH_2324PCI335:
-		case PCI_DEVICE_ID_COMMTECH_2328PCI335:
-			writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
-			writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
-			writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
-			break;
-		}
-		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
-		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
-	}
-	writeb(0x00, p + UART_EXAR_8XMODE);
-	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
-	writeb(32, p + UART_EXAR_TXTRG);
-	writeb(32, p + UART_EXAR_RXTRG);
-	iounmap(p);
-
-	return pci_default_setup(priv, board, port, idx);
-}
-
 static int
 pci_wch_ch353_setup(struct serial_private *priv,
 		    const struct pciserial_board *board,
@@ -2431,38 +2370,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_asix_setup,
 	},
 	/*
-	 * Commtech, Inc. Fastcom adapters
-	 *
-	 */
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_4222PCI335,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fastcom335_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_4224PCI335,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fastcom335_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_2324PCI335,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fastcom335_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_2328PCI335,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fastcom335_setup,
-	},
-	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
 	{
@@ -2573,10 +2480,6 @@ enum pci_board_num_t {
 
 	pbn_b0_4_1152000,
 
-	pbn_b0_2_1152000_200,
-	pbn_b0_4_1152000_200,
-	pbn_b0_8_1152000_200,
-
 	pbn_b0_4_1250000,
 
 	pbn_b0_2_1843200,
@@ -2780,27 +2683,6 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 8,
 	},
 
-	[pbn_b0_2_1152000_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 1152000,
-		.uart_offset	= 0x200,
-	},
-
-	[pbn_b0_4_1152000_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 4,
-		.base_baud	= 1152000,
-		.uart_offset	= 0x200,
-	},
-
-	[pbn_b0_8_1152000_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 1152000,
-		.uart_offset	= 0x200,
-	},
-
 	[pbn_b0_4_1250000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
@@ -3521,6 +3403,7 @@ static const struct pci_device_id blacklist[] = {
 
 	/* Exar devices */
 	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), },
+	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
 };
 
 /*
@@ -5248,26 +5131,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
 
-	/*
-	 * Commtech, Inc. Fastcom adapters
-	 */
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCI335,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_b0_2_1152000_200 },
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCI335,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_b0_4_1152000_200 },
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_2324PCI335,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_b0_4_1152000_200 },
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_2328PCI335,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_b0_8_1152000_200 },
-
 	/* Fintek PCI serial cards */
 	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
 	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
-- 
2.1.4
