From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 10/11] serial: mpc52xx: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:49 +0200
Message-ID: <1502605310-4314-11-git-send-email-Julia.Lawall@lip6.fr>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/mpc52xx_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 4cacaad..791c4c7 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1347,7 +1347,7 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 }
 
 
-static struct uart_ops mpc52xx_uart_ops = {
+static const struct uart_ops mpc52xx_uart_ops = {
 	.tx_empty	= mpc52xx_uart_tx_empty,
 	.set_mctrl	= mpc52xx_uart_set_mctrl,
 	.get_mctrl	= mpc52xx_uart_get_mctrl,
