From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 09/13] serial: earlycon: Common log banner for command line and DT
Date: Wed,  8 Apr 2015 13:45:15 -0400
Message-ID: <1428515119-25248-10-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Refactor the command line earlycon banner into earlycon_init() so
both earlycon startup methods output an info banner.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 0d8f187..7c61581 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -61,6 +61,7 @@ static void __init earlycon_init(struct earlycon_device *device,
 				 const char *name)
 {
 	struct console *earlycon = device->con;
+	struct uart_port *port = &device->port;
 	const char *s;
 	size_t len;
 
@@ -74,6 +75,16 @@ static void __init earlycon_init(struct earlycon_device *device,
 	len = s - name;
 	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
 	earlycon->data = &early_console_dev;
+
+	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
+		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
+			(port->iotype == UPIO_MEM32) ? "32" : "",
+			(unsigned long long)port->mapbase,
+			device->options);
+	else
+		pr_info("Early serial console at I/O port 0x%lx (options '%s')\n",
+			port->iobase,
+			device->options);
 }
 
 static int __init parse_options(struct earlycon_device *device, char *options)
@@ -105,16 +116,6 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 		strlcpy(device->options, options, length);
 	}
 
-	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
-		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
-			(port->iotype == UPIO_MEM32) ? "32" : "",
-			(unsigned long long)port->mapbase,
-			device->options);
-	else
-		pr_info("Early serial console at I/O port 0x%lx (options '%s')\n",
-			port->iobase,
-			device->options);
-
 	return 0;
 }
 
-- 
2.3.5
