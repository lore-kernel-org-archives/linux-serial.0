From: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Moxa UPort 1150 and =?UTF-8?B?UlMtNDIyLzQ4NeKApg==?= what's the
 "proper" way to switch modes
Date: Thu, 29 Jun 2017 20:50:32 +0100
Message-ID: <20170629205032.743ab235@alans-desktop>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
        <20170627090449.GG3025@localhost>
        <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
        <1498565331.30390.5.camel@suse.com>
        <20170628153439.GC17630@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170628153439.GC17630@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

So IMHO there are two cases

1. The configuration is fixed in the hardware - in which case we should
automatically set it in kernel, or from device tree.

2. The configuration is soft - in which case you need an ioctl you can
use on the port to change it - irrespective of whether sysfs also handles
it. For simple permissions reasons and also to avoid races you need that
ioctl.

We intentionally have lots of spare space left to extend the RS485 ioctl,
and we have termiox which contains even more room and historically in
other Unixen dealt with all sorts of weird and wonderful parameters used
on stuff like synchronous ports.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
