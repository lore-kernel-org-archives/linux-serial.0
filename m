From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 08/12] serial: earlycon: Id the earlycon "driver" in banner
Date: Wed,  4 Mar 2015 12:24:27 -0500
Message-ID: <1425489871-22415-9-git-send-email-peter@hurleysoftware.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Output the earlycon "driver" from the just-parsed console ::name
and ::index fields.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 522ceb8..3c8fe4e 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -85,12 +85,14 @@ static void __init earlycon_init(struct earlycon_device *device,
 	earlycon->data = &early_console_dev;
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
-		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
+		pr_info("%s%d at MMIO%s 0x%llx (options '%s')\n",
+			earlycon->name, earlycon->index,
 			(port->iotype == UPIO_MEM32) ? "32" : "",
 			(unsigned long long)port->mapbase,
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
