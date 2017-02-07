From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/7] serial: pci: Remove unused pci_boards entries
Date: Tue,  7 Feb 2017 17:10:02 +0100
Message-ID: <96716a0622414661a9f678b3dfb49dea393ddb14.1486483804.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Became obsolete with the split-out of 8250_exar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_pci.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 50cd1cf..d365a57 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2498,10 +2498,6 @@ enum pci_board_num_t {
 	pbn_b0_2_1843200,
 	pbn_b0_4_1843200,
 
-	pbn_b0_2_1843200_200,
-	pbn_b0_4_1843200_200,
-	pbn_b0_8_1843200_200,
-
 	pbn_b0_1_4000000,
 
 	pbn_b0_bt_1_115200,
@@ -2716,24 +2712,6 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 8,
 	},
 
-	[pbn_b0_2_1843200_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 1843200,
-		.uart_offset	= 0x200,
-	},
-	[pbn_b0_4_1843200_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 4,
-		.base_baud	= 1843200,
-		.uart_offset	= 0x200,
-	},
-	[pbn_b0_8_1843200_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 1843200,
-		.uart_offset	= 0x200,
-	},
 	[pbn_b0_1_4000000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-- 
2.1.4
