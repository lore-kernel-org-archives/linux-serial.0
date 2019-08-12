From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: [PATCH] serial: 8250_pci: Implement MSI(-X) support
Date: Mon, 12 Aug 2019 13:21:52 +0200
Message-ID: <20190812112152.693622-1-ralf.ramsauer@oth-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <jailhouse-dev+bncBD4JZQXE5UFRBVUXYXVAKGQEOZ4OGMI@googlegroups.com>
Sender: jailhouse-dev@googlegroups.com
List-Post: <https://groups.google.com/group/jailhouse-dev/post>, <mailto:jailhouse-dev@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:jailhouse-dev+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/jailhouse-dev
List-Subscribe: <https://groups.google.com/group/jailhouse-dev/subscribe>, <mailto:jailhouse-dev+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+175645748590+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/jailhouse-dev/subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, jailhouse-dev@googlegroups.com
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, Jay Dolan <jay.dolan@accesio.com>
List-Id: linux-serial@vger.kernel.org

There may be setups, where legacy interrupts are not available. This is
the caese, e.g., when Linux runs as guest (aka. non-root cell) of the
partitioning hypervisor Jailhouse. There, only MSI(-X) interrupts are
available for guests.

But the 8250_pci driver currently only supports legacy ints. So let's
enable MSI(-X) interrupts.

Nevertheless, this needs to handled with care: while many 8250 devices
actually claim to support MSI(-X) interrupts it should not be enabled be
default. I had at least one device in my hands with broken MSI
implementation.

So better introduce a whitelist with devices that are known to support
MSI(-X) interrupts. I tested all devices mentioned in the patch.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 drivers/tty/serial/8250/8250_pci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index bbe5cba21522..97992884c0ee 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -53,6 +53,16 @@ struct serial_private {
 	int			line[0];
 };
 
+static const struct pci_device_id pci_use_msi[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
+			 0xA000, 0x1000) },
+	{ }
+};
+
 static int pci_default_setup(struct serial_private*,
 	  const struct pciserial_board*, struct uart_8250_port *, int);
 
@@ -3643,7 +3653,22 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	memset(&uart, 0, sizeof(uart));
 	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 	uart.port.uartclk = board->base_baud * 16;
-	uart.port.irq = get_pci_irq(dev, board);
+
+	if (pci_match_id(pci_use_msi, dev)) {
+		dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
+		pci_set_master(dev);
+		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
+	} else {
+		dev_dbg(&dev->dev, "Using legacy interrupts\n");
+		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+	}
+	if (rc < 0) {
+		kfree(priv);
+		priv = ERR_PTR(rc);
+		goto err_deinit;
+	}
+
+	uart.port.irq = pci_irq_vector(dev, 0);
 	uart.port.dev = &dev->dev;
 
 	for (i = 0; i < nr_ports; i++) {
-- 
2.22.0
