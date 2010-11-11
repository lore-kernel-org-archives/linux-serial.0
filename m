From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ifx6x60: SPI protocol driver for Infineon 6x60 modem
Date: Thu, 11 Nov 2010 11:56:34 -0800
Message-ID: <20101111195634.GA27040@kroah.com>
References: <20101026131325.4506.1135.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:40697 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301Ab0KKT7H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Nov 2010 14:59:07 -0500
Content-Disposition: inline
In-Reply-To: <20101026131325.4506.1135.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Tue, Oct 26, 2010 at 02:13:52PM +0100, Alan Cox wrote:
> From: Russ Gorby <richardx.r.gorby@intel.com>
> 
> Prototype driver for the IFX6x60 series of SPI attached modems by Jim
> Stanley and Russ Gorby
> 
> Signed-off-by: Russ Gorby <richardx.r.gorby@intel.com>
> 
> [Some reworking and a major cleanup]
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/serial/Kconfig        |    6 
>  drivers/serial/Makefile       |    1 
>  drivers/serial/ifx6x60.c      | 1402 +++++++++++++++++++++++++++++++++++++++++
>  drivers/serial/ifx6x60.h      |  129 ++++
>  include/linux/spi/ifx_modem.h |   14 
>  5 files changed, 1552 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/serial/ifx6x60.c
>  create mode 100644 drivers/serial/ifx6x60.h
>  create mode 100644 include/linux/spi/ifx_modem.h
> 
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index aff9dcd..0b9cc17 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1632,4 +1632,10 @@ config SERIAL_ALTERA_UART_CONSOLE
>  	help
>  	  Enable a Altera UART port to be the system console.
>  
> +config SERIAL_IFX6X60
> +        tristate "SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)"
> +	depends on GPIOLIB && EXPERIMENTAL

You also need to depend on SPI here as well, otherwise the build will
break.

Care to send a follow-up patch that does this?

thanks,

greg k-h
