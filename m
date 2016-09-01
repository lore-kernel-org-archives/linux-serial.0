From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/9] serial: altera: constify uart_ops structures
Date: Thu,  1 Sep 2016 19:51:32 +0200
Message-ID: <1472752298-981-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
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
 drivers/tty/serial/altera_jtaguart.c |    2 +-
 drivers/tty/serial/altera_uart.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 32df2a0..e409d7d 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -280,7 +280,7 @@ static int altera_jtaguart_verify_port(struct uart_port *port,
 /*
  *	Define the basic serial functions we support.
  */
-static struct uart_ops altera_jtaguart_ops = {
+static const struct uart_ops altera_jtaguart_ops = {
 	.tx_empty	= altera_jtaguart_tx_empty,
 	.get_mctrl	= altera_jtaguart_get_mctrl,
 	.set_mctrl	= altera_jtaguart_set_mctrl,
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 61b607f..820a742 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -404,7 +404,7 @@ static void altera_uart_poll_put_char(struct uart_port *port, unsigned char c)
 /*
  *	Define the basic serial functions we support.
  */
-static struct uart_ops altera_uart_ops = {
+static const struct uart_ops altera_uart_ops = {
 	.tx_empty	= altera_uart_tx_empty,
 	.get_mctrl	= altera_uart_get_mctrl,
 	.set_mctrl	= altera_uart_set_mctrl,

