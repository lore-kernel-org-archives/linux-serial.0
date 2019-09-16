From: Denis Efremov <efremov@linux.com>
Subject: [PATCH v3 21/26] serial: 8250_pci: Use PCI_STD_NUM_BARS
Date: Mon, 16 Sep 2019 23:41:53 +0300
Message-ID: <20190916204158.6889-22-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Remove local definition PCI_NUM_BAR_RESOURCES for the number of PCI BARs
and use global one PCI_STD_NUM_BARS instead.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/tty/serial/8250/8250_pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7f740b37700b..e557605ec75f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -43,8 +43,6 @@ struct pci_serial_quirk {
 	void	(*exit)(struct pci_dev *dev);
 };
 
-#define PCI_NUM_BAR_RESOURCES	6
-
 struct serial_private {
 	struct pci_dev		*dev;
 	unsigned int		nr;
@@ -74,7 +72,7 @@ setup_port(struct serial_private *priv, struct uart_8250_port *port,
 {
 	struct pci_dev *dev = priv->dev;
 
-	if (bar >= PCI_NUM_BAR_RESOURCES)
+	if (bar >= PCI_STD_NUM_BARS)
 		return -EINVAL;
 
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
@@ -3583,7 +3581,7 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 		return -ENODEV;
 
 	num_iomem = num_port = 0;
-	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
 			num_port++;
 			if (first_port == -1)
@@ -3611,7 +3609,7 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 	 */
 	first_port = -1;
 	num_port = 0;
-	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO &&
 		    pci_resource_len(dev, i) == 8 &&
 		    (first_port == -1 || (first_port + num_port) == i)) {
-- 
2.21.0
