From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: i.MX: do not allow to build as module
Date: Mon, 7 Oct 2013 19:06:36 -0700
Message-ID: <20131008020636.GA32733@kroah.com>
References: <1381149872-13646-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36047 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab3JHCT6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 22:19:58 -0400
Content-Disposition: inline
In-Reply-To: <1381149872-13646-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: s.hauer@pengutronix.de, linux@roeck-us.net, linux-serial@vger.kernel.org

On Mon, Oct 07, 2013 at 09:44:32AM -0300, Fabio Estevam wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
> call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
> built as module, yet add_preferred_console() is not exported.
> 
> Fix the build failure by disabling module build for the i.MX driver.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 701ca60..47a05fd 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
>  	  Enable hardware flow control in the driver.
>  
>  config SERIAL_IMX
> -	tristate "IMX serial port support"
> +	bool "IMX serial port support"

No, please don't force this driver to be built into the kernel.  Do the
same as other drivers, and have a SERIAL_IMX_CONSOLE option, that splits
the code for the console layer out of the driver to only be built when
this option is selected.  Lots of other serial drivers do this, and they
depend on when the driver is built into the kernel.  Otherwise I, and
lots of other people (and distros), will NOT build this driver and test
it out.

sorry, I can't take this patch, and for now, I'm going to revert the
commit that is causing the build error, as we can't live with that for
now.

greg k-h
