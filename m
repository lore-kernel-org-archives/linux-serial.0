From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] tty: serial: make sport_uart_ops static and const
Date: Thu, 14 Sep 2017 01:34:58 +0530
Message-ID: <1505333098-32075-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make this const as it is only stored in the const field 'ops' of an
uart_port structure. It is not referenced in any other file and therefore
make it static too.

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Compile-tested for blackfin.

 drivers/tty/serial/bfin_sport_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 6b03fb1..6525378 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -584,7 +584,7 @@ static void sport_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-struct uart_ops sport_uart_ops = {
+static const struct uart_ops sport_uart_ops = {
 	.tx_empty	= sport_tx_empty,
 	.set_mctrl	= sport_set_mctrl,
 	.get_mctrl	= sport_get_mctrl,
-- 
1.9.1
