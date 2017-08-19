From: Maksim Salau <maksim.salau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: serial: ti_usb_3410_5052: Port uart_mode from
 io_ti.
Date: Sat, 19 Aug 2017 23:40:56 +0300
Message-ID: <20170819234056.37c7d339@gmail.com>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
        <20170818025659.4402-1-stuartl@vrt.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170818025659.4402-1-stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alborchers-2TsfIrYsZRL7O9PZeWXHPg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Stuart,

> This introduces the `uart_mode` sysfs attribute as seen in the `io_ti`
> USB serial driver, allowing this USB serial interface to be switched
> between RS-232, 2-wire RS-485 and 4-wire RS-485.

Recently I've discovered a blog post by Greg Kroah-Hartman on sysfs files [1].
I believe this information will help you to create the new file in a better way.

[1] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

Best regards,
Maksim.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
