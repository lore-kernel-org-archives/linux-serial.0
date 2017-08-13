From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 08/11] serial: cpm_uart: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:47 +0200
Message-ID: <1502605310-4314-9-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index f6bcc19..9ac142c 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1123,7 +1123,7 @@ static void cpm_put_poll_char(struct uart_port *port,
 }
 #endif /* CONFIG_CONSOLE_POLL */
 
-static struct uart_ops cpm_uart_pops = {
+static const struct uart_ops cpm_uart_pops = {
 	.tx_empty	= cpm_uart_tx_empty,
 	.set_mctrl	= cpm_uart_set_mctrl,
 	.get_mctrl	= cpm_uart_get_mctrl,
