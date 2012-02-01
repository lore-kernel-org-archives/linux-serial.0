From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] qcserial: log when an interface has too many
 altsettings
Date: Wed, 1 Feb 2012 13:11:16 -0800
Message-ID: <20120201211116.GA30758@kroah.com>
References: <20120201210723.GB16802@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47693 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757591Ab2BAVTv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Feb 2012 16:19:51 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EEB492128A
	for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2012 16:19:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120201210723.GB16802@google.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Tuttle <ttuttle@chromium.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Feb 01, 2012 at 04:07:23PM -0500, Thomas Tuttle wrote:
> Signed-off-by: Thomas Tuttle <ttuttle@chromium.org>
> ---
>  drivers/usb/serial/qcserial.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> index 26e3e30..5a817d6 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -145,8 +145,12 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
>  		/* Gobi 2000 has a single altsetting, older ones have two */
>  		if (serial->interface->num_altsetting == 2)
>  			intf = &serial->interface->altsetting[1];
> -		else if (serial->interface->num_altsetting > 2)
> +		else if (serial->interface->num_altsetting > 2) {
> +			dev_err(&serial->dev->dev,
> +				"too many altsettings: %u",
> +				serial->interface->num_altsetting);

Why would this happen?  And what does spitting out an error do about it?
What are we supposed to do with this information?

thanks,

greg k-h
