From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
Date: Tue, 6 Aug 2019 18:20:06 -0700
Message-ID: <CAHQ1cqEHNq9jJfKWKrZ1utbsk8HG4gywuaxNNMFOgFZGULwyEw@mail.gmail.com>
References: <20190805193243.18584-1-andrew.smirnov@gmail.com> <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 5, 2019 at 11:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 5, 2019 at 10:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > The vast majority of the serial drivers check for
> >
> >     uart_tx_stopped(&p->port) || uart_circ_empty(xmit)
> >
> > condition one or more times. Create a dedicated helper function and
> > convert drivers to use it.
>
> Sometimes the arguments are swapped. It means that in case of first
> being false the second is aslo going to be checked.
> So, does ordering have any side effect?
>
> Please, elaborate this in the commit message.
>

Neither  uart_tx_stopped() nor uart_circ_empty() should have any side
effects. I also didn't see any comments indicating that ordering is
important. Is that enough of a justification?

> >  drivers/tty/serial/8250/8250_dma.c          |  2 +-
> >  drivers/tty/serial/8250/8250_omap.c         |  7 +++----
> >  drivers/tty/serial/sc16is7xx.c              |  2 +-
>
> For the drivers I care about (see above) I prefer to see conversion on
> per driver basis. Of course, if Greg is okay with the current, I won't
> object.

I am more than happy to split this any way necessary.

>
> > -               if (uart_tx_stopped(&up->port) ||
> > -                   uart_circ_empty(&up->port.state->xmit)) {
> > +               if (uart_tx_stopped_or_empty(&up->port)) {
>
> Yes, it becomes one line, but...
>
> > -       if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> > -           uart_circ_empty(&uap->port.state->xmit)) {
> > +       if (!(dmacr & UART011_TXDMAE) ||
> > +           uart_tx_stopped_or_empty(&uap->port)) {
>
> ...wouldn't be the case here as well? And perhaps in other places?

Hmm, not sure I am reading this comment right. Are we talking purely
about formatting here? If we are, yeah, I probably can make this into
a single line. Not sure if there any other places like that,
sirfsoc_uart.c perhaps?

Thanks,
Andrey Smirnov
