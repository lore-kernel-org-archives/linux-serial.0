From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 12/13] serial: earlycon: Enable earlycon without command line param
Date: Tue, 24 Feb 2015 11:37:09 -0500
Message-ID: <1424795830-31223-13-git-send-email-peter@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Earlycon matching can only be triggered if 'earlycon=...' has been
specified on the kernel command line. To workaround this limitation
requires tight coupling between arches and specific serial drivers
in order to start an earlycon. Devicetree avoids this limitation
with a link table that contains the required data to match earlycons.

Mirror this approach for earlycon match by name. Re-purpose
EARLYCON_DECLARE to generate a table entry which associates name with
setup() function. Re-purpose setup_earlycon() to scan this table for
an earlycon match, which is registered if found.

Declare one "earlycon" early_param, which calls setup_earlycon().

This design allows setup_earlycon() to be called directly with a
param string (as if 'earlycon=...' had been set on the command line).
Re-registration (either directly or by early_param) is prevented.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c |  7 +--
 drivers/tty/serial/earlycon.c        | 92 ++++++++++++++++++++++++++++--------
 include/asm-generic/vmlinux.lds.h    |  9 ++++
 include/linux/serial_core.h          | 19 ++++----
 4 files changed, 94 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index b199c10..d272139 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -170,10 +170,5 @@ EARLYCON_DECLARE(uart, early_serial8250_setup);
 
 int __init setup_early_serial8250_console(char *cmdline)
 {
-	char match[] = "uart8250";
-
-	if (cmdline && cmdline[4] == ',')
-		match[4] = '\0';
-
-	return setup_earlycon(cmdline, match, early_serial8250_setup);
+	return setup_earlycon(cmdline);
 }
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 9fb76b6..5fdc9f3 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -10,6 +10,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/console.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -34,6 +37,10 @@ static struct earlycon_device early_console_dev = {
 	.con = &early_con,
 };
 
+extern struct earlycon_id __earlycon_table[];
+static const struct earlycon_id __earlycon_table_sentinel
+	__used __section(__earlycon_table_end);
+
 static const struct of_device_id __earlycon_of_table_sentinel
 	__used __section(__earlycon_of_table_end);
 
@@ -96,9 +103,7 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	return 0;
 }
 
-
-static int __init
-register_earlycon(char *buf, int (*setup)(struct earlycon_device *, const char *))
+static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
@@ -112,7 +117,7 @@ register_earlycon(char *buf, int (*setup)(struct earlycon_device *, const char *
 		port->membase = earlycon_map(port->mapbase, 64);
 
 	early_console_dev.con->data = &early_console_dev;
-	err = setup(&early_console_dev, buf);
+	err = match->setup(&early_console_dev, buf);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
@@ -122,27 +127,76 @@ register_earlycon(char *buf, int (*setup)(struct earlycon_device *, const char *
 	return 0;
 }
 
-int __init setup_earlycon(char *buf, const char *match,
-			  int (*setup)(struct earlycon_device *, const char *))
+/**
+ *	setup_earlycon - match and register earlycon console
+ *	@buf:	earlycon param string
+ *
+ *	Registers the earlycon console matching the earlycon specified
+ *	in the param string @buf. Acceptable param strings are of the form
+ *	   <name>,io|mmio|mmio32,<addr>,<options>
+ *	   <name>,0x<addr>,<options>
+ *	   <name>,<options>
+ *	   <name>
+ *
+ *	Only for the third form does the earlycon setup() method receive the
+ *	<options> string in the 'options' parameter; all other forms set
+ *	the parameter to NULL.
+ *
+ *	Returns 0 if an attempt to register the earlycon was made,
+ *	otherwise negative error code
+ */
+int __init setup_earlycon(char *buf)
 {
-	size_t len;
+	const struct earlycon_id *match;
 
-	if (!buf || !match || !setup)
-		return 0;
+	if (!buf || !buf[0])
+		return -EINVAL;
 
-	len = strlen(match);
-	if (strncmp(buf, match, len))
-		return 0;
+	if (early_con.flags & CON_ENABLED)
+		return -EALREADY;
 
-	if (buf[len]) {
-		if (buf[len] != ',')
-			return 0;
-		buf += len + 1;
-	} else
-		buf = NULL;
+	for (match = __earlycon_table; match->name[0]; match++) {
+		size_t len = strlen(match->name);
 
-	return register_earlycon(buf, setup);
+		if (strncmp(buf, match->name, len))
+			continue;
+
+		if (buf[len]) {
+			if (buf[len] != ',')
+				continue;
+			buf += len + 1;
+		} else
+			buf = NULL;
+
+		return register_earlycon(buf, match);
+	}
+
+	return -ENOENT;
+}
+
+/* early_param wrapper for setup_earlycon() */
+static int __init param_setup_earlycon(char *buf)
+{
+	int err;
+
+	/*
+	 * Just 'earlycon' is a valid param for devicetree earlycons;
+	 * don't generate a warning from parse_early_params() in that case
+	 */
+	if (!buf || !buf[0])
+		return 0;
+
+	err = setup_earlycon(buf);
+	if (err == -ENOENT) {
+		pr_warn("no match for %s\n", buf);
+		err = 0;
+	} else if (err == -EALREADY) {
+		pr_warn("already registered\n");
+		err = 0;
+	}
+	return err;
 }
+early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *))
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bee5d68..006c1f7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -150,6 +150,14 @@
 #define TRACE_SYSCALLS()
 #endif
 
+#ifdef CONFIG_SERIAL_EARLYCON
+#define EARLYCON_TABLE() . = ALIGN(8);				\
+			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
+			 *(__earlycon_table)			\
+			 *(__earlycon_table_end)
+#else
+#define EARLYCON_TABLE()
+#endif
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
 #define __OF_TABLE(cfg, name)	___OF_TABLE(cfg, name)
@@ -502,6 +510,7 @@
 	CPU_METHOD_OF_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
+	EARLYCON_TABLE()						\
 	EARLYCON_OF_TABLES()
 
 #define INIT_TEXT							\
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cc5c506..a3fd182 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -336,18 +336,21 @@ struct earlycon_device {
 	char options[16];		/* e.g., 115200n8 */
 	unsigned int baud;
 };
-int setup_earlycon(char *buf, const char *match,
-		   int (*setup)(struct earlycon_device *, const char *));
 
+struct earlycon_id {
+	char	name[16];
+	int	(*setup)(struct earlycon_device *, const char *options);
+};
+
+extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *));
 
-#define EARLYCON_DECLARE(name, func) \
-static int __init name ## _setup_earlycon(char *buf) \
-{ \
-	return setup_earlycon(buf, __stringify(name), func); \
-} \
-early_param("earlycon", name ## _setup_earlycon);
+#define EARLYCON_DECLARE(_name, func)					\
+	static const struct earlycon_id __earlycon_##_name		\
+		__used __section(__earlycon_table)			\
+		 = { .name  = __stringify(_name),			\
+		     .setup = func  }
 
 #define OF_EARLYCON_DECLARE(name, compat, fn)				\
 	_OF_DECLARE(earlycon, name, compat, fn, void *)
-- 
2.3.0
