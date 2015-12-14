From: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
Subject: [PATCH] tty: serial: constify psc_ops structs
Date: Tue, 15 Dec 2015 01:45:16 +0200
Message-ID: <20151214234516.GA6052@waves>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Constifies psc_ops structures in tty's serial
port driver since they are not modified after
their initialization.

Detected and found using Coccinelle.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 8c3e513..3970d6a 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -346,7 +346,7 @@ static irqreturn_t mpc52xx_psc_handle_irq(struct uart_port *port)
 	return mpc5xxx_uart_process_int(port);
 }
 
-static struct psc_ops mpc52xx_psc_ops = {
+static const struct psc_ops mpc52xx_psc_ops = {
 	.fifo_init = mpc52xx_psc_fifo_init,
 	.raw_rx_rdy = mpc52xx_psc_raw_rx_rdy,
 	.raw_tx_rdy = mpc52xx_psc_raw_tx_rdy,
@@ -376,7 +376,7 @@ static struct psc_ops mpc52xx_psc_ops = {
 	.get_mr1 = mpc52xx_psc_get_mr1,
 };
 
-static struct psc_ops mpc5200b_psc_ops = {
+static const struct psc_ops mpc5200b_psc_ops = {
 	.fifo_init = mpc52xx_psc_fifo_init,
 	.raw_rx_rdy = mpc52xx_psc_raw_rx_rdy,
 	.raw_tx_rdy = mpc52xx_psc_raw_tx_rdy,
@@ -969,7 +969,7 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	return in_8(&PSC_5125(port)->mr1);
 }
 
-static struct psc_ops mpc5125_psc_ops = {
+static const struct psc_ops mpc5125_psc_ops = {
 	.fifo_init = mpc5125_psc_fifo_init,
 	.raw_rx_rdy = mpc5125_psc_raw_rx_rdy,
 	.raw_tx_rdy = mpc5125_psc_raw_tx_rdy,
@@ -1004,7 +1004,7 @@ static struct psc_ops mpc5125_psc_ops = {
 	.get_mr1 = mpc5125_psc_get_mr1,
 };
 
-static struct psc_ops mpc512x_psc_ops = {
+static const struct psc_ops mpc512x_psc_ops = {
 	.fifo_init = mpc512x_psc_fifo_init,
 	.raw_rx_rdy = mpc512x_psc_raw_rx_rdy,
 	.raw_tx_rdy = mpc512x_psc_raw_tx_rdy,
-- 
2.4.3


-- 
Kind Regards,
Aya Saif El-yazal Mahfouz
