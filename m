From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/9] tty: serial: jsm_tty: constify uart_ops structures
Date: Thu,  1 Sep 2016 19:51:34 +0200
Message-ID: <1472752298-981-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Check for uart_ops structures that are only stored in the ops field of a
uart_port structure.  This field is declared const, so uart_ops structures
that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct uart_ops i@p = { ... };

@ok@
identifier r.i;
struct uart_port e;
position p;
@@
e.ops = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct uart_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct uart_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/jsm/jsm_tty.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index c5ddfe5..ec7d838 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -346,7 +346,7 @@ static void jsm_config_port(struct uart_port *port, int flags)
 	port->type = PORT_JSM;
 }
 
-static struct uart_ops jsm_ops = {
+static const struct uart_ops jsm_ops = {
 	.tx_empty	= jsm_tty_tx_empty,
 	.set_mctrl	= jsm_tty_set_mctrl,
 	.get_mctrl	= jsm_tty_get_mctrl,
