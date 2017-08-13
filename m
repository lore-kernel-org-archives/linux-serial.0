From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 07/11] serial: apbuart: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:46 +0200
Message-ID: <1502605310-4314-8-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/tty/serial/apbuart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 75eb083..dd60ed9 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -325,7 +325,7 @@ static int apbuart_verify_port(struct uart_port *port,
 	return ret;
 }
 
-static struct uart_ops grlib_apbuart_ops = {
+static const struct uart_ops grlib_apbuart_ops = {
 	.tx_empty = apbuart_tx_empty,
 	.set_mctrl = apbuart_set_mctrl,
 	.get_mctrl = apbuart_get_mctrl,
