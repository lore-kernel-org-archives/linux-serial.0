From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial: New serial driver SCCNXP
Date: Wed, 5 Sep 2012 13:24:33 -0700
Message-ID: <20120905202433.GA23267@kroah.com>
References: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46368 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab2IEU1H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 16:27:07 -0400
Received: by dady13 with SMTP id y13so599733dad.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Sep 2012 13:27:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Sat, Aug 25, 2012 at 07:24:19PM +0400, Alexander Shiyan wrote:
> This driver is a replacement for a SC26XX driver with a lot of
> improvements and new features.
> The main differences from the SC26XX driver:
> - Removed dependency on MIPS. Driver can be used on any platform.
> - Added support for SCC2681, SCC2691, SCC2692, SC28L91, SC28L92,
>   SC28L202, SCC68681 and SCC68692 ICs.
> - Using devm_-related functions.
> - Improved error handling of serial port, improved FIFO handling.
> - Ability to load multiple instances of drivers.
> 
> To avoid the possibility of regression, driver SC26XX left in the
> system to confirm the stability of the driver on platforms where
> it is being used.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/tty/serial/Kconfig           |   18 +
>  drivers/tty/serial/Makefile          |    1 +
>  drivers/tty/serial/sccnxp.c          |  985 ++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/sccnxp.h |   93 ++++
>  4 files changed, 1097 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/tty/serial/sccnxp.c
>  create mode 100644 include/linux/platform_data/sccnxp.h
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4720b4b..750671d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1104,6 +1104,24 @@ config SERIAL_SC26XX_CONSOLE
>  	help
>  	  Support for Console on SC2681/SC2692 serial ports.
>  
> +config SERIAL_SCCNXP
> +	bool "SCCNXP serial port support"
> +	depends on !SERIAL_SC26XX
> +	select SERIAL_CORE
> +	default n
> +	help
> +	  This selects support for an advanced UART from NXP (Philips).
> +	  Supported ICs are SCC2681, SCC2691, SCC2692, SC28L91, SC28L92,
> +	  SC28L202, SCC68681 and SCC68692.
> +	  Positioned as a replacement for the driver SC26XX.

This driver can be built as a module, right?  If so, please change this
to a tristate variable, not a "bool".  I don't feel like always building
it into my kernels :)

Care to send a follow-on patch fixing this up?

thanks,

greg k-h
