From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
Date: Wed, 7 Aug 2019 11:02:07 +0300
Message-ID: <CAHp75VcZr1KmjnA-17sygzdO3P0-tMYNei8x-pH+Fp8oNjo8ww@mail.gmail.com>
References: <20190805193243.18584-1-andrew.smirnov@gmail.com>
 <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com> <CAHQ1cqEHNq9jJfKWKrZ1utbsk8HG4gywuaxNNMFOgFZGULwyEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqEHNq9jJfKWKrZ1utbsk8HG4gywuaxNNMFOgFZGULwyEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 7, 2019 at 4:20 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Mon, Aug 5, 2019 at 11:48 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 5, 2019 at 10:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> > > The vast majority of the serial drivers check for
> > >
> > >     uart_tx_stopped(&p->port) || uart_circ_empty(xmit)
> > >
> > > condition one or more times. Create a dedicated helper function and
> > > convert drivers to use it.
> >
> > Sometimes the arguments are swapped. It means that in case of first
> > being false the second is aslo going to be checked.
> > So, does ordering have any side effect?
> >
> > Please, elaborate this in the commit message.
> >
>
> Neither  uart_tx_stopped() nor uart_circ_empty() should have any side
> effects. I also didn't see any comments indicating that ordering is
> important. Is that enough of a justification?

The problem here is the word 'should' which implies the doubt.
Can you simple check this and elaborate in the commit message, like
"foo() checks X while bar() checks Y which are orthogonal to each
other and thus have no side effect on ordering"?

If it's not the case (for example, one of them does something under
lock, while the other is not, or barriers are in place) then we need
to keep ordering as in the original cases.

(Personally I believe there is no ordering issues, though I didn't
check this to be sure)

> > >  drivers/tty/serial/8250/8250_dma.c          |  2 +-
> > >  drivers/tty/serial/8250/8250_omap.c         |  7 +++----
> > >  drivers/tty/serial/sc16is7xx.c              |  2 +-
> >
> > For the drivers I care about (see above) I prefer to see conversion on
> > per driver basis. Of course, if Greg is okay with the current, I won't
> > object.
>
> I am more than happy to split this any way necessary.

Perhaps the best approach is to introduce a helper (patch 1) and do
few conversions as examples (patches 2-...), probably the ones that
reduce amount of lines.

> > > -               if (uart_tx_stopped(&up->port) ||
> > > -                   uart_circ_empty(&up->port.state->xmit)) {
> > > +               if (uart_tx_stopped_or_empty(&up->port)) {
> >
> > Yes, it becomes one line, but...
> >
> > > -       if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> > > -           uart_circ_empty(&uap->port.state->xmit)) {
> > > +       if (!(dmacr & UART011_TXDMAE) ||
> > > +           uart_tx_stopped_or_empty(&uap->port)) {
> >
> > ...wouldn't be the case here as well? And perhaps in other places?
>
> Hmm, not sure I am reading this comment right. Are we talking purely
> about formatting here? If we are, yeah, I probably can make this into
> a single line.

Yes, it's about pure style (also consider in some cases it's better to
have ~83 character line than split).

> Not sure if there any other places like that,
> sirfsoc_uart.c perhaps?

Maybe, above is the fist of which my eye is stumbled.

-- 
With Best Regards,
Andy Shevchenko
