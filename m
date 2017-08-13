From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 06/11] serial: 21285: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:45 +0200
Message-ID: <1502605310-4314-7-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/tty/serial/21285.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 9b208bd..804632b 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -334,7 +334,7 @@ static int serial21285_verify_port(struct uart_port *port, struct serial_struct
 	return ret;
 }
 
-static struct uart_ops serial21285_ops = {
+static const struct uart_ops serial21285_ops = {
 	.tx_empty	= serial21285_tx_empty,
 	.get_mctrl	= serial21285_get_mctrl,
 	.set_mctrl	= serial21285_set_mctrl,
