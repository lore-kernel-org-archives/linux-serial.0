From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] tty/serial: at91: restore dynamic driver binding
Date: Tue, 23 Feb 2016 14:18:24 -0500
Message-ID: <20160223191823.GN9766@windriver.com>
References: <1456246781-19606-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456246781-19606-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

[[PATCH] tty/serial: at91: restore dynamic driver binding] On 23/02/2016 (Tue 17:59) Romain Izard wrote:

> In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular support
> code for atmel_serial was removed, as the driver cannot be built as a
> module. Because no use case was proposed, the dynamic driver binding
> support was removed as well.
> 
> The atmel_serial driver can manage up to 7 serial controllers, which are
> multiplexed with other functions. For example, in the Atmel SAMA5D2, the
> Flexcom controllers can work as USART, SPI or I2C controllers, and on
> all Atmel devices serial lines can be reconfigured as GPIOs.
> 
> My use case uses GPIOs to transfer a firmware update using a custom
> protocol on the lines used as a serial port during the normal life of
> the device. If it is not possible to unbind the atmel_serial driver, the
> GPIO lines remain reserved and prevent this case from working.
> 
> This patch reinstates the atmel_serial_remove function, and fixes it as
> it failed to clear the "clk" field on removal, triggering an oops when
> a device was bound again after being unbound.

I'd suggest that you add a comment above the remove fcn that gives the
executive summary of the above; i.e. an unbind allows a fw update via
blah blah and hence the .remove makes sense even though the driver is
not modular.

P.
--

> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1c0884d8ef32..59e241723edc 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2759,14 +2759,38 @@ err:
>  	return ret;
>  }
>  
> +static int atmel_serial_remove(struct platform_device *pdev)
> +{
> +	struct uart_port *port = platform_get_drvdata(pdev);
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	int ret = 0;
> +
> +	tasklet_kill(&atmel_port->tasklet);
> +
> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	ret = uart_remove_one_port(&atmel_uart, port);
> +
> +	kfree(atmel_port->rx_ring.buf);
> +
> +	/* "port" is allocated statically, so we shouldn't free it */
> +
> +	clear_bit(port->line, atmel_ports_in_use);
> +
> +	clk_put(atmel_port->clk);
> +	atmel_port->clk = NULL;
> +
> +	return ret;
> +}
> +
>  static struct platform_driver atmel_serial_driver = {
>  	.probe		= atmel_serial_probe,
> +	.remove		= atmel_serial_remove,
>  	.suspend	= atmel_serial_suspend,
>  	.resume		= atmel_serial_resume,
>  	.driver		= {
> -		.name			= "atmel_usart",
> -		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
> -		.suppress_bind_attrs    = true,
> +		.name	= "atmel_usart",
> +		.of_match_table	= of_match_ptr(atmel_serial_dt_ids),
>  	},
>  };
>  
> -- 
> 2.5.0
> 
