From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 2/4] tty: serial: qcom_geni_serial: Remove set_rfr_wm()
 and related variables
Date: Fri, 4 Jan 2019 11:04:05 -0800
Message-ID: <CAE=gft4h0bD8yVoQzOenwyL3mjymBDrnpYAwU_p8-nJiDG7RRg@mail.gmail.com>
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-3-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102213636.40866-3-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 2, 2019 at 1:37 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> The variables of tx_wm and rx_wm were set to the same define value in
> all cases, never updated, and the define was sometimes used
> interchangably. Remove the variables/function and use the fixed value.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index dc95b96148ed..5521ed4a0708 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -105,9 +105,6 @@ struct qcom_geni_serial_port {
>         u32 tx_fifo_depth;
>         u32 tx_fifo_width;
>         u32 rx_fifo_depth;
> -       u32 tx_wm;
> -       u32 rx_wm;
> -       u32 rx_rfr;
>         enum geni_se_xfer_mode xfer_mode;
>         bool setup;
>         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> @@ -365,9 +362,7 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
>  static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>                                                         unsigned char c)
>  {
> -       struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> -
> -       writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         qcom_geni_serial_setup_tx(uport, 1);
>         WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_TX_FIFO_WATERMARK_EN, true));
> @@ -579,7 +574,7 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
>                 irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>                 irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
>
> -               writel(port->tx_wm, uport->membase +
> +               writel(DEF_TX_WM, uport->membase +
>                                                 SE_GENI_TX_WATERMARK_REG);
>                 writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>         }
> @@ -852,17 +847,6 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
>                 (port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>  }
>
> -static void set_rfr_wm(struct qcom_geni_serial_port *port)
> -{
> -       /*
> -        * Set RFR (Flow off) to FIFO_DEPTH - 2.
> -        * RX WM level at 10% RX_FIFO_DEPTH.
> -        * TX WM level at 10% TX_FIFO_DEPTH.
> -        */
> -       port->rx_rfr = port->rx_fifo_depth - 2;
> -       port->rx_wm = UART_CONSOLE_RX_WM;
> -       port->tx_wm = DEF_TX_WM;
> -}
>
>  static void qcom_geni_serial_shutdown(struct uart_port *uport)
>  {
> @@ -903,7 +887,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>
>         get_tx_fifo_size(port);
>
> -       set_rfr_wm(port);
>         writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
>         /*
>          * Make an unconditional cancel on the main sequencer to reset
> @@ -916,7 +899,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>                                                 false, true, false);
>         geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
>                                                 false, false, true);
> -       geni_se_init(&port->se, port->rx_wm, port->rx_rfr);
> +       geni_se_init(&port->se, UART_CONSOLE_RX_WM, port->rx_fifo_depth - 2);

It looks like the CONSOLE part of the name was never really correct,
since this is also used by the regular uart_ops as well. You could
optionally fold in a rename of this define in this change.

I was also trying to reason about why that - 2 was there, and if that
should be - UART_CONSOLE_RX_WM. But I don't really get why it's there,
so I can't say for sure that it's conceptually the same value. So I
guess that's fine as is.

Reviewed-by: Evan Green <evgreen@chromium.org>
