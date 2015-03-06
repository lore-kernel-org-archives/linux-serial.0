From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 02/14] serial: earlycon: Fixup earlycon console name and index
Date: Fri,  6 Mar 2015 14:25:18 -0500
Message-ID: <1425669930-22137-3-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Properly initialize the struct console::name and ::index for
the registering earlycon. The earlycon's ::index == 0
for earlycons without trailing numerals and the numeral value
for earlycons with trailing numerals. For example, exynos4210
earlycon ::name == "exynos" and ::index = 4210. Earlycons with
embedded numerals will have all non-trailing numerals as part of
the name; for example, s3c2412 earlycon ::name == "s3c" and ::index
== 2412. This ackward scheme was initially supported for the
uart8250 earlycon; this patch extends this support to the other
earlycon "drivers".

Introduce earlycon_init() which performs the string scanning
and initializes the ::name and ::index fields; encapsulate the other
console field initializations within.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5fdc9f3..1ffdb61 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -28,9 +28,9 @@
 #include <asm/serial.h>
 
 static struct console early_con = {
-	.name =		"uart", /* 8250 console switch requires this name */
+	.name =		"uart",		/* fixed up at earlycon registration */
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
-	.index =	-1,
+	.index =	0,
 };
 
 static struct earlycon_device early_console_dev = {
@@ -61,6 +61,25 @@ static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
 	return base;
 }
 
+static void __init earlycon_init(struct earlycon_device *device,
+				 const char *name)
+{
+	struct console *earlycon = device->con;
+	const char *s;
+	size_t len;
+
+	/* scan backwards from end of string for first non-numeral */
+	for (s = name + strlen(name);
+	     s > name && s[-1] >= '0' && s[-1] <= '9';
+	     s--)
+		;
+	if (*s)
+		earlycon->index = simple_strtoul(s, NULL, 10);
+	len = s - name;
+	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
+	earlycon->data = &early_console_dev;
+}
+
 static int __init parse_options(struct earlycon_device *device, char *options)
 {
 	struct uart_port *port = &device->port;
@@ -116,7 +135,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
-	early_console_dev.con->data = &early_console_dev;
+	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, buf);
 	if (err < 0)
 		return err;
-- 
2.3.1
