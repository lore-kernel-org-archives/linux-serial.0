From: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v3 3/9] serial: Add common rs485 device tree parsing
 function
Date: Tue, 27 Jun 2017 09:40:22 +0200
Message-ID: <6e8bbe02-ce38-4025-73cf-a9ae562ead20@microchip.com>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
 <20170626090803.10981-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170626090803.10981-4-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 26/06/2017 at 11:07, Uwe Kleine-König wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Several drivers have the same device tree parsing code. Create
> a common helper function for it.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> [ukl: implement default <0 0> for rts-delay, unset unspecified flags]
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

> ---
>  drivers/tty/serial/Kconfig  |  4 ++++
>  drivers/tty/serial/Makefile |  2 ++
>  drivers/tty/serial/of.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h | 13 +++++++++++++
>  4 files changed, 66 insertions(+)
>  create mode 100644 drivers/tty/serial/of.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 5c8850f7a2a0..8baef5b95bed 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -14,6 +14,10 @@ config SERIAL_EARLYCON
>  	  the console before standard serial driver is probed. The console is
>  	  enabled when early_param is processed.
>  
> +config OF_SERIAL
> +	depends on SERIAL_CORE
> +	def_bool y
> +
>  source "drivers/tty/serial/8250/Kconfig"
>  
>  comment "Non-8250 serial port support"
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 53c03e005132..0fee8f4e36cb 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
>  
> +obj-$(CONFIG_OF_SERIAL) += of.o
> +
>  # These Sparc drivers have to appear before others such as 8250
>  # which share ttySx minor node space.  Otherwise console device
>  # names change and other unplesantries.
> diff --git a/drivers/tty/serial/of.c b/drivers/tty/serial/of.c
> new file mode 100644
> index 000000000000..b24e4357661b
> --- /dev/null
> +++ b/drivers/tty/serial/of.c
> @@ -0,0 +1,47 @@
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/of.h>
> +#include <linux/serial_core.h>
> +
> +/**
> + * of_get_rs485_mode() - Implement parsing rs485 properties
> + * @np: uart node
> + * @rs485conf: output parameter
> + *
> + * This function implements the device tree binding described in
> + * Documentation/devicetree/bindings/serial/rs485.txt.
> + *
> + * Return: 0 on success, 1 if the node doesn't contain rs485 stuff.
> + */
> +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf)
> +{
> +	u32 rs485_delay[2];
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_OF) || !np)
> +		return 1;
> +
> +	ret = of_property_read_u32_array(np, "rs485-rts-delay" rs485_delay, 2);
> +	if (!ret) {
> +		rs485conf->delay_rts_before_send = rs485_delay[0];
> +		rs485conf->delay_rts_after_send = rs485_delay[1];
> +	} else {
> +		rs485conf->delay_rts_before_send = 0;
> +		rs485conf->delay_rts_after_send = 0;
> +	}
> +
> +	/*
> +	 * clear full-duplex and enabled flags to get to a defined state with
> +	 * the two following properties.
> +	 */
> +	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED);
> +
> +	if (of_property_read_bool(np, "rs485-rx-during-tx"))
> +		rs485conf->flags |= SER_RS485_RX_DURING_TX;
> +
> +	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
> +		rs485conf->flags |= SER_RS485_ENABLED;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_rs485_mode);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 64d892f1e5cd..5ba00b1be093 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -500,4 +500,17 @@ static inline int uart_handle_break(struct uart_port *port)
>  					 (cflag) & CRTSCTS || \
>  					 !((cflag) & CLOCAL))
>  
> +/*
> + * Common device tree parsing helpers
> + */
> +#ifdef CONFIG_OF_SERIAL
> +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf);
> +#else
> +static inline int of_get_rs485_mode(struct device_node *np,
> +				    struct serial_rs485 *rs485conf)
> +{
> +	return 1;
> +}
> +#endif
> +
>  #endif /* LINUX_SERIAL_CORE_H */
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
