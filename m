From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 07/11] serial: earlycon: Common log banner for command line and DT
Date: Sat, 16 Jan 2016 13:37:20 -0800
Message-ID: <1452980244-20512-8-git-send-email-peter@hurleysoftware.com>
References: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
 <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Refactor the command line earlycon banner into earlycon_init() so
both earlycon startup methods output an info banner.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 24f9adb..ff22200 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -59,6 +59,7 @@ static void __init earlycon_init(struct earlycon_device *device,
 				 const char *name)
 {
 	struct console *earlycon = device->con;
+	struct uart_port *port = &device->port;
 	const char *s;
 	size_t len;
 
@@ -72,6 +73,19 @@ static void __init earlycon_init(struct earlycon_device *device,
 	len = s - name;
 	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
 	earlycon->data = &early_console_dev;
+
+	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
+	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
+		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
+			(port->iotype == UPIO_MEM) ? "" :
+			(port->iotype == UPIO_MEM16) ? "16" :
+			(port->iotype == UPIO_MEM32) ? "32" : "32be",
+			(unsigned long long)port->mapbase,
+			device->options);
+	else
+		pr_info("Early serial console at I/O port 0x%lx (options '%s')\n",
+			port->iobase,
+			device->options);
 }
 
 static int __init parse_options(struct earlycon_device *device, char *options)
@@ -110,19 +124,6 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 		strlcpy(device->options, options, length);
 	}
 
-	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
-	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
-		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
-			(port->iotype == UPIO_MEM) ? "" :
-			(port->iotype == UPIO_MEM16) ? "16" :
-			(port->iotype == UPIO_MEM32) ? "32" : "32be",
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
2.7.0
