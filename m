From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 3/4] tty: serial: qcom_geni_serial: Remove xfer_mode variable
Date: Fri, 4 Jan 2019 11:04:44 -0800
Message-ID: <CAE=gft5Af_y20a1Vh4oTVcizMz6RB_UkuA3CwLWvWwTqRRoNhA@mail.gmail.com>
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-4-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102213636.40866-4-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 2, 2019 at 1:37 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> The driver only supports FIFO mode so setting and checking this variable
> is unnecessary. If DMA support is ever addedd then such checks can be

s/addedd/added/

> introduced.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 66 ++++++++++-----------------
>  1 file changed, 24 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 5521ed4a0708..3103aa0adc86 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -105,7 +105,6 @@ struct qcom_geni_serial_port {
>         u32 tx_fifo_depth;
>         u32 tx_fifo_width;
>         u32 rx_fifo_depth;
> -       enum geni_se_xfer_mode xfer_mode;
>         bool setup;
>         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
>         unsigned int baud;
> @@ -555,29 +554,20 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>  static void qcom_geni_serial_start_tx(struct uart_port *uport)
>  {
>         u32 irq_en;
> -       struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>         u32 status;
>
> -       if (port->xfer_mode == GENI_SE_FIFO) {
> -               /*
> -                * readl ensures reading & writing of IRQ_EN register
> -                * is not re-ordered before checking the status of the
> -                * Serial Engine.
> -                */
> -               status = readl(uport->membase + SE_GENI_STATUS);
> -               if (status & M_GENI_CMD_ACTIVE)
> -                       return;
> +       status = readl(uport->membase + SE_GENI_STATUS);
> +       if (status & M_GENI_CMD_ACTIVE)
> +               return;
>
> -               if (!qcom_geni_serial_tx_empty(uport))
> -                       return;
> +       if (!qcom_geni_serial_tx_empty(uport))
> +               return;
>
> -               irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -               irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> +       irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> +       irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
>
> -               writel(DEF_TX_WM, uport->membase +
> -                                               SE_GENI_TX_WATERMARK_REG);
> -               writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       }
> +       writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
>
>  static void qcom_geni_serial_stop_tx(struct uart_port *uport)
> @@ -588,11 +578,8 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>
>         irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &= ~M_CMD_DONE_EN;
> -       if (port->xfer_mode == GENI_SE_FIFO) {
> -               irq_en &= ~M_TX_FIFO_WATERMARK_EN;
> -               writel(0, uport->membase +
> -                                    SE_GENI_TX_WATERMARK_REG);
> -       }
> +       irq_en &= ~M_TX_FIFO_WATERMARK_EN;

This could be further coalesced into irq_en &= ~(M_CMD_DONE_EN |
M_TX_FIFO_WATERMARK_EN);

Reviewed-by: Evan Green <evgreen@chromium.org>
