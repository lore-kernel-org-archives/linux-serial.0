From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Date: Wed, 9 Oct 2019 08:53:15 +0200
Message-ID: <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello,

On Wed, Oct 09, 2019 at 02:18:31PM +0800, Anson Huang wrote:
> All i.MX SoCs except i.MX1 have ONLY 1 IRQ, so it is better to check
> the IRQ count before getting second/third IRQ to avoid below error
> message during probe:
> 
> [    0.726219] imx-uart 30860000.serial: IRQ index 1 not found
> [    0.731329] imx-uart 30860000.serial: IRQ index 2 not found

This message was introduced in commit
7723f4c5ecdb8d832f049f8483beb0d1081cedf6 for 5.4-rc1. I added the
involved people to the recipents of this mail.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 504d81c..081fa82 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2198,6 +2198,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	u32 ucr1;
>  	struct resource *res;
>  	int txirq, rxirq, rtsirq;
> +	int irq_count;
>  
>  	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
>  	if (!sport)
> @@ -2220,9 +2221,17 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	irq_count = platform_irq_count(pdev);
> +	if (irq_count < 0)
> +		return irq_count;
> +
>  	rxirq = platform_get_irq(pdev, 0);
> -	txirq = platform_get_irq(pdev, 1);
> -	rtsirq = platform_get_irq(pdev, 2);
> +	if (irq_count > 1) {
> +		txirq = platform_get_irq(pdev, 1);
> +		rtsirq = platform_get_irq(pdev, 2);
> +	} else {
> +		txirq = rtsirq = -ENXIO;
> +	}

The patch is fine given the changed behaviour of platform_get_irq. I
wonder if it is sensible to introduce a variant of platform_get_irq (say
platform_get_irq_nowarn) that behaves like __platform_get_irq does
today. Then the imx driver would just call platform_get_irq_nowarn
without having to check the number of available irqs first.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
