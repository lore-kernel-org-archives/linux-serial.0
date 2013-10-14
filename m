From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/2] tty/serial: at91: fix uart/usart selection for older
 products
Date: Mon, 14 Oct 2013 15:58:09 +0200
Message-ID: <20131014135809.GF11420@ns203013.ovh.net>
References: <a58fe8bc7fdd128a2f9cf60785f81ebde4c0c247.1381394411.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a58fe8bc7fdd128a2f9cf60785f81ebde4c0c247.1381394411.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Bo Shen <voice.shen@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Josh Wu <josh.wu@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 10:43 Thu 10 Oct     , Nicolas Ferre wrote:
> Since commit 055560b04a8cd063aea916fd083b7aec02c2adb8 (serial: at91:
> distinguish usart and uart) the older products which do not have a
> name field in their register map are unable to use their serial output.
> As the main console output is usually the serial interface (aka DBGU) it
> is pretty unfortunate.
> So, instead of failing during probe() we just silently configure the serial
> peripheral as an uart. It allows us to use these serial outputs.
> The proper solution is proposed in another patch.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index d067285..6b0f75e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1499,7 +1499,7 @@ static void atmel_set_ops(struct uart_port *port)
>  /*
>   * Get ip name usart or uart
>   */
> -static int atmel_get_ip_name(struct uart_port *port)
> +static void atmel_get_ip_name(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  	int name = UART_GET_IP_NAME(port);
> @@ -1518,10 +1518,7 @@ static int atmel_get_ip_name(struct uart_port *port)
>  		atmel_port->is_usart = false;
>  	} else {
		a dev_warn here maybe

usefull to known when we will have a new ip name and not yet wupported

Best Regards,
J.
>  		dev_err(port->dev, "Not supported ip name, set to uart\n");
> -		return -EINVAL;
>  	}
> -
> -	return 0;
>  }
>  
>  /*
> @@ -2405,9 +2402,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	/*
>  	 * Get port name of usart or uart
>  	 */
> -	ret = atmel_get_ip_name(&port->uart);
> -	if (ret < 0)
> -		goto err_add_port;
> +	atmel_get_ip_name(&port->uart);
>  
>  	return 0;
>  
> -- 
> 1.8.2.2
> 
