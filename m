From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH] tty/serial: fix 8250 early console option passing to regular console
Date: Thu, 12 Jun 2014 12:52:44 -0500
Message-ID: <1402595564-23755-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:50753 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaFLRxG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jun 2014 13:53:06 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so1710112obc.9
        for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2014 10:53:04 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

From: Rob Herring <robh@kernel.org>

In the conversion to generic early console, the passing of options from
the early 8250 console to the regular ttyS console was broken. This
resulted in the baud rate changing when switching consoles during boot.

This feature allows specifying a single console option on the kernel
command line rather than both an early console and regular serial tty
console. It would be nice to generalize this feature. However, it only
works if the correct baud rate can be probed early which is not the
case on many platforms which have non-standard UART clock rates. So for
now, this is left as an 8250 specific feature.

Reported-and-tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/8250/8250_early.c | 5 ++++-
 drivers/tty/serial/earlycon.c        | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index cfef801..4858b8a 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -144,8 +144,11 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 	if (!(device->port.membase || device->port.iobase))
 		return 0;
 
-	if (!device->baud)
+	if (!device->baud) {
 		device->baud = probe_baud(&device->port);
+		snprintf(device->options, sizeof(device->options), "%u",
+			 device->baud);
+	}
 
 	init_port(device);
 
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5131b5e..a514ee6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -25,7 +25,7 @@
 #include <asm/serial.h>
 
 static struct console early_con = {
-	.name =		"earlycon",
+	.name =		"uart", /* 8250 console switch requires this name */
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	-1,
 };
-- 
1.9.1

