From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: [PATCH] serial: earlycon: Extend earlycon command line option to
 support 64-bit addresses
Date: Fri, 2 Sep 2016 13:20:21 +0200
Message-ID: <af0e6790-c9e0-a3ed-ac17-1a6a56d954ce@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

earlycon implementation used "unsigned long" internally, but there are systems
(ARM with LPAE) where sizeof(unsigned long) == 4 and uart is mapped beyond 4GiB
address range.

Switch to resource_size_t internally and replace obsoleted simple_strtoul() with
kstrtoull().

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/earlycon.c       |  7 +++----
 drivers/tty/serial/serial_core.c    | 12 +++++++++---
 include/linux/serial_core.h         |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 13ad5c3..f64d6cd 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -639,7 +639,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 {
 	char match[] = "uart";	/* 8250-specific earlycon name */
 	unsigned char iotype;
-	unsigned long addr;
+	resource_size_t addr;
 	int i;
 
 	if (strncmp(name, match, 4) != 0)
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 067783f..3940280 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -38,7 +38,7 @@ static struct earlycon_device early_console_dev = {
 	.con = &early_con,
 };
 
-static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
+static void __iomem * __init earlycon_map(resource_size_t paddr, size_t size)
 {
 	void __iomem *base;
 #ifdef CONFIG_FIX_EARLYCON_MEM
@@ -49,8 +49,7 @@ static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
 	base = ioremap(paddr, size);
 #endif
 	if (!base)
-		pr_err("%s: Couldn't map 0x%llx\n", __func__,
-		       (unsigned long long)paddr);
+		pr_err("%s: Couldn't map %pa\n", __func__, &paddr);
 
 	return base;
 }
@@ -92,7 +91,7 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 {
 	struct uart_port *port = &device->port;
 	int length;
-	unsigned long addr;
+	resource_size_t addr;
 
 	if (uart_parse_earlycon(options, &port->iotype, &addr, &options))
 		return -EINVAL;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9fc1533..89f5d6a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1938,11 +1938,14 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
  *	   console=<name>,0x<addr>,<options>
  *	is also accepted; the returned @iotype will be UPIO_MEM.
  *
- *	Returns 0 on success or -EINVAL on failure
+ *	Returns 0 on success, -EINVAL or -ERANGE on failure
  */
-int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
+int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 			char **options)
 {
+	int ret;
+	unsigned long long tmp;
+
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
 		p += 5;
@@ -1968,7 +1971,10 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 		return -EINVAL;
 	}
 
-	*addr = simple_strtoul(p, NULL, 0);
+	ret = kstrtoull(p, 0, &tmp);
+	if (ret)
+		return ret;
+	*addr = tmp;
 	p = strchr(p, ',');
 	if (p)
 		p++;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2f44e20..cdba6f1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -374,7 +374,7 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
-int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
+int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 			char **options);
 void uart_parse_options(char *options, int *baud, int *parity, int *bits,
 			int *flow);
