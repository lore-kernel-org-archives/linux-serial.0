From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: serial: 8250: Fix type field in format string
Date: Mon, 29 Apr 2019 16:31:17 +0200
Message-ID: <20190429143117.GA1474@kroah.com>
References: <20190427091943.GA3810@haolee.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190427091943.GA3810@haolee.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Hao Lee <haolee.swjtu@gmail.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 27, 2019 at 05:19:43PM +0800, Hao Lee wrote:
> The dev_dbg statement should print the value of uart.port.mapbase instead
> of its address. Besides that, uart.port.irq and uart.port.iotype are all
> unsigned types, so using %u is more appropriate.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pnp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
> index 431e69a5a6a0..9dea11baf479 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -462,8 +462,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  		return -ENODEV;
>  
>  	dev_dbg(&dev->dev,
> -		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
> -		 uart.port.iobase, &uart.port.mapbase,
> +		 "Setup PNP port: port %#lx, mem %#lx, irq %u, type %u\n",
> +		 uart.port.iobase, uart.port.mapbase,
>  		 uart.port.irq, uart.port.iotype);
>  
>  	if (flags & CIR_PORT) {
> -- 
> 2.14.5

This causes build warnings when applied, I'm having to drop it now.

Please be more careful, when submitting patches, always test-build them
first.

greg k-h
