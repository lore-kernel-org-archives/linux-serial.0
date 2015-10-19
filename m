From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] serial: earlycon: allow to specify uartclk in earlycon kernel-parameter
Date: Mon, 19 Oct 2015 14:40:24 +0900
Message-ID: <1445233224-23150-3-git-send-email-yamada.masahiro@socionext.com>
References: <1445233224-23150-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445233224-23150-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

The input clock frequency varies from device to device, but the
earlycon uses the fixed frequency (BASE_BAUD * 16).  It makes
impossible to set the correct divisor to the register.

This commit allows to specify the input clock frequency from the
kernel-parameter.

[Example]

    earlycon=uart8250,mmio32,0x43fb0000,115200,12288000

The input clock frequency (12288000, in this case) should be specified
after the baudrate.  If not specified, the default (BASE_BAUD * 16) is
used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/earlycon.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 07f7393..8030765 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -95,6 +95,13 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
 		strlcpy(device->options, options, length);
+		options = strchr(options, ',');
+		if (options) {
+			options++;
+			port->uartclk = simple_strtoul(options, NULL, 0);
+		}
+		if (!port->uartclk)
+			port->uartclk = BASE_BAUD * 16;
 	}
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
@@ -122,7 +129,6 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 	if (buf && !parse_options(&early_console_dev, buf))
 		buf = NULL;
 
-	port->uartclk = BASE_BAUD * 16;
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
-- 
1.9.1
