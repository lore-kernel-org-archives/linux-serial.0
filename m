From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 3/5] serial/8250_fintek: Support for chip_ip 0x0501
Date: Tue, 16 Jun 2015 10:59:38 +0200
Message-ID: <1434445180-32490-4-git-send-email-ricardo.ribalda@gmail.com>
References: <1434445180-32490-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434445180-32490-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

There are some chips with the same interface but different chip ip.

Reported-by: Peter Hong <peter_hong@fintek.com.tw>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 82b055b5a26d..2c3228e84a2e 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -22,9 +22,9 @@
 #define ENTRY_KEY 0x77
 #define EXIT_KEY 0xAA
 #define CHIP_ID1  0x20
-#define CHIP_ID1_VAL 0x02
 #define CHIP_ID2  0x21
-#define CHIP_ID2_VAL 0x16
+#define CHIP_ID_0 0x1602
+#define CHIP_ID_1 0x0501
 #define VENDOR_ID1 0x23
 #define VENDOR_ID1_VAL 0x19
 #define VENDOR_ID2 0x24
@@ -77,14 +77,7 @@ static int fintek_8250_get_index(resource_size_t base_addr)
 
 static int fintek_8250_check_id(u16 base_port)
 {
-
-	outb(CHIP_ID1, base_port + ADDR_PORT);
-	if (inb(base_port + DATA_PORT) != CHIP_ID1_VAL)
-		return -ENODEV;
-
-	outb(CHIP_ID2, base_port + ADDR_PORT);
-	if (inb(base_port + DATA_PORT) != CHIP_ID2_VAL)
-		return -ENODEV;
+	u16 chip;
 
 	outb(VENDOR_ID1, base_port + ADDR_PORT);
 	if (inb(base_port + DATA_PORT) != VENDOR_ID1_VAL)
@@ -94,6 +87,14 @@ static int fintek_8250_check_id(u16 base_port)
 	if (inb(base_port + DATA_PORT) != VENDOR_ID2_VAL)
 		return -ENODEV;
 
+	outb(CHIP_ID1, base_port + ADDR_PORT);
+	chip = inb(base_port + DATA_PORT);
+	outb(CHIP_ID2, base_port + ADDR_PORT);
+	chip |= inb(base_port + DATA_PORT) << 8;
+
+	if (chip != CHIP_ID_0 && chip != CHIP_ID_1)
+		return -ENODEV;
+
 	return 0;
 }
 
-- 
2.1.4
