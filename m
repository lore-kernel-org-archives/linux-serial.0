From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 10/13] serial: earlycon: Show the earlycon "driver" in banner
Date: Wed,  8 Apr 2015 13:45:16 -0400
Message-ID: <1428515119-25248-11-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Output the earlycon "driver" from the just-parsed console 'name'
and 'index' fields.

NB: ->mapbase is a resource_size_t so use %pa format specifier
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 7c61581..9834afc 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -77,12 +77,14 @@ static void __init earlycon_init(struct earlycon_device *device,
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
2.3.5
