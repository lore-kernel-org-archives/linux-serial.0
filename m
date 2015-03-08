From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/2] serial: of: set port iomem size from devicetree
Date: Sun,  8 Mar 2015 14:30:05 +0000
Message-ID: <1425825005-7556-2-git-send-email-mans@mansr.com>
References: <1425825005-7556-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425825005-7556-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Make the 8250 driver reserve exactly the mmio region specified
in the devicetree. This prevents conflicts between UPIO_AU type
UARTs and other devices mapped closer than the default size of
0x1000 (or 0x100 for RT2880).

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/tty/serial/of_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 7ff61e2..b1d4744 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -89,6 +89,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	spin_lock_init(&port->lock);
 	port->mapbase = resource.start;
+	port->mapsize = resource_size(&resource);
 
 	/* Check for shifted address mapping */
 	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
-- 
2.3.1
