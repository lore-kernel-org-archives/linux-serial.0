From: Matthew Leach <matthew.leach@codethink.co.uk>
Subject: [PATCH] tty: serial: 8250: add CON_CONSDEV to flags
Date: Tue, 21 Jun 2016 16:19:49 +0100
Message-ID: <1466522389-26943-1-git-send-email-matthew.leach@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Matthew Leach <matthew.leach@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

When using the 8250 as a boot console and the main console results in
messages being printed twice.  The console framework will only
unregister boot consoles if a new console is registered with the
CON_CONSDEV flag set.

Set this flag for the univ8250 console to prevent double-registration.

Signed-off-by: Matthew Leach <matthew.leach@codethink.co.uk>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 2f4f5ee..7a7453d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -675,7 +675,7 @@ static struct console univ8250_console = {
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_CONSDEV,
 	.index		= -1,
 	.data		= &serial8250_reg,
 };
-- 
2.8.2
