From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date: Tue, 27 Nov 2018 18:04:48 -0800
Message-ID: <154337068886.88331.5708018437286125025@swboyd.mtv.corp.google.com>
References: <20181127022536.104663-1-ryandcase@chromium.org>
 <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
 <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Quoting Ryan Case (2018-11-27 17:24:44)
> On Tue, Nov 27, 2018 at 4:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Ryan Case (2018-11-26 18:25:36)
> > > Transfers were being divided into device FIFO sized (64 byte max)
> > > operations which would poll for completion within a spin_lock_irqsave=
 /
> > > spin_unlock_irqrestore block. This both made things slow by waiting f=
or
> > > the FIFO to completely drain before adding further data and would also
> > > result in softlocks on large transmissions.
> > >
> > > This patch allows larger transfers with continuous FIFO additions as
> > > space becomes available and removes polling from the interrupt handle=
r.
> > >
> > > Signed-off-by: Ryan Case <ryandcase@chromium.org>
> > > Version: 1
> >
> > I've never seen a Version tag before. Did you manually add this?
> =

> I submitted with patman, this should have been Series-version:

Hmm ok. I'm not aware of this being a kernel idiom so I would remove
this tag before sending.

> =

> >
> > >
> > >         WARN_ON(co->index < 0 || co->index >=3D GENI_UART_CONS_PORTS);
> > >
> > > @@ -465,9 +470,17 @@ static void qcom_geni_serial_console_write(struc=
t console *co, const char *s,
> > >                 }
> > >                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> > >                                                         SE_GENI_M_IRQ=
_CLEAR);
> > > -       }
> > > +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->cur_tx=
_remaining)
> > > +               /* It seems we can interrupt existing transfers unles=
s all data
> >
> > Nitpick: Have /* on a line by itself
> >
> > Is this comment supposed to say "we can't interrupt existing transfers"?
> =

> Nope, comment is correct as is.

Ok. I fail at parsing it then. Perhaps

"It seems we can interrupt existing transfers except for when all data
has been sent"

would make it easier for me to read.

> =

> >
> > >
> > >         __qcom_geni_serial_console_write(uport, s, count);
> > > +
> > > +       if (port->cur_tx_remaining)
> > > +               qcom_geni_serial_setup_tx(uport, port->cur_tx_remaini=
ng);
> >
> > Does this happen? Is the console being used as a tty at the same time?
> =

> Yup, happens quite a bit.

So its being used in both modes at the same time?

> =

> >
> > > +
> > >         if (locked)
> > >                 spin_unlock_irqrestore(&uport->lock, flags);
> > >  }
> > > @@ -701,40 +714,47 @@ static void qcom_geni_serial_handle_rx(struct u=
art_port *uport, bool drop)
> > >         port->handle_rx(uport, total_bytes, drop);
> > >  }
> > >
> > > -static void qcom_geni_serial_handle_tx(struct uart_port *uport)
> > > +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool=
 done,
> > > +               bool active)
> > >  {
> > >         struct qcom_geni_serial_port *port =3D to_dev_port(uport, upo=
rt);
> > >         struct circ_buf *xmit =3D &uport->state->xmit;
> > >         size_t avail;
> > >         size_t remaining;
> > > +       size_t pending;
> > >         int i;
> > >         u32 status;
> > >         unsigned int chunk;
> > >         int tail;
> > > -       u32 irq_en;
> > >
> > > -       chunk =3D uart_circ_chars_pending(xmit);
> > >         status =3D readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STA=
TUS);
> > > -       /* Both FIFO and framework buffer are drained */
> > > -       if (!chunk && !status) {
> > > +
> > > +       /* Complete the current tx command before taking newly added =
data */
> > > +       if (active)
> > > +               pending =3D port->cur_tx_remaining;
> > > +       else
> > > +               pending =3D uart_circ_chars_pending(xmit);
> > > +
> > > +       /* All data has been transmitted and acknowledged as received=
 */
> > > +       if (!pending && !status && done) {
> >
> > Nitpick: status is a poor variable name to test here. I don't understand
> > what this line is doing. Maybe it would help to have another local
> > variable like 'needs_attention'?
> =

> It could be renamed but since this isn't a general file cleanup patch
> I was avoiding non-functional changes. It is the TX_FIFO_STATUS
> register, if non-zero there is still data in the FIFO or related
> activity ongoing.

Ok.

> =

> >
> > >                 qcom_geni_serial_stop_tx(uport);
> > >                 goto out_write_wakeup;
> > >         }
> > >
> > > -       if (!uart_console(uport)) {
> > > -               irq_en =3D readl_relaxed(uport->membase + SE_GENI_M_I=
RQ_EN);
> > > -               irq_en &=3D ~(M_TX_FIFO_WATERMARK_EN);
> > > -               writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMA=
RK_REG);
> > > -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ=
_EN);
> > > -       }
> > > +       avail =3D port->tx_fifo_depth - (status & TX_FIFO_WC);
> > > +       avail *=3D port->tx_bytes_pw;
> > > +       if (avail < 0)
> > > +               avail =3D 0;
> >
> > How can 'avail' be less than 0? It's size_t which is unsigned? If
> > underflow is happening from that subtraction or overflow from the
> > multiply that could be bad but I hope that is impossible.
> =

> I hope underflow is impossible as well. However, if the hardware did
> wind up in a strange state I wanted to err on the side of not throwing
> away data and being able to resume later if things recovered. I can
> remove the defensive checks if that's the custom, otherwise I'll
> update the comparison logic accordingly.

Well it looks like impossible code because an unsigned value can't be
less than zero. So it's not about customs, more about dead code removal.

> =

> >
> > >
> > > -       avail =3D (port->tx_fifo_depth - port->tx_wm) * port->tx_byte=
s_pw;
> > >         tail =3D xmit->tail;
> > > -       chunk =3D min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail)=
, avail);
> > > +       chunk =3D min3((size_t)pending, (size_t)(UART_XMIT_SIZE - tai=
l), avail);
> >
> > Nitpick: If we made 'avail' unsigned int would we be able to drop the
> > casts on this min3() call? This line is quite hard to read.
> =

> Seems they can go away without any changes.

Ok!
