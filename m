From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] tty: amba-pl011: Convert timers to use timer_setup()
Date: Mon, 16 Oct 2017 16:28:45 -0700
Message-ID: <20171016232845.GA101226@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/amba-pl011.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 111e6a950779..dab36369f71e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1078,9 +1078,9 @@ static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
  * Every polling, It checks the residue in the dma buffer and transfer
  * data to the tty. Also, last_residue is updated for the next polling.
  */
-static void pl011_dma_rx_poll(unsigned long args)
+static void pl011_dma_rx_poll(struct timer_list *t)
 {
-	struct uart_amba_port *uap = (struct uart_amba_port *)args;
+	struct uart_amba_port *uap = from_timer(uap, t, dmarx.timer);
 	struct tty_port *port = &uap->port.state->port;
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = uap->dmarx.chan;
@@ -1192,9 +1192,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 			dev_dbg(uap->port.dev, "could not trigger initial "
 				"RX DMA job, fall back to interrupt mode\n");
 		if (uap->dmarx.poll_rate) {
-			init_timer(&(uap->dmarx.timer));
-			uap->dmarx.timer.function = pl011_dma_rx_poll;
-			uap->dmarx.timer.data = (unsigned long)uap;
+			timer_setup(&uap->dmarx.timer, pl011_dma_rx_poll, 0);
 			mod_timer(&uap->dmarx.timer,
 				jiffies +
 				msecs_to_jiffies(uap->dmarx.poll_rate));
-- 
2.7.4


-- 
Kees Cook
Pixel Security
