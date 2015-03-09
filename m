From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 -next 04/11] serial: earlycon: Move ->uartclk initialize
Date: Mon,  9 Mar 2015 16:27:15 -0400
Message-ID: <1425932842-21812-5-git-send-email-peter@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Initializing the ->uartclk field is not related to option parsing;
relocate from parse_options() to setup_earlycon() (which mirrors the
behavior of of_setup_earlycon()).

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 58d6bcd..0480c8f 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -76,8 +76,6 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 		return -EINVAL;
 	}
 
-	port->uartclk = BASE_BAUD * 16;
-
 	if (options) {
 		device->baud = simple_strtoul(options, NULL, 0);
 		length = min(strcspn(options, " ") + 1,
@@ -121,6 +119,7 @@ int __init setup_earlycon(char *buf, const char *match,
 	if (!err)
 		buf = NULL;
 
+	port->uartclk = BASE_BAUD * 16;
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
-- 
2.3.1
