From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/7] serial: exar: Fix initialization of EXAR registers for ports > 0
Date: Tue,  7 Feb 2017 17:09:59 +0100
Message-ID: <88bf3d9a18ee847e7bd181c95b490a70931fb6df.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

So far, pci_xr17v35x_setup always initialized 8XMODE, FCTR & Co. for
port 0 because it used the address of that port instead of moving the
pointer according to the port number. Fix this and remove the unneeded
temporary ioremap by moving default_setup up and reusing the membase it
fills into the port structure.

Fixes: 14faa8cce88e ("tty/8250 Add support for Commtech's Fastcom Async-335 and Fastcom Async-PCIe cards")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 58469d9..d3e3a7d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -157,27 +157,24 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	if (board->has_slave && idx >= 8)
 		port->port.uartclk /= 2;
 
-	p = pci_ioremap_bar(pcidev, 0);
-	if (!p)
-		return -ENOMEM;
+	ret = default_setup(priv, pcidev, idx, offset, port);
+	if (ret)
+		return ret;
 
-	/* Setup Multipurpose Input/Output pins. */
-	if (idx == 0)
-		setup_gpio(p);
+	p = port->port.membase;
 
 	writeb(0x00, p + UART_EXAR_8XMODE);
 	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
 	writeb(128, p + UART_EXAR_TXTRG);
 	writeb(128, p + UART_EXAR_RXTRG);
-	iounmap(p);
 
-	ret = default_setup(priv, pcidev, idx, offset, port);
-	if (ret)
-		return ret;
+	if (idx == 0) {
+		/* Setup Multipurpose Input/Output pins. */
+		setup_gpio(p);
 
-	if (idx == 0)
 		port->port.private_data =
 			xr17v35x_register_gpio(pcidev);
+	}
 
 	return 0;
 }
-- 
2.1.4
