From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 02/11] serial: owl: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:41 +0200
Message-ID: <1502605310-4314-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/owl-uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 683b054..b9c85936 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -473,7 +473,7 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
-static struct uart_ops owl_uart_ops = {
+static const struct uart_ops owl_uart_ops = {
 	.set_mctrl = owl_uart_set_mctrl,
 	.get_mctrl = owl_uart_get_mctrl,
 	.tx_empty = owl_uart_tx_empty,
