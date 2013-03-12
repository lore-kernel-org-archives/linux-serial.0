From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] allow alternative name for PXA serial console
Date: Tue, 12 Mar 2013 16:10:54 -0700
Message-ID: <20130312231054.GA6379@kroah.com>
References: <1363129342-24310-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363129342-24310-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Yanovich <ynvich@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 13, 2013 at 03:02:22AM +0400, Sergey Yanovich wrote:
> ICP DAS LP-8x4x is an industrial data acquision device. It is based
> on PXA270 CPU. The board containsi a lot of (up to 36) standard UARTi
> 8250i serial ports. System console on the board is provided with
> an on-chip PXA serial port. Both modules use /dev/ttyS0 by default.
> 
> To solve the collision, PXA ports could be configured with different
> name and device numbers.
> 
> Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
> ---
>  drivers/tty/serial/Kconfig |   14 ++++++++++++++
>  drivers/tty/serial/pxa.c   |   22 ++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 59c23d0..09cf980 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -406,6 +406,20 @@ config SERIAL_PXA_CONSOLE
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>  
> +config SERIAL_PXA_TTYSA_NAME
> +	bool "as /dev/ttySA[0-3]"

Does that config text really make sense?  What does it look like when
you run "make oldconfig"?

> +	depends on SERIAL_PXA
> +	default N
> +	help
> +	  If you have enabled the serial port on the Intel XScale PXA
> +	  CPU you can make it appear as /dev/ttySA[0-3] in the system.
> +
> +	  If you say N here (default), the ports will use UART /dev/ttyS[0-3]
> +	  names and corresponding major and minor devices numbers.
> +
> +	  If you say Y here, the ports will have SA-1100 style names and
> +	  numbers. It is reqired at least for one PXA based device.

Ugh, why does it matter what it is named?

Use udev, or a tool like it, to rename serial ports if you really need
it, don't do this in the kernel please.

thanks,

greg k-h
