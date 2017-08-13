From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 05/11] serial: uuc_uart: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:44 +0200
Message-ID: <1502605310-4314-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/ucc_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 481eb29..55b7027 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1085,7 +1085,7 @@ static int qe_uart_verify_port(struct uart_port *port,
  *
  * Details on these functions can be found in Documentation/serial/driver
  */
-static struct uart_ops qe_uart_pops = {
+static const struct uart_ops qe_uart_pops = {
 	.tx_empty       = qe_uart_tx_empty,
 	.set_mctrl      = qe_uart_set_mctrl,
 	.get_mctrl      = qe_uart_get_mctrl,
