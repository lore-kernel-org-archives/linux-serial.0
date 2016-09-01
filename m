From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 6/9] tty: serial: constify uart_ops structures
Date: Thu,  1 Sep 2016 19:51:35 +0200
Message-ID: <1472752298-981-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
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
 drivers/tty/serial/fsl_lpuart.c    |    4 ++--
 drivers/tty/serial/imx.c           |    2 +-
 drivers/tty/serial/max3100.c       |    2 +-
 drivers/tty/serial/men_z135_uart.c |    2 +-
 drivers/tty/serial/mxs-auart.c     |    2 +-
 drivers/tty/serial/pch_uart.c      |    2 +-
 drivers/tty/serial/sh-sci.c        |    2 +-
 drivers/tty/serial/timbuart.c      |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7f95f78..55e5e21 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1494,7 +1494,7 @@ static int lpuart_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
-static struct uart_ops lpuart_pops = {
+static const struct uart_ops lpuart_pops = {
 	.tx_empty	= lpuart_tx_empty,
 	.set_mctrl	= lpuart_set_mctrl,
 	.get_mctrl	= lpuart_get_mctrl,
@@ -1513,7 +1513,7 @@ static struct uart_ops lpuart_pops = {
 	.flush_buffer	= lpuart_flush_buffer,
 };
 
-static struct uart_ops lpuart32_pops = {
+static const struct uart_ops lpuart32_pops = {
 	.tx_empty	= lpuart32_tx_empty,
 	.set_mctrl	= lpuart32_set_mctrl,
 	.get_mctrl	= lpuart32_get_mctrl,
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0df2b1c..9bbf2a4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1690,7 +1690,7 @@ static int imx_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static struct uart_ops imx_pops = {
+static const struct uart_ops imx_pops = {
 	.tx_empty	= imx_tx_empty,
 	.set_mctrl	= imx_set_mctrl,
 	.get_mctrl	= imx_get_mctrl,
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5c4c280..ace8264 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -712,7 +712,7 @@ static void max3100_break_ctl(struct uart_port *port, int break_state)
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
 
-static struct uart_ops max3100_ops = {
+static const struct uart_ops max3100_ops = {
 	.tx_empty	= max3100_tx_empty,
 	.set_mctrl	= max3100_set_mctrl,
 	.get_mctrl	= max3100_get_mctrl,
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index a44290e..e72ea61 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -775,7 +775,7 @@ static int men_z135_verify_port(struct uart_port *port,
 	return -EINVAL;
 }
 
-static struct uart_ops men_z135_ops = {
+static const struct uart_ops men_z135_ops = {
 	.tx_empty = men_z135_tx_empty,
 	.set_mctrl = men_z135_set_mctrl,
 	.get_mctrl = men_z135_get_mctrl,
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index eb54e5c..2f04ec2 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1317,7 +1317,7 @@ static void mxs_auart_break_ctl(struct uart_port *u, int ctl)
 		mxs_clr(AUART_LINECTRL_BRK, s, REG_LINECTRL);
 }
 
-static struct uart_ops mxs_auart_ops = {
+static const struct uart_ops mxs_auart_ops = {
 	.tx_empty       = mxs_auart_tx_empty,
 	.start_tx       = mxs_auart_start_tx,
 	.stop_tx	= mxs_auart_stop_tx,
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index ea4ffc2..b5874d1 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1603,7 +1603,7 @@ static void pch_uart_put_poll_char(struct uart_port *port,
 }
 #endif /* CONFIG_CONSOLE_POLL */
 
-static struct uart_ops pch_uart_ops = {
+static const struct uart_ops pch_uart_ops = {
 	.tx_empty = pch_uart_tx_empty,
 	.set_mctrl = pch_uart_set_mctrl,
 	.get_mctrl = pch_uart_get_mctrl,
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d86eee3..4b26252 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2533,7 +2533,7 @@ static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
-static struct uart_ops sci_uart_ops = {
+static const struct uart_ops sci_uart_ops = {
 	.tx_empty	= sci_tx_empty,
 	.set_mctrl	= sci_set_mctrl,
 	.get_mctrl	= sci_get_mctrl,
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 512c162..5da7fe4 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -394,7 +394,7 @@ static int timbuart_verify_port(struct uart_port *port,
 	return -EINVAL;
 }
 
-static struct uart_ops timbuart_ops = {
+static const struct uart_ops timbuart_ops = {
 	.tx_empty = timbuart_tx_empty,
 	.set_mctrl = timbuart_set_mctrl,
 	.get_mctrl = timbuart_get_mctrl,
