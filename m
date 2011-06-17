From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Add new FT232H chip to drivers/usb/serial
Date: Fri, 17 Jun 2011 08:16:24 -0700
Message-ID: <20110617151624.GA14972@kroah.com>
References: <19963.24384.862038.745906@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19963.24384.862038.745906-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 17, 2011 at 04:05:52PM +0200, Uwe Bonnes wrote:
> Hello,
> 
> appended patch adds support for the new FTDI FT232H chip. This chip is a
> single channel version of the dual FT2232H/quad FT4232H, coming with it's
> own default PID 0x6014 (FT2232H uses the same PID 0x6010 like FT2232C,
> FT4232H has also it's own PID). 
> 
> The patch was checked on an UM232H module and a terminal program with TX/RX
> shorted to that typing in the terminal reproduced the characters. The patch
> was written against the running  2.6.37.6 kernel, but applies to git-head
> without errors.
> 
> Please review and let me know(CC) of any problems.

I need a "Signed-off-by:" line before I can accept this type of patch.
Please see the file, Documentation/SubmittingPatches for what that
means.

Care to resend it, with it added to the email, so I can queue it up?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
