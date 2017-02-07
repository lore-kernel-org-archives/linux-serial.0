From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7/7] serial: exar: Enable MSI support
Date: Tue,  7 Feb 2017 17:10:04 +0100
Message-ID: <36c56cfae9e213661612327bef79729f5e25b481.1486483804.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Use pci_alloc_irq_vectors to enable MSI when available. At least the
XR17V352 supports this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 13cc1da..236de60 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -284,10 +284,16 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 
 	priv->board = board;
 
+	pci_set_master(pcidev);
+
+	rc = pci_alloc_irq_vectors(pcidev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (rc < 0)
+		return rc;
+
 	memset(&uart, 0, sizeof(uart));
 	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ
 			  | UPF_EXAR_EFR;
-	uart.port.irq = pcidev->irq;
+	uart.port.irq = pci_irq_vector(pcidev, 0);
 	uart.port.dev = &pcidev->dev;
 
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
-- 
2.1.4
