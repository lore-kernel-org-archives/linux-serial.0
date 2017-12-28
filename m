From: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Subject: [PATCH 1/3] serial: core: Make uart_parse_options take const char* argument
Date: Thu, 28 Dec 2017 14:07:07 +0100
Message-ID: <20171228130709.12457-2-paul@crapouillou.net>
References: <20171228130709.12457-1-paul@crapouillou.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171228130709.12457-1-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The pointed string is never modified from within uart_parse_options, so
it should be marked as const in the function prototype.

Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
---
 drivers/tty/serial/serial_core.c | 5 +++--
 include/linux/serial_core.h      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

 v1: Initial version

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 854995e1cae7..4e0c9209bfb7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1955,9 +1955,10 @@ EXPORT_SYMBOL_GPL(uart_parse_earlycon);
  *	eg: 115200n8r
  */
 void
-uart_parse_options(char *options, int *baud, int *parity, int *bits, int *flow)
+uart_parse_options(const char *options, int *baud, int *parity,
+		   int *bits, int *flow)
 {
-	char *s = options;
+	const char *s = options;
 
 	*baud = simple_strtoul(s, NULL, 10);
 	while (*s >= '0' && *s <= '9')
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 37b044e78333..e23d9aa757fb 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -387,7 +387,7 @@ struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 			char **options);
-void uart_parse_options(char *options, int *baud, int *parity, int *bits,
+void uart_parse_options(const char *options, int *baud, int *parity, int *bits,
 			int *flow);
 int uart_set_options(struct uart_port *port, struct console *co, int baud,
 		     int parity, int bits, int flow);
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
