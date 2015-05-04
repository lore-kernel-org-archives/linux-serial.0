From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/4] tty: serial: 8250_mtk: use pm_runtime callbacks for enabling
Date: Mon, 4 May 2015 13:05:27 +0200
Message-ID: <CABuKBeJwduxLuyXcy7Ho+k+_Ye3+nHiGvdr8vTFsJzdHDBQPSA@mail.gmail.com>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
	<1430117397-13517-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430117397-13517-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

2015-04-27 8:49 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> The pm_runtime callbacks already enable and disable the device.
> Use them in probe() and remove() instead of duplicating the
> code. This allows us to concentrate more code for enabling/disabling
> the UART in a single place.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 69 ++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index bcfaa8dc..2f28bd0 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -115,6 +115,29 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>                 tty_termios_encode_baud_rate(termios, baud, baud);
>  }
>
> +static int mtk8250_runtime_suspend(struct device *dev)
> +{
> +       struct mtk8250_data *data = dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(data->uart_clk);
> +
> +       return 0;
> +}
> +
> +static int mtk8250_runtime_resume(struct device *dev)
> +{
> +       struct mtk8250_data *data = dev_get_drvdata(dev);
> +       int err;
> +
> +       err = clk_prepare_enable(data->uart_clk);
> +       if (err) {
> +               dev_warn(dev, "Can't enable clock\n");
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
>  static void
>  mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
>  {
> @@ -130,19 +153,12 @@ mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
>  static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
>                            struct mtk8250_data *data)
>  {
> -       int err;
> -
>         data->uart_clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(data->uart_clk)) {
>                 dev_warn(&pdev->dev, "Can't get uart clock\n");
>                 return PTR_ERR(data->uart_clk);
>         }
>
> -       err = clk_prepare_enable(data->uart_clk);
> -       if (err) {
> -               dev_warn(&pdev->dev, "Can't prepare clock\n");
> -               return err;
> -       }
>         p->uartclk = clk_get_rate(data->uart_clk);
>
>         return 0;
> @@ -193,14 +209,18 @@ static int mtk8250_probe(struct platform_device *pdev)
>         writel(0x0, uart.port.membase +
>                         (MTK_UART_RATE_FIX << uart.port.regshift));
>
> -       data->line = serial8250_register_8250_port(&uart);
> -       if (data->line < 0)
> -               return data->line;
> -
>         platform_set_drvdata(pdev, data);
>
> -       pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
> +       if (!pm_runtime_enabled(&pdev->dev)) {
> +               err = mtk8250_runtime_resume(&pdev->dev);
> +               if (err)
> +                       return err;
> +       }
> +
> +       data->line = serial8250_register_8250_port(&uart);
> +       if (data->line < 0)
> +               return data->line;

Why do you delete pm_runtime_set_active here?
