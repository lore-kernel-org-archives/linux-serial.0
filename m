From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 08/13] serial: 8250_early: Fix setup() error code
Date: Tue, 24 Feb 2015 11:37:05 -0500
Message-ID: <1424795830-31223-9-git-send-email-peter@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If parsing failed to decode a valid uart addr, return -ENODEV instead
of success. Although setup_earlycon() will detect the failure anyway
(because the write() method has not been set), that behavior is not
obvious and should not be relied on.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 1701d00..b199c10 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -146,7 +146,7 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 					 const char *options)
 {
 	if (!(device->port.membase || device->port.iobase))
-		return 0;
+		return -ENODEV;
 
 	if (!device->baud) {
 		struct uart_port *port = &device->port;
-- 
2.3.0
