From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 09/12] serial: earlycon: Show the earlycon "driver" in banner
Date: Sat, 16 Jan 2016 15:23:46 -0800
Message-ID: <1452986629-17210-10-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Output the earlycon "driver" from the just-parsed console 'name'
and 'index' fields.

NB: ->mapbase is a resource_size_t so use %pa format specifier

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 36b79f1..067783f 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -76,16 +76,16 @@ static void __init earlycon_init(struct earlycon_device *device,
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
 	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
-		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
+		pr_info("%s%d at MMIO%s %pa (options '%s')\n",
+			earlycon->name, earlycon->index,
 			(port->iotype == UPIO_MEM) ? "" :
 			(port->iotype == UPIO_MEM16) ? "16" :
 			(port->iotype == UPIO_MEM32) ? "32" : "32be",
-			(unsigned long long)port->mapbase,
-			device->options);
+			&port->mapbase, device->options);
 	else
-		pr_info("Early serial console at I/O port 0x%lx (options '%s')\n",
-			port->iobase,
-			device->options);
+		pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
+			earlycon->name, earlycon->index,
+			port->iobase, device->options);
 }
 
 static int __init parse_options(struct earlycon_device *device, char *options)
-- 
2.7.0
