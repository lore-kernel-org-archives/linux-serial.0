From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH] serial: 8250_fintek: Add resource check for Fintek F81504/508/512
Date: Fri, 23 Dec 2016 09:41:20 +0800
Message-ID: <1482457280-2135-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, heikki.krogerus@linux.intel.com, jdamon@accesio.com, jan.kiszka@siemens.com, buttiangelo@gmail.com, mika.westerberg@linux.intel.com, JBeulich@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Add resource type check for Fintek F81504/508/512, BAR3/4/5 must be
IORESOURCE_IO.

Fintek is trying to make F81504/508/512 works on MMIO interface, but
it's still in progress. We found some issue when the experiment IC
when the BAR3/4/5 is IORESOURCE_MEM. It'll cause wrong operation with
IO resource. So we'll add the resource check for this.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index aa0166b..29198b9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1477,11 +1477,16 @@ static int pci_fintek_init(struct pci_dev *dev)
 {
 	unsigned long iobase;
 	u32 max_port, i;
-	u32 bar_data[3];
+	resource_size_t bar_data[3];
 	u8 config_base;
 	struct serial_private *priv = pci_get_drvdata(dev);
 	struct uart_8250_port *port;
 
+	if (!(pci_resource_flags(dev, 5) & IORESOURCE_IO) ||
+			!(pci_resource_flags(dev, 4) & IORESOURCE_IO) ||
+			!(pci_resource_flags(dev, 3) & IORESOURCE_IO))
+		return -ENODEV;
+
 	switch (dev->device) {
 	case 0x1104: /* 4 ports */
 	case 0x1108: /* 8 ports */
@@ -1495,9 +1500,9 @@ static int pci_fintek_init(struct pci_dev *dev)
 	}
 
 	/* Get the io address dispatch from the BIOS */
-	pci_read_config_dword(dev, 0x24, &bar_data[0]);
-	pci_read_config_dword(dev, 0x20, &bar_data[1]);
-	pci_read_config_dword(dev, 0x1c, &bar_data[2]);
+	bar_data[0] = pci_resource_start(dev, 5);
+	bar_data[1] = pci_resource_start(dev, 4);
+	bar_data[2] = pci_resource_start(dev, 3);
 
 	for (i = 0; i < max_port; ++i) {
 		/* UART0 configuration offset start from 0x40 */
-- 
1.9.1
