From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: serial: ti_usb_3410_5052: Port uart_mode from io_ti.
Date: Mon, 28 Aug 2017 10:56:23 +0200
Message-ID: <20170828085623.GA14599@kroah.com>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170818025659.4402-1-stuartl@vrt.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170818025659.4402-1-stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alborchers-2TsfIrYsZRL7O9PZeWXHPg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 18, 2017 at 12:56:59PM +1000, Stuart Longland wrote:
> This introduces the `uart_mode` sysfs attribute as seen in the `io_ti`
> USB serial driver, allowing this USB serial interface to be switched
> between RS-232, 2-wire RS-485 and 4-wire RS-485.
> 
> /sys/class/tty/ttyUSB${num}/device/uart takes a single integer:
> 
> 	0:	RS-232 mode (default for RS-232-compatible dongles)
> 	1:	RS-485 2w mode (default for RS-485-only dongles)
> 	2:	RS-485 4w mode / RS-422 mode
> 
> Write this *before* opening your serial device.

Please don't create random driver-specific sysfs files for something as
generic as this type of userspace api.

Also, you didn't create a Documentation/ABI/ file describing this, so
even if I wanted to take it, I couldn't :)

Anyway, work on a "real" solution for this for all serial devices
please.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
