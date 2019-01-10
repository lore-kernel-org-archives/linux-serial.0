From: Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH] 8250_pci.c: Only check for communication class in serial_pci_guess_board
Date: Thu, 10 Jan 2019 16:12:12 +0800
Message-ID: <1547107932-3714-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guan Yung Tseng <guan.yung.tseng@ni.com>
List-Id: linux-serial@vger.kernel.org

Some multiport serial cards, such as the NI PXI-8430/2, NI PXI-8430/8,
and NI PXI-8432/4 use PCI_CLASS_COMMUNICATION_OTHER and this fail the
serial_pci_is_class_communication test added in the commit 7d8905d06405
("serial: 8250_pci: Enable device after we check black list").

Since these devices are correctly listed in serial_pci_tbl, we
shouldn't need to check the PCI class IDs. This change relocates the
class checking solely into "serial_pci_guess_board" where it had been
before so that the class-check doesn't hinder initialization.

Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
---
 drivers/tty/serial/8250/8250_pci.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4986b4a..e33a869 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3382,21 +3382,6 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
 };
 
-static int serial_pci_is_class_communication(struct pci_dev *dev)
-{
-	/*
-	 * If it is not a communications device or the programming
-	 * interface is greater than 6, give up.
-	 */
-	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
-	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MULTISERIAL) &&
-	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
-	    (dev->class & 0xff) > 6)
-		return -ENODEV;
-
-	return 0;
-}
-
 static int serial_pci_is_blacklisted(struct pci_dev *dev)
 {
 	const struct pci_device_id *bldev;
@@ -3427,6 +3412,15 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 	int num_iomem, num_port, first_port = -1, i;
 
 	/*
+	 * If it is not a communications device or the programming
+	 * interface is greater than 6, give up.
+	 *
+	 */
+	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
+	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
+	    (dev->class & 0xff) > 6)
+		return -ENODEV;
+	/*
 	 * Should we try to make guesses for multiport serial devices later?
 	 */
 	if ((dev->class >> 8) == PCI_CLASS_COMMUNICATION_MULTISERIAL)
@@ -3652,10 +3646,6 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 
 	board = &pci_boards[ent->driver_data];
 
-	rc = serial_pci_is_class_communication(dev);
-	if (rc)
-		return rc;
-
 	rc = serial_pci_is_blacklisted(dev);
 	if (rc)
 		return rc;
-- 
2.7.4
