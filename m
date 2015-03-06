From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 10/14] serial: earlycon: Show the earlycon "driver" in banner
Date: Fri,  6 Mar 2015 14:25:26 -0500
Message-ID: <1425669930-22137-11-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Output the earlycon "driver" from the just-parsed console ::name
and ::index fields.

NB: ->mapbase is a resource_size_t so use %pa format specifier
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 680ff4a..0d93c36 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -85,12 +85,14 @@ static void __init earlycon_init(struct earlycon_device *device,
 	earlycon->data = &early_console_dev;
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
-		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
+		pr_info("%s%d at MMIO%s %pa (options '%s')\n",
+			earlycon->name, earlycon->index,
 			(port->iotype == UPIO_MEM32) ? "32" : "",
-			(unsigned long long)port->mapbase,
+			&port->mapbase,
 			device->options);
 	else
-		pr_info("Early serial console at I/O port 0x%lx (options '%s')\n",
+		pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
+			earlycon->name, earlycon->index,
 			port->iobase,
 			device->options);
 }
-- 
2.3.1
