From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [Patch v2 1/3] misc: pch_phub: Read prefetch value from device tree if passed
Date: Fri, 12 Aug 2016 12:48:52 +0100
Message-ID: <1471002534-10673-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1471002534-10673-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471002534-10673-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-serial@vger.kernel.org

The default prefetch value for the eg20t device is hard coded to
0x000affaa.

Add support for an alternative to be read from DT if available

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V1 -> V2
added #include <linux/of.h>
---
 drivers/misc/pch_phub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 4810e03..1dd18f5 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <linux/ctype.h>
 #include <linux/dmi.h>
+#include <linux/of.h>
 
 #define PHUB_STATUS 0x00		/* Status Register offset */
 #define PHUB_CONTROL 0x04		/* Control Register offset */
@@ -711,6 +712,12 @@ static int pch_phub_probe(struct pci_dev *pdev,
 
 	if (id->driver_data == 1) { /* EG20T PCH */
 		const char *board_name;
+		unsigned int prefetch = 0x000affaa;
+
+		if (pdev->dev.of_node)
+			of_property_read_u32(pdev->dev.of_node,
+						  "intel,eg20t-prefetch",
+						  &prefetch);
 
 		ret = sysfs_create_file(&pdev->dev.kobj,
 					&dev_attr_pch_mac.attr);
@@ -736,7 +743,7 @@ static int pch_phub_probe(struct pci_dev *pdev,
 						CLKCFG_UART_MASK);
 
 		/* set the prefech value */
-		iowrite32(0x000affaa, chip->pch_phub_base_address + 0x14);
+		iowrite32(prefetch, chip->pch_phub_base_address + 0x14);
 		/* set the interrupt delay value */
 		iowrite32(0x25, chip->pch_phub_base_address + 0x44);
 		chip->pch_opt_rom_start_address = PCH_PHUB_ROM_START_ADDR_EG20T;
-- 
1.9.1
