From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 5/5] serial/8250_fintek: Support for any io address.
Date: Mon, 15 Jun 2015 17:14:38 +0200
Message-ID: <1434381278-15852-6-git-send-email-ricardo.ribalda@gmail.com>
References: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fintek chip can be configured for io addresses different than the standard.

Query the chip for the configured addresses and try to match it with the
pnp address.

Reported-by: Peter Hong <peter_hong@fintek.com.tw>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 51 ++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 07642e545451..8c1fd99dff83 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -28,6 +28,8 @@
 #define VENDOR_ID1_VAL 0x19
 #define VENDOR_ID2 0x24
 #define VENDOR_ID2_VAL 0x34
+#define IO_ADDR1 0x61
+#define IO_ADDR2 0x60
 #define LDN 0x7
 
 #define RS485  0xF0
@@ -63,18 +65,6 @@ static void fintek_8250_exit_key(u16 base_port)
 	release_region(base_port + ADDR_PORT, 2);
 }
 
-static int fintek_8250_get_index(resource_size_t base_addr)
-{
-	resource_size_t base[] = {0x3f8, 0x2f8, 0x3e8, 0x2e8};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(base); i++)
-		if (base_addr == base[i])
-			return i;
-
-	return -ENODEV;
-}
-
 static int fintek_8250_check_id(u16 base_port)
 {
 	u16 chip;
@@ -148,24 +138,41 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static int fintek_8250_base_port(u8 *key)
+static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
 {
 	static const u16 addr[] = {0x4e, 0x2e};
 	static const u16 keys[] = {0x77, 0xa0, 0x87, 0x67};
-	int i, j;
+	int i, j, k;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
 		for (j = 0; j < ARRAY_SIZE(keys); j++) {
-			int ret;
 
 			if (fintek_8250_enter_key(addr[i], keys[j]))
 				continue;
-			ret = fintek_8250_check_id(addr[i]);
-			fintek_8250_exit_key(addr[i]);
-			if (!ret) {
+			if (fintek_8250_check_id(addr[i])) {
+				fintek_8250_exit_key(addr[i]);
+				continue;
+			}
+
+			for (k = 0; k < 4; k++) {
+				u16 aux;
+
+				outb(LDN, addr[i] + ADDR_PORT);
+				outb(k, addr[i] + DATA_PORT);
+
+				outb(IO_ADDR1, addr[i] + ADDR_PORT);
+				aux = inb(addr[i] + DATA_PORT);
+				outb(IO_ADDR2, addr[i] + ADDR_PORT);
+				aux |= inb(addr[i] + DATA_PORT) << 8;
+				if (aux != io_address)
+					continue;
+
+				fintek_8250_exit_key(addr[i]);
 				*key = keys[j];
+				*index = k;
 				return addr[i];
 			}
+			fintek_8250_exit_key(addr[i]);
 		}
 	}
 
@@ -177,21 +184,17 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart;
 	struct fintek_8250 *pdata;
-	int index;
 	int base_port;
 	u8 key;
+	u8 index;
 
 	if (!pnp_port_valid(dev, 0))
 		return -ENODEV;
 
-	base_port = fintek_8250_base_port(&key);
+	base_port = fintek_8250_base_port(pnp_port_start(dev, 0), &key, &index);
 	if (base_port < 0)
 		return -ENODEV;
 
-	index = fintek_8250_get_index(pnp_port_start(dev, 0));
-	if (index < 0)
-		return -ENODEV;
-
 	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.1.4
