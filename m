From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 1/4] tty: serial: qcom_geni_serial: Remove use of
 *_relaxed() and mb()
Date: Fri, 4 Jan 2019 11:03:05 -0800
Message-ID: <CAE=gft4HEZtSDE4dP6Pr3WEoNHi2WS6PaZCDkSp9rAvAkox9Hw@mail.gmail.com>
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-2-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102213636.40866-2-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 2, 2019 at 1:37 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> A frequent side comment has been to remove the use of writel_relaxed,
> readl_relaxed, and mb.

To provide a bit more motivation, you could add something to the
effect of "using the _relaxed variant introduces a significant amount
of complexity when reasoning about the code, and has not been shown to
provide a noticeable performance benefit in the case of this driver",
or something to that effect.

>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 187 +++++++++++---------------
>  1 file changed, 80 insertions(+), 107 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2b1e73193dad..dc95b96148ed 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -230,7 +230,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
>         if (uart_console(uport) || !uart_cts_enabled(uport)) {
>                 mctrl |= TIOCM_CTS;
>         } else {
> -               geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> +               geni_ios = readl(uport->membase + SE_GENI_IOS);
>                 if (!(geni_ios & IO2_DATA_IN))
>                         mctrl |= TIOCM_CTS;
>         }
> @@ -248,7 +248,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>
>         if (!(mctrl & TIOCM_RTS))
>                 uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
> -       writel_relaxed(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
> +       writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
>  }
>
>  static const char *qcom_geni_serial_get_type(struct uart_port *uport)
> @@ -277,9 +277,6 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>         unsigned int fifo_bits;
>         unsigned long timeout_us = 20000;
>
> -       /* Ensure polling is not re-ordered before the prior writes/reads */
> -       mb();
> -
>         if (uport->private_data) {
>                 port = to_dev_port(uport, uport);
>                 baud = port->baud;
> @@ -299,7 +296,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>          */
>         timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
>         while (timeout_us) {
> -               reg = readl_relaxed(uport->membase + offset);
> +               reg = readl(uport->membase + offset);
>                 if ((bool)(reg & field) == set)
>                         return true;
>                 udelay(10);
> @@ -312,7 +309,7 @@ static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
>  {
>         u32 m_cmd;
>
> -       writel_relaxed(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
> +       writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
>         m_cmd = UART_START_TX << M_OPCODE_SHFT;
>         writel(m_cmd, uport->membase + SE_GENI_M_CMD0);
>  }
> @@ -325,13 +322,13 @@ static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
>         done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_CMD_DONE_EN, true);
>         if (!done) {
> -               writel_relaxed(M_GENI_CMD_ABORT, uport->membase +
> +               writel(M_GENI_CMD_ABORT, uport->membase +
>                                                 SE_GENI_M_CMD_CTRL_REG);
>                 irq_clear |= M_CMD_ABORT_EN;
>                 qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                         M_CMD_ABORT_EN, true);
>         }
> -       writel_relaxed(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +       writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  }
>
>  static void qcom_geni_serial_abort_rx(struct uart_port *uport)
> @@ -341,8 +338,8 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
>         writel(S_GENI_CMD_ABORT, uport->membase + SE_GENI_S_CMD_CTRL_REG);
>         qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
>                                         S_GENI_CMD_ABORT, false);
> -       writel_relaxed(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
> -       writel_relaxed(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
> +       writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +       writel(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
>  }
>
>  #ifdef CONFIG_CONSOLE_POLL
> @@ -351,19 +348,13 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
>         u32 rx_fifo;
>         u32 status;
>
> -       status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
> -       writel_relaxed(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
> -
> -       status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
> -       writel_relaxed(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +       status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> +       writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>
> -       /*
> -        * Ensure the writes to clear interrupts is not re-ordered after
> -        * reading the data.
> -        */
> -       mb();
> +       status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> +       writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
>
> -       status = readl_relaxed(uport->membase + SE_GENI_RX_FIFO_STATUS);
> +       status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
>         if (!(status & RX_FIFO_WC_MSK))
>                 return NO_POLL_CHAR;
>
> @@ -376,12 +367,12 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>  {
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>
> -       writel_relaxed(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         qcom_geni_serial_setup_tx(uport, 1);
>         WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_TX_FIFO_WATERMARK_EN, true));
> -       writel_relaxed(c, uport->membase + SE_GENI_TX_FIFOn);
> -       writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
> +       writel(c, uport->membase + SE_GENI_TX_FIFOn);
> +       writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);

I think this could fit on one line now.

>         qcom_geni_serial_poll_tx_done(uport);
>  }
> @@ -390,7 +381,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>  #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
>  static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
>  {
> -       writel_relaxed(ch, uport->membase + SE_GENI_TX_FIFOn);
> +       writel(ch, uport->membase + SE_GENI_TX_FIFOn);
>  }
>
>  static void
> @@ -409,7 +400,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                         bytes_to_send++;
>         }
>
> -       writel_relaxed(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         qcom_geni_serial_setup_tx(uport, bytes_to_send);
>         for (i = 0; i < count; ) {
>                 size_t chars_to_write = 0;
> @@ -427,7 +418,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                 chars_to_write = min_t(size_t, count - i, avail / 2);
>                 uart_console_write(uport, s + i, chars_to_write,
>                                                 qcom_geni_serial_wr_char);
> -               writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
> +               writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);
>                 i += chars_to_write;
>         }
> @@ -456,7 +447,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>         else
>                 spin_lock_irqsave(&uport->lock, flags);
>
> -       geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
> +       geni_status = readl(uport->membase + SE_GENI_STATUS);
>
>         /* Cancel the current write to log the fault */
>         if (!locked) {
> @@ -466,10 +457,10 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>                         geni_se_abort_m_cmd(&port->se);
>                         qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                         M_CMD_ABORT_EN, true);
> -                       writel_relaxed(M_CMD_ABORT_EN, uport->membase +
> +                       writel(M_CMD_ABORT_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);
>                 }
> -               writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> +               writel(M_CMD_CANCEL_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);

This one would also fit on one line now.

>         } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
>                 /*
> @@ -479,9 +470,9 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>                 qcom_geni_serial_poll_tx_done(uport);
>
>                 if (uart_circ_chars_pending(&uport->state->xmit)) {
> -                       irq_en = readl_relaxed(uport->membase +
> +                       irq_en = readl(uport->membase +
>                                         SE_GENI_M_IRQ_EN);

This one too.

> -                       writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
> +                       writel(irq_en | M_TX_FIFO_WATERMARK_EN,
>                                         uport->membase + SE_GENI_M_IRQ_EN);
>                 }
>         }
> @@ -585,12 +576,12 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
>                 if (!qcom_geni_serial_tx_empty(uport))
>                         return;
>
> -               irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
> +               irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>                 irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
>
> -               writel_relaxed(port->tx_wm, uport->membase +
> +               writel(port->tx_wm, uport->membase +
>                                                 SE_GENI_TX_WATERMARK_REG);

This one too, though it looks like you fix that up in a later commit.

> -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +               writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>         }
>  }
>
> @@ -600,35 +591,29 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>         u32 status;
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>
> -       irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
> +       irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &= ~M_CMD_DONE_EN;
>         if (port->xfer_mode == GENI_SE_FIFO) {
>                 irq_en &= ~M_TX_FIFO_WATERMARK_EN;
> -               writel_relaxed(0, uport->membase +
> +               writel(0, uport->membase +
>                                      SE_GENI_TX_WATERMARK_REG);

Here too, though it also appears fixed up by a later commit.

>         }
> -       writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       status = readl_relaxed(uport->membase + SE_GENI_STATUS);
> +       writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +       status = readl(uport->membase + SE_GENI_STATUS);
>         /* Possible stop tx is called multiple times. */
>         if (!(status & M_GENI_CMD_ACTIVE))
>                 return;
>
> -       /*
> -        * Ensure cancel command write is not re-ordered before checking
> -        * the status of the Primary Sequencer.
> -        */
> -       mb();
> -
>         geni_se_cancel_m_cmd(&port->se);
>         if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_CMD_CANCEL_EN, true)) {
>                 geni_se_abort_m_cmd(&port->se);
>                 qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_CMD_ABORT_EN, true);
> -               writel_relaxed(M_CMD_ABORT_EN, uport->membase +
> +               writel(M_CMD_ABORT_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);

Here too.

>         }
> -       writel_relaxed(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +       writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  }
>
>  static void qcom_geni_serial_start_rx(struct uart_port *uport)
> @@ -637,26 +622,20 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>         u32 status;
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>
> -       status = readl_relaxed(uport->membase + SE_GENI_STATUS);
> +       status = readl(uport->membase + SE_GENI_STATUS);
>         if (status & S_GENI_CMD_ACTIVE)
>                 qcom_geni_serial_stop_rx(uport);
>
> -       /*
> -        * Ensure setup command write is not re-ordered before checking
> -        * the status of the Secondary Sequencer.
> -        */
> -       mb();
> -

mmm, good deletes.

With the minor line coalescing fixed you can add my:

Reviewed-by: Evan Green <evgreen@chromium.org>
