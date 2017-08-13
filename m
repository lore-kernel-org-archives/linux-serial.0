From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 09/11] serial: m32r_sio: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:48 +0200
Message-ID: <1502605310-4314-10-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/tty/serial/m32r_sio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 218b711..5b3bd95 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -854,7 +854,7 @@ static void m32r_sio_config_port(struct uart_port *port, int unused)
 	return 0;
 }
 
-static struct uart_ops m32r_sio_pops = {
+static const struct uart_ops m32r_sio_pops = {
 	.tx_empty	= m32r_sio_tx_empty,
 	.set_mctrl	= m32r_sio_set_mctrl,
 	.get_mctrl	= m32r_sio_get_mctrl,
