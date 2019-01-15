From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] tty: serial: meson: if no alias specified use an
 available id
Date: Tue, 15 Jan 2019 10:35:25 +0100
Message-ID: <0186aad7-24fa-a6bd-ac52-845325d74b6f@baylibre.com>
References: <1547484866-3600-1-git-send-email-lollivier@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547484866-3600-1-git-send-email-lollivier@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Loys Ollivier <lollivier@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 14/01/2019 17:54, Loys Ollivier wrote:
> At probe, the uart driver tries to get an id from a device tree alias.
> When no alias was specified, the driver would return an error and probing
> would fail.
> 
> Providing an alias for registering a serial device should not be mandatory.
> If the device tree does not specify an alias, provide an id from a reserved
> range so that the probing can continue.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>  drivers/tty/serial/meson_uart.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 8a842591b37c..fbc5bc022a39 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -72,7 +72,8 @@
>  #define AML_UART_BAUD_USE		BIT(23)
>  #define AML_UART_BAUD_XTAL		BIT(24)
>  
> -#define AML_UART_PORT_NUM		6
> +#define AML_UART_PORT_NUM		12
> +#define AML_UART_PORT_OFFSET		6
>  #define AML_UART_DEV_NAME		"ttyAML"
>  
>  
> @@ -654,10 +655,20 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	struct resource *res_mem, *res_irq;
>  	struct uart_port *port;
>  	int ret = 0;
> +	int id = -1;
>  
>  	if (pdev->dev.of_node)
>  		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
>  
> +	if (pdev->id < 0) {
> +		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
> +			if (!meson_ports[id]) {
> +				pdev->id = id;
> +				break;
> +			}
> +		}
> +	}
> +
>  	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
>  		return -EINVAL;
>  
> 

This is welcome !

You could also add:
Suggested-by: Rob Herring <robh@kernel.org>

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
