From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 4/5] serial/8250_fintek: Support keys different than default
Date: Mon, 15 Jun 2015 17:14:37 +0200
Message-ID: <1434381278-15852-5-git-send-email-ricardo.ribalda@gmail.com>
References: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

Chip can be configured to use entry key different than 0x77. Try all the
valid keys until one gives out the right chip id.

Reported-by: Peter Hong <peter_hong@fintek.com.tw>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
v2: Comment by: Alan Cox <alan@linux.intel.com>
Add static const to stack variables
 drivers/tty/serial/8250/8250_fintek.c | 39 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index e0a361f8402d..07642e545451 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -19,7 +19,6 @@
 
 #define ADDR_PORT 0
 #define DATA_PORT 1
-#define ENTRY_KEY 0x77
 #define EXIT_KEY 0xAA
 #define CHIP_ID1  0x20
 #define CHIP_ID2  0x21
@@ -42,17 +41,18 @@
 struct fintek_8250 {
 	u16 base_port;
 	u8 index;
+	u8 key;
 	long line;
 };
 
-static int fintek_8250_enter_key(u16 base_port)
+static int fintek_8250_enter_key(u16 base_port, u8 key)
 {
 
 	if (!request_muxed_region(base_port, 2, DRIVER_NAME))
 		return -EBUSY;
 
-	outb(ENTRY_KEY, base_port + ADDR_PORT);
-	outb(ENTRY_KEY, base_port + ADDR_PORT);
+	outb(key, base_port + ADDR_PORT);
+	outb(key, base_port + ADDR_PORT);
 	return 0;
 }
 
@@ -134,7 +134,7 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	if (rs485->flags & SER_RS485_RTS_ON_SEND)
 		config |= RTS_INVERT;
 
-	if (fintek_8250_enter_key(pdata->base_port))
+	if (fintek_8250_enter_key(pdata->base_port, pdata->key))
 		return -EBUSY;
 
 	outb(LDN, pdata->base_port + ADDR_PORT);
@@ -148,20 +148,25 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static int fintek_8250_base_port(void)
+static int fintek_8250_base_port(u8 *key)
 {
 	static const u16 addr[] = {0x4e, 0x2e};
-	int i;
+	static const u16 keys[] = {0x77, 0xa0, 0x87, 0x67};
+	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
-		int ret;
-
-		if (fintek_8250_enter_key(addr[i]))
-			continue;
-		ret = fintek_8250_check_id(addr[i]);
-		fintek_8250_exit_key(addr[i]);
-		if (!ret)
-			return addr[i];
+		for (j = 0; j < ARRAY_SIZE(keys); j++) {
+			int ret;
+
+			if (fintek_8250_enter_key(addr[i], keys[j]))
+				continue;
+			ret = fintek_8250_check_id(addr[i]);
+			fintek_8250_exit_key(addr[i]);
+			if (!ret) {
+				*key = keys[j];
+				return addr[i];
+			}
+		}
 	}
 
 	return -ENODEV;
@@ -174,11 +179,12 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	struct fintek_8250 *pdata;
 	int index;
 	int base_port;
+	u8 key;
 
 	if (!pnp_port_valid(dev, 0))
 		return -ENODEV;
 
-	base_port = fintek_8250_base_port();
+	base_port = fintek_8250_base_port(&key);
 	if (base_port < 0)
 		return -ENODEV;
 
@@ -206,6 +212,7 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	uart.port.uartclk = 1843200;
 	uart.port.dev = &dev->dev;
 
+	pdata->key = key;
 	pdata->base_port = base_port;
 	pdata->index = index;
 	pdata->line = serial8250_register_8250_port(&uart);
-- 
2.1.4
