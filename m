From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] serial_core: support native endianness
Date: Tue, 22 Sep 2015 14:34:53 +0300
Message-ID: <1442921693-1389-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f368520..84b5695 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1826,8 +1826,8 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
  *	@options: ptr for <options> field; NULL if not present (out)
  *
  *	Decodes earlycon kernel command line parameters of the form
- *	   earlycon=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>
- *	   console=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>
+ *	   earlycon=<name>,io|mmio|mmio32|mmio32be|mmio32native,<addr>,<options>
+ *	   console=<name>,io|mmio|mmio32|mmio32be|mmio32native,<addr>,<options>
  *
  *	The optional form
  *	   earlycon=<name>,0x<addr>,<options>
@@ -1848,6 +1848,10 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 	} else if (strncmp(p, "mmio32be,", 9) == 0) {
 		*iotype = UPIO_MEM32BE;
 		p += 9;
+	} else if (strncmp(p, "mmio32native,", 13) == 0) {
+		*iotype = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ?
+			UPIO_MEM32BE : UPIO_MEM32;
+		p += 13;
 	} else if (strncmp(p, "io,", 3) == 0) {
 		*iotype = UPIO_PORT;
 		p += 3;
-- 
1.8.1.4
