From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RFC] serial: imx: support an enable-gpio
Date: Mon, 3 Apr 2017 16:51:24 +0200
Message-ID: <20170403145124.mdm5bs7oggvs7xua@pengutronix.de>
References: <1468400495-10471-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1468400495-10471-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 13, 2016 at 11:01:35AM +0200, Uwe Kleine-König wrote:
> A part of my machine looks as follows (simplified):
> 
> ,------------------------.
> | ,---------.            |
> | |  imx25  o--RX----◁---o---
> | |         o--GPIO--'   |
> | `---------'            |
> `------------------------'
> 
> that is, there is a driver on the RX line that must be enabled before
> the UART can be used. (That is necessary because the default mux of the
> RX pad after reset is an output.)
> 
> To represent this in the device tree I do:
> 
> 	pinctrl_uart5: uart5 {
> 		fsl,pins = <
> 			...
> 			MX25_PAD_LBA__UART5_RXD		0x00000000
> 			MX25_PAD_CS5__GPIO_3_21		0x00002001
> 			...
> 	};
> 
> 	&uart5 {
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&pinctrl_uart5>;
> 
> 		enable-gpio = <&gpio3 21 GPIO_ACTIVE_LOW>;
> 		...
> 	};
> 
> This way it's ensured that the gpio is only enabled when the LBA pad is
> muxed as RX (together with the bootloader that sets the GPIO high).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> Hello,
> 
> I'm not sure about the naming. Do you have a better suggestion how to handle
> this situation?
> 
> Best regards
> Uwe
> 
>  drivers/tty/serial/imx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 0df2b1c091ae..56eaa18aa5be 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -39,6 +39,7 @@
>  #include <linux/of_device.h>
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <asm/irq.h>
>  #include <linux/platform_data/serial-imx.h>
> @@ -1987,7 +1988,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
>  	if (of_get_property(np, "fsl,dte-mode", NULL))
>  		sport->dte_mode = 1;
>  
> -	return 0;
> +	ret = PTR_ERR_OR_ZERO(devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_HIGH));
> +	dev_info(&pdev->dev, "Tralala: ret = %d\n", ret);

That line is a debug left over and obviously should be removed. Other
than taht I still wonder if this patch is good enough for mainline as it
solves a real problem.

Best regards
Uwe

> +	return ret;
>  }
>  #else
>  static inline int serial_imx_probe_dt(struct imx_port *sport,
> -- 
> 2.8.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
