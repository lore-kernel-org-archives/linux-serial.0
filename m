From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/6] serial: uartps: Fix multiple line dereference
Date: Wed, 12 Jun 2019 09:56:32 -0700
Message-ID: <183d192c4f3d0a8032bda73953ac8d1719590570.camel@perches.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
         <3a5b27987c5b4fc5ec7dc7f58485db63057edbfe.1560338079.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a5b27987c5b4fc5ec7dc7f58485db63057edbfe.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, johan@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-06-12 at 13:14 +0200, Michal Simek wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> Trivial patch which fixes this checkpatch warning:
> WARNING: Avoid multiple line dereference - prefer 'port->state->xmit.tail'
> +				port->state->xmit.buf[port->state->xmit.
> +				tail], port->membase + CDNS_UART_FIFO);
> 
> Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Split patch from v1
> - Add Fixes tag
> 
>  drivers/tty/serial/xilinx_uartps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index c84db82bdaab..4cd20c036750 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -319,8 +319,8 @@ static void cdns_uart_handle_tx(void *dev_id)
>  			 * register.
>  			 */
>  			writel(
> -				port->state->xmit.buf[port->state->xmit.
> -				tail], port->membase + CDNS_UART_FIFO);
> +				port->state->xmit.buf[port->state->xmit.tail],
> +					port->membase + CDNS_UART_FIFO);
>  
>  			port->icount.tx++;

Another way to rewrite this is to use a temporary for
port->state->xmit and also return early on empty to
avoid unnecessary indentation.

Using a temporary can also reduce object size a bit by
removing unnecessary dereferences: (defconfig x86-64)

$ size drivers/tty/serial/xilinx_uartps.o*
   text	   data	    bss	    dec	    hex	filename
  26578	   4632	    320	  31530	   7b2a	drivers/tty/serial/xilinx_uartps.o.new
  26642	   4632	    320	  31594	   7b6a	drivers/tty/serial/xilinx_uartps.o.old

i.e.:

---
 drivers/tty/serial/xilinx_uartps.c | 54 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..09b586aeeca3 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -305,40 +305,36 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
-	if (uart_circ_empty(&port->state->xmit)) {
+	if (uart_circ_empty(xmit)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
-	} else {
-		numbytes = port->fifosize;
-		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
-			/*
-			 * Get the data from the UART circular buffer
-			 * and write it to the cdns_uart's TX_FIFO
-			 * register.
-			 */
-			writel(
-				port->state->xmit.buf[port->state->xmit.
-				tail], port->membase + CDNS_UART_FIFO);
-
-			port->icount.tx++;
-
-			/*
-			 * Adjust the tail of the UART buffer and wrap
-			 * the buffer if it reaches limit.
-			 */
-			port->state->xmit.tail =
-				(port->state->xmit.tail + 1) &
-					(UART_XMIT_SIZE - 1);
-
-			numbytes--;
-		}
+		return;
+	}
+
+	numbytes = port->fifosize;
+	while (numbytes && !uart_circ_empty(xmit) &&
+	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		/*
+		 * Get the data from the UART circular buffer and write it
+		 * to the cdns_uart's TX_FIFO register.
+		 */
+		writel(xmit->buf[xmit->tail], port->membase + CDNS_UART_FIFO);
+
+		port->icount.tx++;
+
+		/*
+		 * Adjust the tail of the UART buffer and wrap the buffer
+		 * if it reaches limit.
+		 */
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 
-		if (uart_circ_chars_pending(
-				&port->state->xmit) < WAKEUP_CHARS)
-			uart_write_wakeup(port);
+		numbytes--;
 	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
 }
 
 /**
 
