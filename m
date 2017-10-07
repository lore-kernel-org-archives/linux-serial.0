From: Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 support
Date: Sat, 7 Oct 2017 08:41:14 +0200
Message-ID: <20171007064114.GA19450@kroah.com>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a4051ac2-1156-751d-ec16-2dbbb30b9258-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "bluez mailin list (linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Oct 07, 2017 at 05:16:31PM +1100, Ian W MORRISON wrote:
> The current Kconfig for serdev is not compatible when adding ACPI support as it does not work when built as a module as it requires config SERIAL_DEV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if requiring ACPI support.
> ---
>  drivers/tty/serdev/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> index cdc6b820cf93..a9fb09a9c105 100644
> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -2,7 +2,8 @@
>  # Serial bus device driver configuration
>  #
>  menuconfig SERIAL_DEV_BUS
> -	tristate "Serial device bus"
> +	bool "Serial device bus"
> +	default y
>  	help
>  	  Core support for devices connected via a serial port.
>  
> @@ -11,6 +12,6 @@ if SERIAL_DEV_BUS
>  config SERIAL_DEV_CTRL_TTYPORT
>  	bool "Serial device TTY port controller"
>  	depends on TTY
> -	depends on SERIAL_DEV_BUS != m
> +	default y
>  
>  endif
> -- 
> 2.11.0


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
