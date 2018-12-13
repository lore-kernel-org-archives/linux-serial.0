From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Remove interrupt storm
Date: Thu, 13 Dec 2018 09:36:20 -0800
Message-ID: <CAD=FV=XyG0z3BvDyWiXTNz5mwf3cFH-U9=1fhury9+csW5TVjw@mail.gmail.com>
References: <20181212003522.239189-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212003522.239189-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Dec 11, 2018 at 4:36 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Disable M_TX_FIFO_WATERMARK_EN after we've sent all data for a given
> transaction so we don't continue to receive a flurry of free space
> interrupts while waiting for the M_CMD_DONE notification. Re-enable the
> watermark when establishing the next transaction.
>
> Also clear the watermark interrupt after filling the FIFO so we do not
> receive notification again prior to actually having free space.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 6e38498362ef..965aefa54114 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -724,10 +724,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>         size_t pending;
>         int i;
>         u32 status;
> +       u32 irq_en;
>         unsigned int chunk;
>         int tail;
>
>         status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> +       irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
>
>         /* Complete the current tx command before taking newly added data */
>         if (active)
> @@ -752,6 +754,9 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>         if (!port->tx_remaining) {
>                 qcom_geni_serial_setup_tx(uport, pending);
>                 port->tx_remaining = pending;
> +
> +               irq_en |= M_TX_FIFO_WATERMARK_EN;
> +               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);

I notice other places that turn on the watermark only do so if
"xfer_mode == GENI_SE_FIFO".  ...but it looks as if the mode is always
FIFO mode, so you should be fine.  Probably the right thing to do is
that someone should do a future patch to kill all the "if xfer_mode ==
GENI_SE_FIFO" stuff and if/when someone wants to add DMA then they can
do it from scratch.


>         }
>
>         remaining = chunk;
> @@ -775,7 +780,15 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>         }
>
>         xmit->tail = tail & (UART_XMIT_SIZE - 1);
> +       writel_relaxed(M_TX_FIFO_WATERMARK_EN,
> +                       uport->membase + SE_GENI_M_IRQ_CLEAR);

Worth a comment saying that the watermark is "level-triggered and
latched" so it's obvious why it's not a race (because it will just
re-assert itself) and also why we need to ACK it at the end of the
function (because it'll keep re-latching itself until you put
something in the FIFO)?


> +
>  out_write_wakeup:
> +       if (!port->tx_remaining) {
> +               irq_en &= ~M_TX_FIFO_WATERMARK_EN;
> +               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);

I think you should change this (and probably the other write to
irq_en) to a read/modify/write rather than using the value you read at
the top of the function.  Specifically there are enough helper
functions called that might also be touching irq_en and I'd be worried
that the value you read at the top of the function might not be truth
anymore.  I also wonder if it's worth an "if" test to only do the
writel_relaxed() if the value wasn't already right since sometimes IO
writes can be slow.

If I followed the code correctly, doing the read/modify/write actually
might matter.  The code calls qcom_geni_serial_stop_tx() which _does_
modify irq_en.  Then the code does "goto out_write_wakeup" where it'll
clobber qcom_geni_serial_stop_tx()'s modifications.


> +       }
> +
>         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>                 uart_write_wakeup(uport);
>  }
> @@ -811,8 +824,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>                 tty_insert_flip_char(tport, 0, TTY_OVERRUN);
>         }
>
> -       if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
> -           m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
> +       if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))

Unrelated to everything else in this patch, but seems OK to me.


-Doug
