Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0641BD
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 06:29:07 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rAstd-0005zm-Ee; Wed, 06 Dec 2023 15:29:05 +0100
Message-ID: <243633d4-78b9-4de6-83a9-3d2d4343a24f@pengutronix.de>
Date: Wed, 6 Dec 2023 15:29:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: Fix clock imbalance
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Tom Rix <trix@redhat.com>,
 Shawn Guo <shawnguo@kernel.org>, Sergey Organov <sorganov@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
References: <20231205005108.79782-1-marex@denx.de>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20231205005108.79782-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Hello Marek,

On 05.12.23 01:50, Marek Vasut wrote:
> Disable and unprepare the clock on every exit from probe function
> after the clock were prepared and enabled to avoid enable/disable
> imbalance.

Why not switch the probe function to use devm_clk_get_enabled() instead?

Cheers,
Ahmad

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sergey Organov <sorganov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tom Rix <trix@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/imx.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 52dd8a6b87603..1cce66e5d05d8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2332,10 +2332,8 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = uart_get_rs485_mode(&sport->port);
> -	if (ret) {
> -		clk_disable_unprepare(sport->clk_ipg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_clk;
>  
>  	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
>  	    (!sport->have_rtscts && !sport->have_rtsgpio))
> @@ -2436,7 +2434,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
>  				ret);
> -			return ret;
> +			goto err_clk;
>  		}
>  
>  		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
> @@ -2444,7 +2442,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
>  				ret);
> -			return ret;
> +			goto err_clk;
>  		}
>  
>  		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
> @@ -2452,14 +2450,14 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
>  				ret);
> -			return ret;
> +			goto err_clk;
>  		}
>  	} else {
>  		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
>  				       dev_name(&pdev->dev), sport);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
> -			return ret;
> +			goto err_clk;
>  		}
>  	}
>  
> @@ -2468,6 +2466,10 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, sport);
>  
>  	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
> +
> +err_clk:
> +	clk_disable_unprepare(sport->clk_ipg);
> +	return ret;
>  }
>  
>  static void imx_uart_remove(struct platform_device *pdev)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

