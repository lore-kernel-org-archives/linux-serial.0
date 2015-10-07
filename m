From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] tty: serial: men_z135_uart.c: use mcb memory region size instead of hardcoded one
Date: Wed, 07 Oct 2015 11:26:30 +0200
Message-ID: <mqdy4ffm3ll.fsf@linux-x5ow.site>
References: <1444065794-22118-1-git-send-email-andy@wernerandy.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444065794-22118-1-git-send-email-andy@wernerandy.de> (Andreas
	Werner's message of "Mon, 5 Oct 2015 19:23:14 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Werner <andy@wernerandy.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, morbidrsa@gmail.com
List-Id: linux-serial@vger.kernel.org

Andreas Werner <andy@wernerandy.de> writes:

> There is no need to hardcode the MEN_Z135_MEM_SIZE. The MCB subsystem
> already knowns the size which is located in the chameleon table.
> MCB parse the chameleon table to get the resources of each IP and provide
> the mcb_request_mem function to get those resources.
>
> Use mcb_request_mem to get the resources. This function also takes care of
> the memory region naming allocated by the driver for each of the instances.
>
> Signed-off-by: Andreas Werner <andy@wernerandy.de>

Acked-by: Johannes Thumshirn <jthumshirn@suse.de>

> ---
>  drivers/tty/serial/men_z135_uart.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
> index b90e7b3..3141aa2 100644
> --- a/drivers/tty/serial/men_z135_uart.c
> +++ b/drivers/tty/serial/men_z135_uart.c
> @@ -35,8 +35,6 @@
>  #define MEN_Z135_BAUD_REG		0x810
>  #define MEN_Z135_TIMEOUT		0x814
>  
> -#define MEN_Z135_MEM_SIZE		0x818
> -
>  #define IRQ_ID(x) ((x) & 0x1f)
>  
>  #define MEN_Z135_IER_RXCIEN BIT(0)		/* RX Space IRQ */
> @@ -124,6 +122,7 @@ MODULE_PARM_DESC(rx_timeout, "RX timeout. "
>  struct men_z135_port {
>  	struct uart_port port;
>  	struct mcb_device *mdev;
> +	struct resource *mem;
>  	unsigned char *rxbuf;
>  	u32 stat_reg;
>  	spinlock_t lock;
> @@ -734,22 +733,30 @@ static const char *men_z135_type(struct uart_port *port)
>  
>  static void men_z135_release_port(struct uart_port *port)
>  {
> +	struct men_z135_port *uart = to_men_z135(port);
> +
>  	iounmap(port->membase);
>  	port->membase = NULL;
>  
> -	release_mem_region(port->mapbase, MEN_Z135_MEM_SIZE);
> +	mcb_release_mem(uart->mem);
>  }
>  
>  static int men_z135_request_port(struct uart_port *port)
>  {
> -	int size = MEN_Z135_MEM_SIZE;
> +	struct men_z135_port *uart = to_men_z135(port);
> +	struct mcb_device *mdev = uart->mdev;
> +	struct resource *mem;
> +
> +	mem = mcb_request_mem(uart->mdev, dev_name(&mdev->dev));
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
>  
> -	if (!request_mem_region(port->mapbase, size, "men_z135_port"))
> -		return -EBUSY;
> +	port->mapbase = mem->start;
> +	uart->mem = mem;
>  
> -	port->membase = ioremap(port->mapbase, MEN_Z135_MEM_SIZE);
> +	port->membase = ioremap(mem->start, resource_size(mem));
>  	if (port->membase == NULL) {
> -		release_mem_region(port->mapbase, MEN_Z135_MEM_SIZE);
> +		mcb_release_mem(mem);
>  		return -ENOMEM;
>  	}
