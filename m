From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date: Tue, 27 Nov 2018 16:20:08 -0800
Message-ID: <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
References: <20181127022536.104663-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127022536.104663-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Quoting Ryan Case (2018-11-26 18:25:36)
> Transfers were being divided into device FIFO sized (64 byte max)
> operations which would poll for completion within a spin_lock_irqsave /
> spin_unlock_irqrestore block. This both made things slow by waiting for
> the FIFO to completely drain before adding further data and would also
> result in softlocks on large transmissions.
> =

> This patch allows larger transfers with continuous FIFO additions as
> space becomes available and removes polling from the interrupt handler.
> =

> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> Version: 1

I've never seen a Version tag before. Did you manually add this?

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 7ded51081add..835a184e0b7d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -117,6 +117,8 @@ struct qcom_geni_serial_port {
>         u32 *rx_fifo;
>         u32 loopback;
>         bool brk;
> +
> +       u32 cur_tx_remaining;

Nitpick: Can it just be tx_remaining? And why u32? Why not unsigned int?

>  };
>  =

>  static const struct uart_ops qcom_geni_console_pops;
> @@ -439,6 +441,7 @@ static void qcom_geni_serial_console_write(struct con=
sole *co, const char *s,
>         struct qcom_geni_serial_port *port;
>         bool locked =3D true;
>         unsigned long flags;
> +       unsigned int geni_status;

Nitpick: Use u32 for register reads.

>  =

>         WARN_ON(co->index < 0 || co->index >=3D GENI_UART_CONS_PORTS);
>  =

> @@ -465,9 +470,17 @@ static void qcom_geni_serial_console_write(struct co=
nsole *co, const char *s,
>                 }
>                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLE=
AR);
> -       }
> +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->cur_tx_rem=
aining)
> +               /* It seems we can interrupt existing transfers unless al=
l data

Nitpick: Have /* on a line by itself

Is this comment supposed to say "we can't interrupt existing transfers"?

> +                * has been sent, in which case we need to look for done =
first.
> +                */
> +               qcom_geni_serial_poll_tx_done(uport);

Another nitpick: Please put braces around multi-line if branches for
greater code clarity.

>  =

>         __qcom_geni_serial_console_write(uport, s, count);
> +
> +       if (port->cur_tx_remaining)
> +               qcom_geni_serial_setup_tx(uport, port->cur_tx_remaining);

Does this happen? Is the console being used as a tty at the same time?

> +
>         if (locked)
>                 spin_unlock_irqrestore(&uport->lock, flags);
>  }
> @@ -701,40 +714,47 @@ static void qcom_geni_serial_handle_rx(struct uart_=
port *uport, bool drop)
>         port->handle_rx(uport, total_bytes, drop);
>  }
>  =

> -static void qcom_geni_serial_handle_tx(struct uart_port *uport)
> +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool don=
e,
> +               bool active)
>  {
>         struct qcom_geni_serial_port *port =3D to_dev_port(uport, uport);
>         struct circ_buf *xmit =3D &uport->state->xmit;
>         size_t avail;
>         size_t remaining;
> +       size_t pending;
>         int i;
>         u32 status;
>         unsigned int chunk;
>         int tail;
> -       u32 irq_en;
>  =

> -       chunk =3D uart_circ_chars_pending(xmit);
>         status =3D readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> -       /* Both FIFO and framework buffer are drained */
> -       if (!chunk && !status) {
> +
> +       /* Complete the current tx command before taking newly added data=
 */
> +       if (active)
> +               pending =3D port->cur_tx_remaining;
> +       else
> +               pending =3D uart_circ_chars_pending(xmit);
> +
> +       /* All data has been transmitted and acknowledged as received */
> +       if (!pending && !status && done) {

Nitpick: status is a poor variable name to test here. I don't understand
what this line is doing. Maybe it would help to have another local
variable like 'needs_attention'?

>                 qcom_geni_serial_stop_tx(uport);
>                 goto out_write_wakeup;
>         }
>  =

> -       if (!uart_console(uport)) {
> -               irq_en =3D readl_relaxed(uport->membase + SE_GENI_M_IRQ_E=
N);
> -               irq_en &=3D ~(M_TX_FIFO_WATERMARK_EN);
> -               writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMARK_R=
EG);
> -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       }
> +       avail =3D port->tx_fifo_depth - (status & TX_FIFO_WC);
> +       avail *=3D port->tx_bytes_pw;
> +       if (avail < 0)
> +               avail =3D 0;

How can 'avail' be less than 0? It's size_t which is unsigned? If
underflow is happening from that subtraction or overflow from the
multiply that could be bad but I hope that is impossible.

>  =

> -       avail =3D (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
>         tail =3D xmit->tail;
> -       chunk =3D min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), av=
ail);
> +       chunk =3D min3((size_t)pending, (size_t)(UART_XMIT_SIZE - tail), =
avail);

Nitpick: If we made 'avail' unsigned int would we be able to drop the
casts on this min3() call? This line is quite hard to read.

>         if (!chunk)
>                 goto out_write_wakeup;
>  =

> -       qcom_geni_serial_setup_tx(uport, chunk);
> +       if (!port->cur_tx_remaining) {
> +               qcom_geni_serial_setup_tx(uport, pending);
> +               port->cur_tx_remaining =3D pending;
> +       }
>  =

>         remaining =3D chunk;
>         for (i =3D 0; i < chunk; ) {
> @@ -767,6 +786,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void=
 *dev)
>  {
>         unsigned int m_irq_status;
>         unsigned int s_irq_status;
> +       unsigned int geni_status;

Nitpick: I guess this driver isn't using u32 for registers already.
Would be nice to mop this up in another patch.

>         struct uart_port *uport =3D dev;
>         unsigned long flags;
>         unsigned int m_irq_en;
>=20
