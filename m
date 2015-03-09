From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 -next 06/11] serial: 8250_early: Fix setup() error code
Date: Mon,  9 Mar 2015 16:27:17 -0400
Message-ID: <1425932842-21812-7-git-send-email-peter@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If parsing failed to decode a valid uart addr, return -ENODEV instead
of success. Although setup_earlycon() will detect the failure anyway
(because the write() method has not been set), that behavior is not
obvious and should not be relied on.

Acked-by: Rob Herring <robh@kernel.org>
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
2.3.1
