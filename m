From: Ryan Case <ryandcase@chromium.org>
Subject: Re: [PATCH v2] tty: serial: qcom_geni_serial: Fix softlock
Date: Thu, 29 Nov 2018 17:51:53 -0800
Message-ID: <CACjz--kkZ-23J9FM0YEiG15kGnOgu0T0gpTsX9X=JJXA3FC=7Q@mail.gmail.com>
References: <20181128235459.180940-1-ryandcase@chromium.org> <CAD=FV=VTkM+mWZX4jS96E0JdpYpW40q_EkGPfvLxWKW==e+JMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VTkM+mWZX4jS96E0JdpYpW40q_EkGPfvLxWKW==e+JMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 29, 2018 at 2:12 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Nov 28, 2018 at 3:55 PM Ryan Case <ryandcase@chromium.org> wrote:
> > @@ -465,9 +470,19 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >                 }
> >                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> >                                                         SE_GENI_M_IRQ_CLEAR);
> > +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
> > +               /*
> > +                * It seems we can interrupt existing transfers unless all data
>
> s/It seems we can interrupt/It seems we can't interrupt/

Comment is correct as is, but will reword to make things clearer.

>
>
> > +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
> > +               bool active)
> >  {
> >         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> >         struct circ_buf *xmit = &uport->state->xmit;
> >         size_t avail;
> >         size_t remaining;
> > +       size_t pending;
> >         int i;
> >         u32 status;
> >         unsigned int chunk;
> >         int tail;
> > -       u32 irq_en;
> >
> > -       chunk = uart_circ_chars_pending(xmit);
> >         status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> > -       /* Both FIFO and framework buffer are drained */
> > -       if (!chunk && !status) {
> > +
> > +       /* Complete the current tx command before taking newly added data */
> > +       if (active)
> > +               pending = port->tx_remaining;
>
> I almost feel like this should be:
>
> if (port->tx_remaining)
>   pending = port->tx_remaining
>
> I could imagine active being false but "port->tx_remaining" being
> non-zero if we happened to take a long time to handle the interrupt
> for some reason.  Presumably you could simulator this and see what
> breaks.  I think what would happen would be "pending" will be larger
> than you expect and you could write a few extra bytes into the FIFO
> causing it to go beyond the length of the transfer you setup.  ...so I
> guess you'd drop some bytes?
>
>
> If it's somehow important for "pending" to be 0 still when we're
> active but port->tx_remaining is non-zero, then I guess you could also
> write it as:
>
> if (active || port->tx_remaining)
>   pending = port->tx_remaining
>
>
> Maybe I'm misunderstanding though.

Yeah, this flag has different behavior on the hardware than you're
expecting. Active will be set for the duration of the command no
matter the size of the transfer or across how many interrupts the
transfer takes, including after we're done on our side
(port->tx_remaining is zero).

>
>
> -Doug
