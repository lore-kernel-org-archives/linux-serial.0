From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/2] tty/serial: at91: add a fallback option to determine
 uart/usart property
Date: Mon, 14 Oct 2013 15:59:21 +0200
Message-ID: <20131014135921.GG11420@ns203013.ovh.net>
References: <a58fe8bc7fdd128a2f9cf60785f81ebde4c0c247.1381394411.git.nicolas.ferre@atmel.com>
 <64f8f1db6f888456be8ee410a7e9bb9851d070a5.1381394411.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <64f8f1db6f888456be8ee410a7e9bb9851d070a5.1381394411.git.nicolas.ferre@atmel.com>
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
> On older SoC, the "name" field is not filled in the register map.
> Fix the way to figure out if the serial port is an uart or an usart for these
> older products (with corresponding properties).
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 19 ++++++++++++++++++-
>  include/linux/atmel_serial.h      |  1 +
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 6b0f75e..c7d99af 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -99,6 +99,7 @@ static void atmel_stop_rx(struct uart_port *port);
>  #define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_RTOR)
>  #define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATMEL_US_TTGR)
>  #define UART_GET_IP_NAME(port)	__raw_readl((port)->membase + ATMEL_US_NAME)
> +#define UART_GET_IP_VERSION(port) __raw_readl((port)->membase + ATMEL_US_VERSION)
>  
>   /* PDC registers */
>  #define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
> @@ -1503,6 +1504,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  	int name = UART_GET_IP_NAME(port);
> +	u32 version;
>  	int usart, uart;
>  	/* usart and uart ascii */
>  	usart = 0x55534152;
> @@ -1517,7 +1519,22 @@ static void atmel_get_ip_name(struct uart_port *port)
>  		dev_dbg(port->dev, "This is uart\n");
>  		atmel_port->is_usart = false;
>  	} else {
> -		dev_err(port->dev, "Not supported ip name, set to uart\n");
> +		/* fallback for older SoCs: use version field */
> +		version = UART_GET_IP_VERSION(port);
> +		switch (version) {
> +		case 0x302:
> +		case 0x10213:
> +			dev_dbg(port->dev, "This version is usart\n");
> +			atmel_port->is_usart = true;
> +			break;
> +		case 0x203:
> +		case 0x10202:
> +			dev_dbg(port->dev, "This version is uart\n");
> +			atmel_port->is_usart = false;
> +			break;
> +		default:
> +			dev_err(port->dev, "Not supported ip name nor version, set to uart\n");

it's not really an error a dev_warn is more oppropriate
> +		}
>  	}
>  }
>  
> diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
> index be201ca..00beddf 100644
> --- a/include/linux/atmel_serial.h
> +++ b/include/linux/atmel_serial.h
> @@ -125,5 +125,6 @@
>  #define ATMEL_US_IF		0x4c			/* IrDA Filter Register */
>  
>  #define ATMEL_US_NAME		0xf0			/* Ip Name */
> +#define ATMEL_US_VERSION	0xfc			/* Ip Version */
>  
>  #endif
> -- 
> 1.8.2.2
> 
