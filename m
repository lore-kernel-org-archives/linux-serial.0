From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 3/5] serial: sprd: Remove unnecessary resource validation
Date: Tue, 4 Sep 2018 14:55:01 +0800
Message-ID: <CAAfSe-tn3o2WusU1uA6G86dHEJKN0hvOmLb5G6J30KHXB56+gw@mail.gmail.com>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <b48edead2c6abb862b121d347b01bf07dec818ea.1533950271.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b48edead2c6abb862b121d347b01bf07dec818ea.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> The devm_ioremap_resource() will valid the resources, thus remove the
> unnecessary resource validation in the driver.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index e18d8af..03b0cd4 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -710,15 +710,12 @@ static int sprd_probe(struct platform_device *pdev)
>                 up->uartclk = clk_get_rate(clk);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "not provide mem resource\n");
> -               return -ENODEV;
> -       }
> -       up->mapbase = res->start;
>         up->membase = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(up->membase))
>                 return PTR_ERR(up->membase);
>
> +       up->mapbase = res->start;
> +
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
>                 dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
> --
> 1.9.1
>
