From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH] tty: serial: Enable uartlite for ARM zynq
Date: Tue, 4 Jun 2013 14:43:51 +0200
Message-ID: <20130604124351.GC5107@pengutronix.de>
References: <26d21aaa1f4a5b3bcae1d82f1524ea53ce9a36bd.1370348438.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <26d21aaa1f4a5b3bcae1d82f1524ea53ce9a36bd.1370348438.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 04, 2013 at 02:20:43PM +0200, Michal Simek wrote:
> Enable it in Kconfig.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e7006f..64250b1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -576,7 +576,7 @@ config SERIAL_IMX_CONSOLE
> 
>  config SERIAL_UARTLITE
>  	tristate "Xilinx uartlite serial port support"
> -	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE
> +	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE || ARCH_ZYNQ
>  	select SERIAL_CORE
>  	help
>  	  Say Y here if you want to use the Xilinx uartlite serial controller.
> --
> 1.8.2.3
> 

Hi!

Doesn't the Zynq use xilinx_uartps ? (which in turn is actually a Cadence UART)

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
