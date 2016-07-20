From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [RFC 2/3] misc: pch_phub: Add UART_CLK quirk for Boston platform
Date: Wed, 20 Jul 2016 18:21:16 +0100
Message-ID: <1469035277-40919-3-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1469035277-40919-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469035277-40919-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-serial@vger.kernel.org

The EG20T has 4 UART blocks. The clock source for the UART block is
configured to receive a clock from an external pin by default.

An internal 25MHz clock in the EG20T can also be used as a clock source
for the clock.

The MIPS based Boston platform ties the external clock pin down and relies
on the internal clock source for the UART to function.

Boston is based on device tree.

Add a quirk to allow Boston to be detected via device tree and set the
correct clock source for UART.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 drivers/misc/pch_phub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 9b010a7..b7eddc9 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -57,6 +57,7 @@
 
 /* CM-iTC */
 #define CLKCFG_UART_48MHZ			(1 << 16)
+#define CLKCFG_UART_25MHZ			(2 << 16)
 #define CLKCFG_BAUDDIV				(2 << 20)
 #define CLKCFG_PLL2VCO				(8 << 9)
 #define CLKCFG_UARTCLKSEL			(1 << 18)
@@ -747,6 +748,16 @@ static int pch_phub_probe(struct pci_dev *pdev,
 		iowrite32(0x25, chip->pch_phub_base_address + 0x44);
 		chip->pch_opt_rom_start_address = PCH_PHUB_ROM_START_ADDR_EG20T;
 		chip->pch_mac_start_address = PCH_PHUB_MAC_START_ADDR_EG20T;
+
+		/* quirk for MIPS Boston platform */
+		if (pdev->dev.of_node) {
+			if (of_machine_is_compatible("img,boston")) {
+				pch_phub_read_modify_write_reg(chip,
+					(unsigned int)CLKCFG_REG_OFFSET,
+					CLKCFG_UART_25MHZ,
+					CLKCFG_UART_MASK);
+			}
+		}
 	} else if (id->driver_data == 2) { /* ML7213 IOH */
 		ret = sysfs_create_bin_file(&pdev->dev.kobj, &pch_bin_attr);
 		if (ret)
-- 
1.9.1
