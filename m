From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk
 is also passed
Date: Mon, 23 Apr 2018 10:06:41 +0200
Message-ID: <20180423080641.GA20149@kroah.com>
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 10, 2018 at 03:33:30PM +0200, Michal Simek wrote:
> Baudrate calculation depends on requested baudrate and uart clock.
> This patch is checking that uartclk is also passed.
> 
> The same logic is used 8250_early.c/init_port function.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index b9b2bc76bcac..a654cda203c7 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
>  	/* only set baud if specified on command line - otherwise
>  	 * assume it has been initialized by a boot loader.
>  	 */
> -	if (device->baud) {
> +	if (port->uartclk && device->baud) {
>  		u32 cd = 0, bdiv = 0;
>  		u32 mr;
>  		int div8;
> -- 
> 1.9.1

This patch conflicts with the previous patch you sent: Subject: [PATCH]
serial: xuartps: Fix the early_console junk character issue

So, which one should I apply?

I've dropped both from my review queue now, please resend the one(s) you
want applied, in a patch series if needed.

thanks,

greg k-h
