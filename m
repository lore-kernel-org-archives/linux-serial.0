From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] tty: serial: 8250: 8250_gsc:- Handle return NULL error from ioremap_nocache
Date: Thu, 19 Jan 2017 13:30:44 +0530
Message-ID: <1484812844-10598-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jejb@parisc-linux.org, deller@gmx.de, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Here, If ioremap_nocache will fail. It will return NULL.
Kernel can run into a NULL-pointer dereference.
This error check will avoid NULL pointer dereference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/8250/8250_gsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_gsc.c b/drivers/tty/serial/8250/8250_gsc.c
index b1e6ae9..63306de 100644
--- a/drivers/tty/serial/8250/8250_gsc.c
+++ b/drivers/tty/serial/8250/8250_gsc.c
@@ -60,6 +60,10 @@ static int __init serial_init_chip(struct parisc_device *dev)
 					7272727 : 1843200;
 	uart.port.mapbase	= address;
 	uart.port.membase	= ioremap_nocache(address, 16);
+	if (!uart.port.membase) {
+		dev_warn(&dev->dev, "Failed to map memory\n");
+		return -ENOMEM;
+	}
 	uart.port.irq	= dev->irq;
 	uart.port.flags	= UPF_BOOT_AUTOCONF;
 	uart.port.dev	= &dev->dev;
-- 
1.9.1
