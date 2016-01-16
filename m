From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 03/12] serial: earlycon: Fixup earlycon console name and index
Date: Sat, 16 Jan 2016 15:23:40 -0800
Message-ID: <1452986629-17210-4-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Properly initialize the struct console 'name' and 'index' fields for
the registering earlycon. For earlycons w/o trailing numerals, the
index is set to 0; otherwise, the index is set to the value of the
trailing numeral. For example, the 'exynos4210' earlycon name == "exynos"
and index == 4210. Earlycons with embedded numerals will have all
non-trailing numerals as part of the name; for example, the 's3c2412'
earlycon name == "s3c" and index == 2412.

This ackward scheme was initially added for the uart8250 earlycon;
adopt this scheme for the other earlycon "drivers".

Introduce earlycon_init() which performs the string scanning and
initializes the name and index fields; encapsulate the other console
field initializations within.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index d50b700..90b064f 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -27,9 +27,9 @@
 #include <asm/serial.h>
 
 static struct console early_con = {
-	.name =		"uart", /* 8250 console switch requires this name */
+	.name =		"uart",		/* fixed up at earlycon registration */
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
-	.index =	-1,
+	.index =	0,
 };
 
 static struct earlycon_device early_console_dev = {
@@ -53,6 +53,25 @@ static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
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
@@ -119,7 +138,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
-	early_console_dev.con->data = &early_console_dev;
+	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, buf);
 	if (err < 0)
 		return err;
-- 
2.7.0
