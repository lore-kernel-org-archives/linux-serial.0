From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: [PATCH] tty: Add support for PCIe WCH382 2S multi-IO card
Date: Tue,  2 Feb 2016 13:00:45 -0800
Message-ID: <1454446845-18739-2-git-send-email-jmcnicol@redhat.com>
References: <1454446845-18739-1-git-send-email-jmcnicol@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1454446845-18739-1-git-send-email-jmcnicol@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: devel@linuxdriverproject.org
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

WCH382 2S board is a PCIe card with 2 DB9 COM ports detected as
Serial controller: Device 1c00:3253 (rev 10) (prog-if 05 [16850])

Signed-off-by: Jeremy McNicoll <jmcnicol@redhat.com>
---
 drivers/tty/serial/8250/8250_pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e71ec78..7cd6f9a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1941,6 +1941,7 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCIE_VENDOR_ID_WCH		0x1c00
 #define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
 #define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
+#define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
 
 #define PCI_VENDOR_ID_PERICOM			0x12D8
 #define PCI_DEVICE_ID_PERICOM_PI7C9X7951	0x7951
@@ -2637,6 +2638,14 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch353_setup,
 	},
+	/* WCH CH382 2S card (16850 clone) */
+	{
+		.vendor         = PCIE_VENDOR_ID_WCH,
+		.device         = PCIE_DEVICE_ID_WCH_CH382_2S,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = pci_wch_ch38x_setup,
+	},
 	/* WCH CH382 2S1P card (16850 clone) */
 	{
 		.vendor         = PCIE_VENDOR_ID_WCH,
@@ -2955,6 +2964,7 @@ enum pci_board_num_t {
 	pbn_fintek_4,
 	pbn_fintek_8,
 	pbn_fintek_12,
+	pbn_wch382_2,
 	pbn_wch384_4,
 	pbn_pericom_PI7C9X7951,
 	pbn_pericom_PI7C9X7952,
@@ -3775,6 +3785,13 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 115200,
 		.first_offset	= 0x40,
 	},
+	[pbn_wch382_2] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+		.first_offset	= 0xC0,
+	},
 	[pbn_wch384_4] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
@@ -5574,6 +5591,10 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_2_115200 },
 
+	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH382_2S,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_wch382_2 },
+
 	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
-- 
2.6.1
