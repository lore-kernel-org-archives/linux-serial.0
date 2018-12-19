From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix UART hang
Date: Wed, 19 Dec 2018 15:01:47 -0800
Message-ID: <CAD=FV=XiMEUjyZ7E1pHLCfhpe5wzfq8e0EHL5DXpr2dKk6wsJA@mail.gmail.com>
References: <20181219203353.172335-1-ryandcase@chromium.org> <CAE=gft4=gK5Ge_BOMN4dov=b978dXbTBZ2KPDuGxCP=CvgLd2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4=gK5Ge_BOMN4dov=b978dXbTBZ2KPDuGxCP=CvgLd2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Ryan Case <ryandcase@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On Wed, Dec 19, 2018 at 2:12 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Wed, Dec 19, 2018 at 12:34 PM Ryan Case <ryandcase@chromium.org> wrote:
> >
> > If a serial console write occured while a UART transmit command was
> > waiting for a done signal then no further data would be sent until
> > something new kicked the system into gear. If there is already data
> > waiting in the circular buffer we must re-enable the tx watermark so we
> > receive the expected interrupts.
> >
> > Signed-off-by: Ryan Case <ryandcase@chromium.org>
> > ---
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 0c93beb69e73..a694a47747c7 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -442,6 +442,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >         bool locked = true;
> >         unsigned long flags;
> >         u32 geni_status;
> > +       u32 irq_en;
> >
> >         WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
> >
> > @@ -476,6 +477,13 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >                  * has been sent, in which case we need to look for done first.
> >                  */
> >                 qcom_geni_serial_poll_tx_done(uport);
> > +
> > +               if (uart_circ_chars_pending(&uport->state->xmit)) {
> > +                       irq_en = readl_relaxed(uport->membase +
> > +                                       SE_GENI_M_IRQ_EN);
> > +                       writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
> > +                                       uport->membase + SE_GENI_M_IRQ_EN);
>
> The _relaxed part of it has always been weird to me, but I guess we
> fought that battle awhile ago with this driver and lost.
>
> I suppose the only real danger with relaxed would be if you could get
> yourself into some sort of tight loop or idle where the CPU's write
> queue never flushes, but you needed it to in order to proceed. This
> probably could never happen, especially with locks around consoles and
> uart ports that act as barriers.

Yeah.  IMO we should go through and remove all the "_relaxed" from
this driver until someone can prove that it's important for
performance.  ...but I think that's for a future patch to do.

-Doug
