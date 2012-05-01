From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/3] usb: cp210x: Added in support to get and store part
 number
Date: Tue, 01 May 2012 20:16:09 +0400
Message-ID: <4FA00C49.7000105@mvista.com>
References: <1335845210-5147-1-git-send-email-preston.fick@silabs.com> <1335845210-5147-2-git-send-email-preston.fick@silabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61452 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758166Ab2EAQR5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 May 2012 12:17:57 -0400
Received: by lahj13 with SMTP id j13so2566131lah.19
        for <linux-serial@vger.kernel.org>; Tue, 01 May 2012 09:17:56 -0700 (PDT)
In-Reply-To: <1335845210-5147-2-git-send-email-preston.fick@silabs.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Preston Fick <pffick@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, preston.fick@silabs.com

Hello.

On 01-05-2012 8:06, Preston Fick wrote:

> This change gets the part number of the device when the driver is loaded and
> stores it in the private portion of the port structure. This addition will
> allow for part specific functionality to be added to the driver if needed.

> Signed-off-by: Preston Fick<preston.fick@silabs.com>
> ---
>   drivers/usb/serial/cp210x.c |   24 ++++++++++++++++++++++++
>   1 files changed, 24 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index e67ccf3..b3646b8 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
[...]
> @@ -862,6 +874,7 @@ static int cp210x_startup(struct usb_serial *serial)
>   {
>   	struct cp210x_port_private *port_priv;
>   	int i;
> +	unsigned int partNum;
>
>   	/* cp210x buffers behave strangely unless device is reset */
>   	usb_reset_device(serial->dev);
> @@ -876,6 +889,17 @@ static int cp210x_startup(struct usb_serial *serial)
>   		    serial->interface->cur_altsetting->desc.bInterfaceNumber;
>
>   		usb_set_serial_port_data(serial->port[i], port_priv);
> +
> +		/* Get the 1-byte part number of the cp210x device */
> +		usb_control_msg(serial->dev,

    This may involve DMA...

> +			usb_rcvctrlpipe(serial->dev, 0),
> +			CP210X_VENDOR_SPECIFIC,
> +			REQTYPE_DEVICE_TO_HOST,
> +			CP210X_GET_PARTNUM,
> +			port_priv->bInterfaceNumber,
> +			&partNum, 1,

    You can't do DMA to a buffer situated on stack. You should kmalloc() the 
buffer.

> +			USB_CTRL_GET_TIMEOUT);
> +		port_priv->bPartNumber = partNum&  0xFF;
>   	}
>
>   	return 0;

WBR, Sergei
