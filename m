From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] serial:8250:8250_pci: fix redundant entry report for
 WCH_CH352_2S
Date: Sat, 7 Mar 2015 01:13:03 +0800
Message-ID: <20150306171303.GA2174@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: rmk@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit 8b5c913f7ee6464849570bacb6bcd9ef0eaf7dce
("serial: 8250_pci: Add WCH CH352 quirk to avoid Xscale detection")
trigger one redundant entry report message.

This patch fix it.

Reported-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index cf1cab1..eea4272 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5401,10 +5401,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_2_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH352_2S,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_bt_2_115200 },
-
 	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
-- 
2.2.2.dirty
