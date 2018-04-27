From: John Garry <john.garry@huawei.com>
Subject: [PATCH v2] serial: 8250_of: Add IO space support
Date: Fri, 27 Apr 2018 18:36:06 +0800
Message-ID: <1524825366-155559-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au, p.zabel@pengutronix.de, arnd@arndb.de, fcooper@ti.com, sergei.shtylyov@cogentembedded.com, yamada.masahiro@socionext.com, khoroshilov@ispras.ru
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linuxarm@huawei.com, John Garry <john.garry@huawei.com>
List-Id: linux-serial@vger.kernel.org

Currently the 8250_of driver only supports MEM IO type
accesses.

Some development boards (Huawei D03, specifically) require
IO space access for 8250-compatible OF driver support, so
add it.

The modification is quite simple: just set the port iotype
and associated flags depending on the device address
resource type.

Signed-off-by: John Garry <john.garry@huawei.com>
---

Changes v1->v2:
- rebase to Greg's tty-testing branch
- use resource_type() helper

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 3de8d6a..bfb37f0 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -92,13 +92,43 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto err_unprepare;
 	}
 
+	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
+				  UPF_FIXED_TYPE;
 	spin_lock_init(&port->lock);
-	port->mapbase = resource.start;
-	port->mapsize = resource_size(&resource);
 
-	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
-		port->mapbase += prop;
+	if (resource_type(&resource) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;
+		port->iobase = resource.start;
+	} else {
+		port->mapbase = resource.start;
+		port->mapsize = resource_size(&resource);
+
+		/* Check for shifted address mapping */
+		if (of_property_read_u32(np, "reg-offset", &prop) == 0)
+			port->mapbase += prop;
+
+		port->iotype = UPIO_MEM;
+		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
+			switch (prop) {
+			case 1:
+				port->iotype = UPIO_MEM;
+				break;
+			case 2:
+				port->iotype = UPIO_MEM16;
+				break;
+			case 4:
+				port->iotype = of_device_is_big_endian(np) ?
+					       UPIO_MEM32BE : UPIO_MEM32;
+				break;
+			default:
+				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
+					 prop);
+				ret = -EINVAL;
+				goto err_dispose;
+			}
+		}
+		port->flags |= UPF_IOREMAP;
+	}
 
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
@@ -114,26 +144,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->line = ret;
 
 	port->irq = irq_of_parse_and_map(np, 0);
-	port->iotype = UPIO_MEM;
-	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-		switch (prop) {
-		case 1:
-			port->iotype = UPIO_MEM;
-			break;
-		case 2:
-			port->iotype = UPIO_MEM16;
-			break;
-		case 4:
-			port->iotype = of_device_is_big_endian(np) ?
-				       UPIO_MEM32BE : UPIO_MEM32;
-			break;
-		default:
-			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
-				 prop);
-			ret = -EINVAL;
-			goto err_dispose;
-		}
-	}
 
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
@@ -147,8 +157,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->type = type;
 	port->uartclk = clk;
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	port->irqflags |= IRQF_SHARED;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
-- 
1.9.1
