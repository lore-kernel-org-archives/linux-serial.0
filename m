From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Mainline commit "serial: Test for no tx data on tx restart" not
 correct for i.MX6?
Date: Wed, 06 Aug 2014 19:53:53 -0400
Message-ID: <53E2C011.4070404@hurleysoftware.com>
References: <53CF3599.6040509@gmail.com> <53CFE38E.6070302@hurleysoftware.com> <53D0BFF1.30204@mentor.com> <53D0F4FC.1000302@hurleysoftware.com> <53D74AAA.7090103@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:59997 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753556AbaHFXyA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Aug 2014 19:54:00 -0400
In-Reply-To: <53D74AAA.7090103@mentor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>, Dirk Behme <dirk.behme@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, Dirk Behme <dirk.behme@de.bosch.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 07/29/2014 03:18 AM, jiwang wrote:
> On 07/24/2014 08:58 PM, Peter Hurley wrote:
>> On 07/24/2014 04:12 AM, jiwang wrote:
>>> On 07/24/2014 01:32 AM, Peter Hurley wrote:
>>>> On 07/23/2014 12:10 AM, Dirk Behme wrote:
>>>>> Hi,
>>>>>
>>>>> this is a question regarding the i.MX6 part (drivers/tty/serial/imx.c) of the commit
>>>>>
>>>>> serial: Test for no tx data on tx restart
>>>>>
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c557d392fbf5badd693ea1946a4317c87a26a716
>>>>>
>>>>> Talking with some i.MX6 experts about this, I've got the comment
>>>>>
>>>>> -- cut --
>>>>> The imx serial driver part of this commit isn't correct
>>>>> as imx.c sends x_char in irq handler, not in imx_start_tx(),
>>>>> -- cut --
>>>>>
>>>>> What do you think?
>>>>
>>>> Yeah, I missed that the imx driver handled x_char _at all_,
>>>> because how the imx driver is handling x_char looks broken.

[...]

> sorry,  our imx driver has been modified differently,
> yes, you are right, mainline imx driver's handling of x_char looks broken

Jiada or Dirk or whomever,

Would someone please test the patch below on actual imx hardware?

You can download a standalone x_char unit test from
http://blog.hurleysoftware.com/uploads/tty_xchar.c

Instructions for building, setting up and testing are included in the file.

--- >% ---
Subject: [PATCH] serial: imx: Fix x_char handling and tx flow control

The serial core expects the UART driver to transmit x_char
(START/STOP chars) even if tx is stopped and before data already
in the tx ring buffer if possible. Also, sending x_char must
not cause additional data in the tx ring buffer to transmit
if tx is stopped.

Cause x_char to be transmitted before any other data is sent.
Auto-stop tx if the tx ring buffer is empty or tx should be stopped.
Only perform one write wakeup if tx ring buffer space is below
threshold.

x_char handling in DMA mode is still broken; add FIXME.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/imx.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index be1c842..00a37e9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -460,9 +460,19 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
 
+	if (sport->port.x_char) {
+		/* Send next char */
+		writel(sport->port.x_char, sport->port.membase + URTX0);
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+		imx_stop_tx(&sport->port);
+		return;
+	}
+
 	while (!uart_circ_empty(xmit) &&
-			!(readl(sport->port.membase + uts_reg(sport))
-				& UTS_TXFULL)) {
+	       !(readl(sport->port.membase + uts_reg(sport)) & UTS_TXFULL)) {
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
 		writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
@@ -563,9 +573,6 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	if (uart_circ_empty(&port->state->xmit))
-		return;
-
 	if (USE_IRDA(sport)) {
 		/* half duplex in IrDA mode; have to disable receive mode */
 		temp = readl(sport->port.membase + UCR4);
@@ -600,7 +607,10 @@ static void imx_start_tx(struct uart_port *port)
 	}
 
 	if (sport->dma_is_enabled) {
-		imx_dma_tx(sport);
+		/* FIXME: port->x_char must be transmitted if != 0 */
+		if (!uart_circ_empty(&port->state->xmit) &&
+		    !uart_tx_stopped(port))
+			imx_dma_tx(sport);
 		return;
 	}
 
@@ -628,27 +638,10 @@ static irqreturn_t imx_rtsint(int irq, void *dev_id)
 static irqreturn_t imx_txint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-	if (sport->port.x_char) {
-		/* Send next char */
-		writel(sport->port.x_char, sport->port.membase + URTX0);
-		goto out;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		imx_stop_tx(&sport->port);
-		goto out;
-	}
-
 	imx_transmit_buffer(sport);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
-out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return IRQ_HANDLED;
 }
-- 
2.0.4


