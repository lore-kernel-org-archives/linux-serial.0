From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 9/9] serial/arc: constify uart_ops structures
Date: Thu,  1 Sep 2016 19:51:38 +0200
Message-ID: <1472752298-981-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <vgupta@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org
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
 drivers/tty/serial/arc_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 3a1de5c..5ac06fc 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -464,7 +464,7 @@ static int arc_serial_poll_getchar(struct uart_port *port)
 }
 #endif
 
-static struct uart_ops arc_serial_pops = {
+static const struct uart_ops arc_serial_pops = {
 	.tx_empty	= arc_serial_tx_empty,
 	.set_mctrl	= arc_serial_set_mctrl,
 	.get_mctrl	= arc_serial_get_mctrl,
