From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] serial:8250:8250_pci: delete unneeded quirk entries
Date: Sat, 7 Mar 2015 01:08:35 +0800
Message-ID: <20150306170835.GA1990@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pure.logic@nexus-software.ie
List-Id: linux-serial@vger.kernel.org

These quirk entries have the same effect as default
quirk entry, so we can just delete them.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index daf2c82..cf1cab1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1989,13 +1989,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_QRK_UART,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_BSW_UART1,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
@@ -2201,13 +2194,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	 */
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
-		.device		= PCI_DEVICE_ID_PLX_9030,
-		.subvendor	= PCI_SUBVENDOR_ID_PERLE,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_default_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_PLX,
 		.device		= PCI_DEVICE_ID_PLX_9050,
 		.subvendor	= PCI_SUBVENDOR_ID_EXSYS,
 		.subdevice	= PCI_SUBDEVICE_ID_EXSYS_4055,
-- 
2.2.2.dirty
