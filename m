From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Subject: RE: [PATCH 4/4] serial: xuartps: Rewrite the interrupt handling logic
Date: Mon, 17 Aug 2015 16:00:20 +0000
Message-ID: <59506B47DEDD3943ABF9AC60020F4E2978D6E80A@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
 <ead0c38140e815133a47797a2527229a2fc077c1.1439796149.git.michal.simek@xilinx.com>
 <55D2040F.1010205@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55D2040F.1010205@hurleysoftware.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michals@xilinx.com>
Cc: "monstr@monstr.eu" <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Soren Brinkmann <sorenb@xilinx.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

> -----Original Message-----
> From: Peter Hurley [mailto:peter@hurleysoftware.com]
> Sent: Monday, August 17, 2015 9:26 PM
> To: Michal Simek
> Cc: linux-kernel@vger.kernel.org; monstr@monstr.eu; Anirudha Sarangi; Soren
> Brinkmann; Jiri Slaby; linux-serial@vger.kernel.org; Greg Kroah-Hartman; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 4/4] serial: xuartps: Rewrite the interrupt handling logic
>
> On 08/17/2015 03:22 AM, Michal Simek wrote:
> > From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> >
> > The existing interrupt handling logic has followins issues.
> > - Upon a parity error with default configuration, the control
> >   never comes out of the ISR thereby hanging Linux.
> > - The error handling logic around framing and parity error are buggy.
> >   There are chances that the errors will never be captured.
> > - The existing ISR is just too long.
> > This patch fixes all these concerns.
>
> This patch is unreviewable. Please break this down into multiple patches.
>
Thanks. Let me give a shot. It is just breaking the single big ISR that has both Rx and Tx in a single function into smaller ones.
Not sure how I will create smaller patches, but I will try and get back.

Regards
Anirudha

> Regards,
> Peter Hurley
>
> > It separates out the Tx and Rx
> > hanling logic into separate functions. It ensures that the status
> > registers are cleared on all cases so that a hang situation never
> > arises.
> >
> > Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >
> >  drivers/tty/serial/xilinx_uartps.c | 194
> > ++++++++++++++++++++-----------------
> >  1 file changed, 104 insertions(+), 90 deletions(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 2dc26e5f1384..c771dbbf6161 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -173,61 +173,86 @@ struct cdns_uart {
> >             clk_rate_change_nb);
> >
> >  /**
> > - * cdns_uart_isr - Interrupt handler
> > - * @irq: Irq number
> > - * @dev_id: Id of the port
> > - *
> > - * Return: IRQHANDLED
> > + * cdns_uart_handle_tx - Handle the bytes to be Txed.
> > + * @dev_id: Id of the UART port
> > + * Return: None
> >   */
> > -static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
> > +static void cdns_uart_handle_tx(void *dev_id)
> >  {
> >     struct uart_port *port = (struct uart_port *)dev_id;
> > -   unsigned long flags;
> > -   unsigned int isrstatus, numbytes;
> > -   unsigned int data;
> > -   char status = TTY_NORMAL;
> > +   unsigned int numbytes;
> >
> > -   spin_lock_irqsave(&port->lock, flags);
> > +   if (uart_circ_empty(&port->state->xmit)) {
> > +           writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> > +                  CDNS_UART_IDR_OFFSET);
> > +   } else {
> > +           numbytes = port->fifosize;
> > +           /* Break if no more data available in the UART buffer */
> > +           while (numbytes--) {
> > +                   if (uart_circ_empty(&port->state->xmit))
> > +                           break;
> > +                   /*
> > +                    * Get the data from the UART circular buffer
> > +                    * and write it to the cdns_uart's TX_FIFO
> > +                    * register.
> > +                    */
> > +                   writel(port->state->xmit.buf[port->state->xmit.tail],
> > +                          port->membase + CDNS_UART_FIFO_OFFSET);
> >
> > -   /* Read the interrupt status register to determine which
> > -    * interrupt(s) is/are active.
> > -    */
> > -   isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
> > +                   port->icount.tx++;
> >
> > -   /*
> > -    * There is no hardware break detection, so we interpret framing
> > -    * error with all-zeros data as a break sequence. Most of the time,
> > -    * there's another non-zero byte at the end of the sequence.
> > -    */
> > -   if (isrstatus & CDNS_UART_IXR_FRAMING) {
> > -           while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
> > -                                   CDNS_UART_SR_RXEMPTY)) {
> > -                   if (!readl(port->membase + CDNS_UART_FIFO_OFFSET))
> {
> > -                           port->read_status_mask |=
> CDNS_UART_IXR_BRK;
> > -                           isrstatus &= ~CDNS_UART_IXR_FRAMING;
> > -                   }
> > +                   /*
> > +                    * Adjust the tail of the UART buffer and wrap
> > +                    * the buffer if it reaches limit.
> > +                    */
> > +                   port->state->xmit.tail =
> > +                           (port->state->xmit.tail + 1) &
> > +                                   (UART_XMIT_SIZE - 1);
> >             }
> > -           writel(CDNS_UART_IXR_FRAMING,
> > -                           port->membase + CDNS_UART_ISR_OFFSET);
> > -   }
> >
> > -   /* drop byte with parity error if IGNPAR specified */
> > -   if (isrstatus & port->ignore_status_mask & CDNS_UART_IXR_PARITY)
> > -           isrstatus &= ~(CDNS_UART_IXR_RXTRIG |
> CDNS_UART_IXR_TOUT);
> > +           if (uart_circ_chars_pending(
> > +                           &port->state->xmit) < WAKEUP_CHARS)
> > +                   uart_write_wakeup(port);
> > +   }
> > +}
> >
> > -   isrstatus &= port->read_status_mask;
> > -   isrstatus &= ~port->ignore_status_mask;
> > +/**
> > + * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
> > + * @dev_id: Id of the UART port
> > + * @isrstatus: The interrupt status register value as read
> > + * Return: None
> > + */
> > +static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
> > +{
> > +   struct uart_port *port = (struct uart_port *)dev_id;
> > +   unsigned int data;
> > +   unsigned int framerrprocessed = 0;
> > +   char status = TTY_NORMAL;
> >
> > -   if ((isrstatus & CDNS_UART_IXR_TOUT) ||
> > -           (isrstatus & CDNS_UART_IXR_RXTRIG)) {
> > -           /* Receive Timeout Interrupt */
> > -           while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
> > -                                   CDNS_UART_SR_RXEMPTY)) {
> > -                   data = readl(port->membase +
> CDNS_UART_FIFO_OFFSET);
> > +   while ((readl(port->membase + CDNS_UART_SR_OFFSET) &
> > +           CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
> > +           data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
> > +           port->icount.rx++;
> > +           /*
> > +            * There is no hardware break detection, so we interpret
> > +            * framing error with all-zeros data as a break sequence.
> > +            * Most of the time, there's another non-zero byte at the
> > +            * end of the sequence.
> > +            */
> > +           if (isrstatus & CDNS_UART_IXR_FRAMING) {
> > +                   if (!data) {
> > +                           port->read_status_mask |=
> CDNS_UART_IXR_BRK;
> > +                           framerrprocessed = 1;
> > +                           continue;
> > +                   }
> > +           }
> > +           isrstatus &= port->read_status_mask;
> > +           isrstatus &= ~port->ignore_status_mask;
> >
> > -                   /* Non-NULL byte after BREAK is garbage (99%) */
> > -                   if (data && (port->read_status_mask &
> > -                                           CDNS_UART_IXR_BRK)) {
> > +           if ((isrstatus & CDNS_UART_IXR_TOUT) ||
> > +               (isrstatus & CDNS_UART_IXR_RXTRIG)) {
> > +                   if (data &&
> > +                       (port->read_status_mask & CDNS_UART_IXR_BRK)) {
> >                             port->read_status_mask &=
> ~CDNS_UART_IXR_BRK;
> >                             port->icount.brk++;
> >                             if (uart_handle_break(port))
> > @@ -249,67 +274,56 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
> >                             spin_lock(&port->lock);
> >                     }
> >  #endif
> > -
> > -                   port->icount.rx++;
> > -
> >                     if (isrstatus & CDNS_UART_IXR_PARITY) {
> >                             port->icount.parity++;
> >                             status = TTY_PARITY;
> > -                   } else if (isrstatus & CDNS_UART_IXR_FRAMING) {
> > +                   }
> > +                   if ((isrstatus & CDNS_UART_IXR_FRAMING) &&
> > +                       !framerrprocessed) {
> >                             port->icount.frame++;
> >                             status = TTY_FRAME;
> > -                   } else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
> > +                   }
> > +                   if (isrstatus & CDNS_UART_IXR_OVERRUN) {
> >                             port->icount.overrun++;
> > +                           tty_insert_flip_char(&port->state->port, 0,
> > +                                                TTY_OVERRUN);
> >                     }
> > -
> > -                   uart_insert_char(port, isrstatus,
> CDNS_UART_IXR_OVERRUN,
> > -                                   data, status);
> > +                   tty_insert_flip_char(&port->state->port, data, status);
> >             }
> > -           spin_unlock(&port->lock);
> > -           tty_flip_buffer_push(&port->state->port);
> > -           spin_lock(&port->lock);
> >     }
> > +   spin_unlock(&port->lock);
> > +   tty_flip_buffer_push(&port->state->port);
> > +   spin_lock(&port->lock);
> > +}
> >
> > -   /* Dispatch an appropriate handler */
> > -   if ((isrstatus & CDNS_UART_IXR_TXEMPTY) ==
> CDNS_UART_IXR_TXEMPTY) {
> > -           if (uart_circ_empty(&port->state->xmit)) {
> > -                   writel(CDNS_UART_IXR_TXEMPTY,
> > -                                   port->membase +
> CDNS_UART_IDR_OFFSET);
> > -           } else {
> > -                   numbytes = port->fifosize;
> > -                   /* Break if no more data available in the UART buffer */
> > -                   while (numbytes--) {
> > -                           if (uart_circ_empty(&port->state->xmit))
> > -                                   break;
> > -                           /* Get the data from the UART circular buffer
> > -                            * and write it to the cdns_uart's TX_FIFO
> > -                            * register.
> > -                            */
> > -                           writel(port->state->xmit.buf[
> > -                                           port->state->xmit.tail],
> > -                                   port->membase +
> CDNS_UART_FIFO_OFFSET);
> > -
> > -                           port->icount.tx++;
> > -
> > -                           /* Adjust the tail of the UART buffer and wrap
> > -                            * the buffer if it reaches limit.
> > -                            */
> > -                           port->state->xmit.tail =
> > -                                   (port->state->xmit.tail + 1) &
> > -                                           (UART_XMIT_SIZE - 1);
> > -                   }
> > +/**
> > + * cdns_uart_isr - Interrupt handler
> > + * @irq: Irq number
> > + * @dev_id: Id of the port
> > + *
> > + * Return: IRQHANDLED
> > + */
> > +static irqreturn_t cdns_uart_isr(int irq, void *dev_id) {
> > +   struct uart_port *port = (struct uart_port *)dev_id;
> > +   unsigned int isrstatus;
> >
> > -                   if (uart_circ_chars_pending(
> > -                                   &port->state->xmit) < WAKEUP_CHARS)
> > -                           uart_write_wakeup(port);
> > -           }
> > -   }
> > +   spin_lock(&port->lock);
> >
> > +   /* Read the interrupt status register to determine which
> > +    * interrupt(s) is/are active and clear them.
> > +    */
> > +   isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
> >     writel(isrstatus, port->membase + CDNS_UART_ISR_OFFSET);
> >
> > -   /* be sure to release the lock and tty before leaving */
> > -   spin_unlock_irqrestore(&port->lock, flags);
> > +   if (isrstatus & CDNS_UART_IXR_TXEMPTY) {
> > +           cdns_uart_handle_tx(dev_id);
> > +           isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
> > +   }
> > +   if (isrstatus & CDNS_UART_IXR_MASK)
> > +           cdns_uart_handle_rx(dev_id, isrstatus);
> >
> > +   spin_unlock(&port->lock);
> >     return IRQ_HANDLED;
> >  }
> >
> >



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
