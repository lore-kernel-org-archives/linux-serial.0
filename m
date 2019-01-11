From: Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH v2] 8250_pci.c: Only check for communication class in serial_pci_guess_board
Date: Fri, 11 Jan 2019 16:41:00 +0800
Message-ID: <1547196060-96495-1-git-send-email-guan.yung.tseng@ni.com>
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
Changes in v2:
  - Remain the serial_pci_is_class_communication
  - Call the serial_pci_is_class_communication in serial_pci_guess_board
    function.

 drivers/tty/serial/8250/8250_pci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4986b4a..2ca0694 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3424,8 +3424,11 @@ static int serial_pci_is_blacklisted(struct pci_dev *dev)
 static int
 serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
-	int num_iomem, num_port, first_port = -1, i;
+	int num_iomem, num_port, first_port = -1, i, rc;
 
+	rc = serial_pci_is_class_communication(dev);
+	if (rc)
+		return rc;
 	/*
 	 * Should we try to make guesses for multiport serial devices later?
 	 */
@@ -3652,10 +3655,6 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 
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
