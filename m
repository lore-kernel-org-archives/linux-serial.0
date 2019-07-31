From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 19/24] tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
Date: Tue, 30 Jul 2019 19:09:25 -0700
Message-ID: <CAHQ1cqHJzmgcpd3SmchygNiOVGNCHWKZvwHcEBEWweboOiZu0w@mail.gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-20-andrew.smirnov@gmail.com> <20190730155608.GA3990@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730155608.GA3990@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 30, 2019 at 8:56 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 29, 2019 at 12:52:21PM -0700, Andrey Smirnov wrote:
> > Code configure DMA TX path in lpuart_startup(), lpuart32_startup() and
> > lpuart_resume() is doing exactly the same thing, so move it into a
> > standalone subroutine.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 53 ++++++++++++++-------------------
> >  1 file changed, 23 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> > index 2ad5750fe511..558acf29cbed 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1434,6 +1434,26 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
> >       add_timer(&sport->lpuart_timer);
> >  }
> >
> > +static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> > +{
> > +     u32 uartbaud;
> > +
> > +     if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> > +             init_waitqueue_head(&sport->dma_wait);
> > +             sport->lpuart_dma_tx_use = true;
> > +             if (lpuart_is_32(sport)) {
> > +                     uartbaud = lpuart32_read(&sport->port, UARTBAUD);
> > +                     lpuart32_write(&sport->port,
> > +                                    uartbaud | UARTBAUD_TDMAE, UARTBAUD);
> > +             } else {
> > +                     writeb(readb(sport->port.membase + UARTCR5) |
> > +                             UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> > +             }
> > +     } else {
> > +             sport->lpuart_dma_tx_use = false;
> > +     }
> > +}
> > +
> >  static int lpuart_startup(struct uart_port *port)
> >  {
> >       struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
> > @@ -1471,14 +1491,7 @@ static int lpuart_startup(struct uart_port *port)
> >               sport->lpuart_dma_rx_use = false;
> >       }
> >
> > -     if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
> > -             init_waitqueue_head(&sport->dma_wait);
> > -             sport->lpuart_dma_tx_use = true;
> > -             temp = readb(port->membase + UARTCR5);
> > -             writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
> > -     } else {
> > -             sport->lpuart_dma_tx_use = false;
> > -     }
> > +     lpuart_tx_dma_startup(port);
> >
> >       spin_unlock_irqrestore(&sport->port.lock, flags);
> >
> > @@ -1522,14 +1535,7 @@ static int lpuart32_startup(struct uart_port *port)
> >               sport->lpuart_dma_rx_use = false;
> >       }
> >
> > -     if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
> > -             init_waitqueue_head(&sport->dma_wait);
> > -             sport->lpuart_dma_tx_use = true;
> > -             temp = lpuart32_read(&sport->port, UARTBAUD);
> > -             lpuart32_write(&sport->port, temp | UARTBAUD_TDMAE, UARTBAUD);
> > -     } else {
> > -             sport->lpuart_dma_tx_use = false;
> > -     }
> > +     lpuart_tx_dma_startup(port);
> >
> >       if (sport->lpuart_dma_rx_use) {
> >               /* RXWATER must be 0 */
> > @@ -2581,20 +2587,7 @@ static int lpuart_resume(struct device *dev)
> >               }
> >       }
> >
> > -     if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> > -             init_waitqueue_head(&sport->dma_wait);
> > -             sport->lpuart_dma_tx_use = true;
> > -             if (lpuart_is_32(sport)) {
> > -                     temp = lpuart32_read(&sport->port, UARTBAUD);
> > -                     lpuart32_write(&sport->port,
> > -                                    temp | UARTBAUD_TDMAE, UARTBAUD);
> > -             } else {
> > -                     writeb(readb(sport->port.membase + UARTCR5) |
> > -                             UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> > -             }
> > -     } else {
> > -             sport->lpuart_dma_tx_use = false;
> > -     }
> > +     lpuart_tx_dma_startup(sport);
> >
> >       if (lpuart_is_32(sport)) {
> >               if (sport->lpuart_dma_rx_use) {
> > --
> > 2.21.0
> >
>
> This patch breaks the build:
>
> drivers/tty/serial/fsl_lpuart.c: In function lpuart_startup:
> drivers/tty/serial/fsl_lpuart.c:1494:24: error: passing argument 1 of lpuart_tx_dma_startup from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1494 |  lpuart_tx_dma_startup(port);
>       |                        ^~~~
>       |                        |
>       |                        struct uart_port *
> drivers/tty/serial/fsl_lpuart.c:1438:55: note: expected struct lpuart_port * but argument is of type struct uart_port *
>  1438 | static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>       |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
> drivers/tty/serial/fsl_lpuart.c: In function lpuart32_startup:
> drivers/tty/serial/fsl_lpuart.c:1537:24: error: passing argument 1 of lpuart_tx_dma_startup from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1537 |  lpuart_tx_dma_startup(port);
>       |                        ^~~~
>       |                        |
>       |                        struct uart_port *
> drivers/tty/serial/fsl_lpuart.c:1438:55: note: expected struct lpuart_port * but argument is of type struct uart_port *
>  1438 | static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>       |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
> cc1: some warnings being treated as errors
>
>
> So I've stopped applying the series here.
>
> Please fix up and resend the remaining ones.
>

Ugh, my bad, sorry about that. Will do in v2.

Thanks,
Andrey Smirnov
