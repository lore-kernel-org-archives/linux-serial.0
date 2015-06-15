From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 2/5] serial/8250_fintek: Support for multiple base_ports
Date: Mon, 15 Jun 2015 17:14:35 +0200
Message-ID: <1434381278-15852-3-git-send-email-ricardo.ribalda@gmail.com>
References: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fintek chip can be connected at address 0x4e and also 0x2e.
Add some logic to find out the address of the chip.

Reported-by: Peter Hong <peter_hong@fintek.com.tw>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
v2: Comment by: Alan Cox <alan@linux.intel.com>
Add static const to stack variables

 drivers/tty/serial/8250/8250_fintek.c | 87 +++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index c7f1485e6a54..256b5ece7dbd 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -17,8 +17,8 @@
 #include <linux/serial_core.h>
 #include  "8250.h"
 
-#define ADDR_PORT 0x4E
-#define DATA_PORT 0x4F
+#define ADDR_PORT 0
+#define DATA_PORT 1
 #define ENTRY_KEY 0x77
 #define EXIT_KEY 0xAA
 #define CHIP_ID1  0x20
@@ -40,24 +40,27 @@
 #define DRIVER_NAME "8250_fintek"
 
 struct fintek_8250 {
+	u16 base_port;
 	u8 index;
 	long line;
 };
 
-static int fintek_8250_enter_key(void){
+static int fintek_8250_enter_key(u16 base_port)
+{
 
-	if (!request_muxed_region(ADDR_PORT, 2, DRIVER_NAME))
+	if (!request_muxed_region(base_port, 2, DRIVER_NAME))
 		return -EBUSY;
 
-	outb(ENTRY_KEY, ADDR_PORT);
-	outb(ENTRY_KEY, ADDR_PORT);
+	outb(ENTRY_KEY, base_port + ADDR_PORT);
+	outb(ENTRY_KEY, base_port + ADDR_PORT);
 	return 0;
 }
 
-static void fintek_8250_exit_key(void){
+static void fintek_8250_exit_key(u16 base_port)
+{
 
-	outb(EXIT_KEY, ADDR_PORT);
-	release_region(ADDR_PORT, 2);
+	outb(EXIT_KEY, base_port + ADDR_PORT);
+	release_region(base_port + ADDR_PORT, 2);
 }
 
 static int fintek_8250_get_index(resource_size_t base_addr)
@@ -72,23 +75,23 @@ static int fintek_8250_get_index(resource_size_t base_addr)
 	return -ENODEV;
 }
 
-static int fintek_8250_check_id(void)
+static int fintek_8250_check_id(u16 base_port)
 {
 
-	outb(CHIP_ID1, ADDR_PORT);
-	if (inb(DATA_PORT) != CHIP_ID1_VAL)
+	outb(CHIP_ID1, base_port + ADDR_PORT);
+	if (inb(base_port + DATA_PORT) != CHIP_ID1_VAL)
 		return -ENODEV;
 
-	outb(CHIP_ID2, ADDR_PORT);
-	if (inb(DATA_PORT) != CHIP_ID2_VAL)
+	outb(CHIP_ID2, base_port + ADDR_PORT);
+	if (inb(base_port + DATA_PORT) != CHIP_ID2_VAL)
 		return -ENODEV;
 
-	outb(VENDOR_ID1, ADDR_PORT);
-	if (inb(DATA_PORT) != VENDOR_ID1_VAL)
+	outb(VENDOR_ID1, base_port + ADDR_PORT);
+	if (inb(base_port + DATA_PORT) != VENDOR_ID1_VAL)
 		return -ENODEV;
 
-	outb(VENDOR_ID2, ADDR_PORT);
-	if (inb(DATA_PORT) != VENDOR_ID2_VAL)
+	outb(VENDOR_ID2, base_port + ADDR_PORT);
+	if (inb(base_port + DATA_PORT) != VENDOR_ID2_VAL)
 		return -ENODEV;
 
 	return 0;
@@ -130,45 +133,58 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	if (rs485->flags & SER_RS485_RTS_ON_SEND)
 		config |= RTS_INVERT;
 
-	if (fintek_8250_enter_key())
+	if (fintek_8250_enter_key(pdata->base_port))
 		return -EBUSY;
 
-	outb(LDN, ADDR_PORT);
-	outb(pdata->index, DATA_PORT);
-	outb(RS485, ADDR_PORT);
-	outb(config, DATA_PORT);
-	fintek_8250_exit_key();
+	outb(LDN, pdata->base_port + ADDR_PORT);
+	outb(pdata->index, pdata->base_port + DATA_PORT);
+	outb(RS485, pdata->base_port + ADDR_PORT);
+	outb(config, pdata->base_port + DATA_PORT);
+	fintek_8250_exit_key(pdata->base_port);
 
 	port->rs485 = *rs485;
 
 	return 0;
 }
 
+static int fintek_8250_base_port(void)
+{
+	static const u16 addr[] = {0x4e, 0x2e};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(addr); i++) {
+		int ret;
+
+		if (fintek_8250_enter_key(addr[i]))
+			continue;
+		ret = fintek_8250_check_id(addr[i]);
+		fintek_8250_exit_key(addr[i]);
+		if (!ret)
+			return addr[i];
+	}
+
+	return -ENODEV;
+}
+
 static int
 fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart;
 	struct fintek_8250 *pdata;
-	int ret;
 	int index;
+	int base_port;
 
 	if (!pnp_port_valid(dev, 0))
 		return -ENODEV;
 
+	base_port = fintek_8250_base_port();
+	if (base_port < 0)
+		return -ENODEV;
+
 	index = fintek_8250_get_index(pnp_port_start(dev, 0));
 	if (index < 0)
 		return -ENODEV;
 
-	/* Enable configuration registers*/
-	if (fintek_8250_enter_key())
-		return -EBUSY;
-
-	/*Check ID*/
-	ret = fintek_8250_check_id();
-	fintek_8250_exit_key();
-	if (ret)
-		return ret;
-
 	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -189,6 +205,7 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	uart.port.uartclk = 1843200;
 	uart.port.dev = &dev->dev;
 
+	pdata->base_port = base_port;
 	pdata->index = index;
 	pdata->line = serial8250_register_8250_port(&uart);
 	if (pdata->line < 0)
-- 
2.1.4
