From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] serial: 8250_pci: Use symbolic constants for EXAR's MPIO
 registers
Date: Mon, 19 Sep 2016 06:56:59 +0200
Message-ID: <b74822c2-0bb0-1238-b266-31052b6acfc7@siemens.com>
References: <8a6646ac-2ba7-cc1b-b547-776fb263ccdd@siemens.com>
 <20160726201420.GA19389@kroah.com>
 <055cacef-1ab0-0541-030d-d2313763cb2e@siemens.com>
 <20160831135839.GB13298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831135839.GB13298@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Less magic that only requires comments.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - move new constants from uapi header into driver

 drivers/tty/serial/8250/8250_pci.c | 55 +++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c1d4a8f..eff6c2f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1754,6 +1754,19 @@ static int pci_eg20t_init(struct pci_dev *dev)
 #define PCI_DEVICE_ID_EXAR_XR17V4358	0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358	0x8358
 
+#define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
+#define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
+#define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
+#define UART_EXAR_MPIOINV_7_0	0x92	/* MPIOINV[7:0] */
+#define UART_EXAR_MPIOSEL_7_0	0x93	/* MPIOSEL[7:0] */
+#define UART_EXAR_MPIOOD_7_0	0x94	/* MPIOOD[7:0] */
+#define UART_EXAR_MPIOINT_15_8	0x95	/* MPIOINT[15:8] */
+#define UART_EXAR_MPIOLVL_15_8	0x96	/* MPIOLVL[15:8] */
+#define UART_EXAR_MPIO3T_15_8	0x97	/* MPIO3T[15:8] */
+#define UART_EXAR_MPIOINV_15_8	0x98	/* MPIOINV[15:8] */
+#define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
+#define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
+
 static int
 pci_xr17c154_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
@@ -1796,18 +1809,18 @@ pci_xr17v35x_setup(struct serial_private *priv,
 	 * Setup Multipurpose Input/Output pins.
 	 */
 	if (idx == 0) {
-		writeb(0x00, p + 0x8f); /*MPIOINT[7:0]*/
-		writeb(0x00, p + 0x90); /*MPIOLVL[7:0]*/
-		writeb(0x00, p + 0x91); /*MPIO3T[7:0]*/
-		writeb(0x00, p + 0x92); /*MPIOINV[7:0]*/
-		writeb(0x00, p + 0x93); /*MPIOSEL[7:0]*/
-		writeb(0x00, p + 0x94); /*MPIOOD[7:0]*/
-		writeb(0x00, p + 0x95); /*MPIOINT[15:8]*/
-		writeb(0x00, p + 0x96); /*MPIOLVL[15:8]*/
-		writeb(0x00, p + 0x97); /*MPIO3T[15:8]*/
-		writeb(0x00, p + 0x98); /*MPIOINV[15:8]*/
-		writeb(0x00, p + 0x99); /*MPIOSEL[15:8]*/
-		writeb(0x00, p + 0x9a); /*MPIOOD[15:8]*/
+		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
+		writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
 	}
 	writeb(0x00, p + UART_EXAR_8XMODE);
 	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
@@ -1843,20 +1856,20 @@ pci_fastcom335_setup(struct serial_private *priv,
 		switch (priv->dev->device) {
 		case PCI_DEVICE_ID_COMMTECH_4222PCI335:
 		case PCI_DEVICE_ID_COMMTECH_4224PCI335:
-			writeb(0x78, p + 0x90); /* MPIOLVL[7:0] */
-			writeb(0x00, p + 0x92); /* MPIOINV[7:0] */
-			writeb(0x00, p + 0x93); /* MPIOSEL[7:0] */
+			writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
+			writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+			writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
 			break;
 		case PCI_DEVICE_ID_COMMTECH_2324PCI335:
 		case PCI_DEVICE_ID_COMMTECH_2328PCI335:
-			writeb(0x00, p + 0x90); /* MPIOLVL[7:0] */
-			writeb(0xc0, p + 0x92); /* MPIOINV[7:0] */
-			writeb(0xc0, p + 0x93); /* MPIOSEL[7:0] */
+			writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+			writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
+			writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
 			break;
 		}
-		writeb(0x00, p + 0x8f); /* MPIOINT[7:0] */
-		writeb(0x00, p + 0x91); /* MPIO3T[7:0] */
-		writeb(0x00, p + 0x94); /* MPIOOD[7:0] */
+		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 	}
 	writeb(0x00, p + UART_EXAR_8XMODE);
 	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
-- 
2.1.4
