From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] 8250_pci: add -ENODEV code for Intel EG20T PCH
Date: Mon, 30 May 2011 15:47:22 +0800
Message-ID: <20110530074722.GA7947@suse.de>
References: <1306741324-4562-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1306741324-4562-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com
List-Id: linux-serial@vger.kernel.org

On Mon, May 30, 2011 at 04:42:04PM +0900, Tomoya MORINAGA wrote:
> Intel EG20T PCH has UART device which is compatible with 8250.
> Currently, with general configuration, the PCH UART driver is not loaded but 8250 standard driver is loaded.
> Therefore, in case of using PCH UART driver, need to disable 8250 pci function.
> However, this procedure is not best solution.
> 
> This patch, in 8250_pci, if the device is the PCH or the family IOH,
> '-ENODEV' is returned.
> As a result, disabling 8250-pci processing becomes unnecessary.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
> ---
>  drivers/tty/serial/8250_pci.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
> index 738cec9..2678d9d 100644
> --- a/drivers/tty/serial/8250_pci.c
> +++ b/drivers/tty/serial/8250_pci.c
> @@ -2559,6 +2559,19 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
>  		return -EINVAL;
>  	}
>  
> +#if defined(CONFIG_SERIAL_PCH_UART) || defined(CONFIG_SERIAL_PCH_UART_MODULE)
> +	if ((dev->vendor == PCI_VENDOR_ID_INTEL && dev->device == 0x8811) ||
> +	   (dev->vendor == PCI_VENDOR_ID_INTEL && dev->device == 0x8812) ||
> +	   (dev->vendor == PCI_VENDOR_ID_INTEL && dev->device == 0x8813) ||
> +	   (dev->vendor == PCI_VENDOR_ID_INTEL && dev->device == 0x8814) ||
> +	   (dev->vendor == 0x10DB && dev->device == 0x8027) ||
> +	   (dev->vendor == 0x10DB && dev->device == 0x8028) ||
> +	   (dev->vendor == 0x10DB && dev->device == 0x8029) ||
> +	   (dev->vendor == 0x10DB && dev->device == 0x800C) ||
> +	   (dev->vendor == 0x10DB && dev->device == 0x800D))
> +		return -ENODEV;
> +#endif

Why put this with an #if around it?  Why not just always not bind to
this driver as we have a "correct" driver for the hardware now?

thanks,

greg k-h
