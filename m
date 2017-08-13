From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 11/11] serial: mux: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:50 +0200
Message-ID: <1502605310-4314-12-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/tty/serial/mux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 8a4be4b..940ea40 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -427,7 +427,7 @@ static int mux_console_setup(struct console *co, char *options)
 #define MUX_CONSOLE	NULL
 #endif
 
-static struct uart_ops mux_pops = {
+static const struct uart_ops mux_pops = {
 	.tx_empty =		mux_tx_empty,
 	.set_mctrl =		mux_set_mctrl,
 	.get_mctrl =		mux_get_mctrl,
