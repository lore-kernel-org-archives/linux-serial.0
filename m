From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2] drivers/serial/atmel_serial.c: Fix PDC wrap around
 issue
Date: Mon, 24 Jun 2013 19:02:45 +0200
Message-ID: <51C87BB5.8040009@atmel.com>
References: <3D029C603B477F4BAF0E9739E943D3FE08A3EA@DEFTHW99EJ2MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:24028 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3FXRCt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Jun 2013 13:02:49 -0400
In-Reply-To: <3D029C603B477F4BAF0E9739E943D3FE08A3EA@DEFTHW99EJ2MSX.ww902.siemens.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Retallack, Mark" <mark.retallack@siemens.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 20/06/2013 12:30, Retallack, Mark :
> Resubmited using correct format.

Hi Mark,

> We have found a small problem with the Atmel serial driver (drivers/tty/serial/atmel_serial.c) when using PDC. The
> problem showed itself on our system when it is heavily loaded and the softirq's are implemented as threads.
>
> The DMA buffers (2 off) are dynamically allocated when the driver is initialized. The relative location of these
> buffers is down to the whims of the memory allocation software i.e. the buffers could be in contiguous memory or
> separated by a number of bytes.
> What if the buffers are contiguous and the PDC managed to fill both buffers before the handling tasklet could run,
> the tasklet would be unable to identify this condition.
>
> For example:
> Assume DMA buffers A and B are both 0x200 bytes long and reside at addresses 0x100 and 0x300 respectively. Now also
> assume that the PDC has managed to fill both buffers starting with B then moving to A (at which point the PDC
> asserts the ENDRX and RXBUFF flags, resulting in the ENDRX interrupt). At this time the PDC has advanced the RPR to
> one byte beyond the end of buffer A i.e. address 0x200.
> When the tasklet runs, as far as it is concerned it is still processing buffer B. The first thing it does is to
> work out whether the PDC has completely filled buffer B, which it does by subtracting buffer B address from the RPR
> i.e. 0x200 - 0x200 = 0. So the tasklet believes that the buffer is empty rather than actually being full. In this
> event, the tasklet does not update RNPR and RNCR to inform the PDC that buffer B can now be used (side effect of
> which is that the ENDRX and RXBUFF flags remain set). When the tasklet reenables the ENDRX interrupt (when it
> exits) the UART immediately generates an interrupt (based on the ENDRX flag being set). The whole process then
> repeats while no further data is received.

Thanks a lot for this detailed description which nails the issue: it if 
very valuable to have such an example.
Actually, I may need to move the "example" part of your description in 
the comment part of the commit message (ie: after the "---" below).

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I will re-send the message to the tty maintainer.

Thanks, best regards,

> Thanks
> Mark Retallack
>
> Signed-off-by: Mark Retallack <mark.retallack@siemens.com>
> ---
>   drivers/tty/serial/atmel_serial.c |   37 ++++++++++++++++++++++++++++++++-----
>   1 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 3467462..3f1f65b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -121,6 +121,7 @@ struct atmel_dma_buffer {
>          dma_addr_t      dma_addr;
>          unsigned int    dma_size;
>          unsigned int    ofs;
> +       unsigned int    dma_full;
>   };
>
>   struct atmel_uart_char {
> @@ -393,7 +394,7 @@ static void atmel_start_rx(struct uart_port *port)
>          if (atmel_use_dma_rx(port)) {
>                  /* enable PDC controller */
>                  UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> -                       port->read_status_mask);
> +                       ATMEL_US_RXBUFF | port->read_status_mask);
>                  UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
>          } else {
>                  UART_PUT_IER(port, ATMEL_US_RXRDY);
> @@ -411,7 +412,7 @@ static void atmel_stop_rx(struct uart_port *port)
>                  /* disable PDC receive */
>                  UART_PUT_PTCR(port, ATMEL_PDC_RXTDIS);
>                  UART_PUT_IDR(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> -                       port->read_status_mask);
> +                       ATMEL_US_RXBUFF | port->read_status_mask);
>          } else {
>                  UART_PUT_IDR(port, ATMEL_US_RXRDY);
>          }
> @@ -574,15 +575,27 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
>
>          if (atmel_use_dma_rx(port)) {
>                  /*
> +                * Check for PDC full error
> +                */
> +               if (pending & (ATMEL_US_RXBUFF)) {
> +                       int i;
> +                       port->icount.buf_overrun++;
> +                       for (i = 0; i < 2; i++)
> +                               atmel_port->pdc_rx[i].dma_full = 1;
> +               }
> +
> +               /*
>                   * PDC receive. Just schedule the tasklet and let it
>                   * figure out the details.
>                   *
>                   * TODO: We're not handling error flags correctly at
>                   * the moment.
>                   */
> -               if (pending & (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT)) {
> +               if (pending & (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> +                               ATMEL_US_RXBUFF)) {
>                          UART_PUT_IDR(port, (ATMEL_US_ENDRX
> -                                               | ATMEL_US_TIMEOUT));
> +                                               | ATMEL_US_TIMEOUT
> +                                               | ATMEL_US_RXBUFF));
>                          tasklet_schedule(&atmel_port->tasklet);
>                  }
>
> @@ -808,6 +821,19 @@ static void atmel_rx_from_dma(struct uart_port *port)
>                   */
>                  head = min(head, pdc->dma_size);
>
> +               /*
> +                * If we have a RXBUFF set, it means that both buffers are full
> +                * and cannot take anymore data, force a clean.
> +                * This protects against the situation where both buffers
> +                * are full and the head matches the tail because the head
> +                * is pointing to the first byte in the second buffer.
> +                * This makes it look like the current buffer is still empty
> +                */
> +               if (pdc->dma_full) {
> +                       head = pdc->dma_size;
> +                       pdc->dma_full = 0;
> +               }
> +
>                  if (likely(head != tail)) {
>                          dma_sync_single_for_cpu(port->dev, pdc->dma_addr,
>                                          pdc->dma_size, DMA_FROM_DEVICE);
> @@ -852,7 +878,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>          tty_flip_buffer_push(tport);
>          spin_lock(&port->lock);
>
> -       UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
> +       UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT | ATMEL_US_RXBUFF);
>   }
>
>   /*
> @@ -954,6 +980,7 @@ static int atmel_startup(struct uart_port *port)
>                                                         DMA_FROM_DEVICE);
>                          pdc->dma_size = PDC_BUFFER_SIZE;
>                          pdc->ofs = 0;
> +                       pdc->dma_full = 0;
>                  }
>
>                  atmel_port->pdc_rx_idx = 0;
>


-- 
Nicolas Ferre
