From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] Add support of TI ICDI to USB simple serial device
Date: Mon, 12 Nov 2018 10:17:20 +0100
Message-ID: <20181112091720.GC13311@localhost>
References: <20181026113807.20735-1-dscao999@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181026113807.20735-1-dscao999@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dashi Cao <dscao999@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 26, 2018 at 07:38:07PM +0800, Dashi Cao wrote:
> TI In-Circuit Debug Interface (ICDI) is a debugging interface for TI ARM microcontrollers. It has four USB interfaces and the first two of them are presented as standard ACM serial device. The 3rd interface is the debugging interface and it can be driven as a Linux USB simple serial device. With it, debugging sessions and firmware up/down loading are supported on Linux.

Please break your lines at 72 column or so.

And use the common subject prefix (e.g. "USB: serial: add support
of TI ICD...").

> Signed-off-by: Dashi Cao <dscao999@gmail.com>

You never replied to Felipe's question whether you had verified that this
doesn't break OpenOCD?

> ---
>  drivers/usb/serial/usb-serial-simple.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> index 4d0273508043..ae43088b659e 100644
> --- a/drivers/usb/serial/usb-serial-simple.c
> +++ b/drivers/usb/serial/usb-serial-simple.c
> @@ -109,6 +109,11 @@ DEVICE(suunto, SUUNTO_IDS);
>  	{ USB_DEVICE(0x908, 0x0004) }
>  DEVICE(siemens_mpi, SIEMENS_IDS);
>  
> +/* TI In-Circuit Debug Interface */
> +#define ICDI_IDS()              \
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1cbe, 0x00fd, USB_CLASS_VENDOR_SPEC) }
> +DEVICE(ti_icdi, ICDI_IDS);

Please use a TI_ prefix for ICDI_IDS as well.

Can you post the lsusb -v output (or usb-devices) for the device for
reference?

> +
>  /* All of the above structures mushed into two lists */
>  static struct usb_serial_driver * const serial_drivers[] = {
>  	&carelink_device,
> @@ -124,6 +129,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  	&hp4x_device,
>  	&suunto_device,
>  	&siemens_mpi_device,
> +	&ti_icdi_device,
>  	NULL
>  };
>  
> @@ -141,6 +147,7 @@ static const struct usb_device_id id_table[] = {
>  	HP4X_IDS(),
>  	SUUNTO_IDS(),
>  	SIEMENS_IDS(),
> +	ICDI_IDS(),
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);

Thanks,
Johan
