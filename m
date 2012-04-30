From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Mon, 30 Apr 2012 16:32:15 -0400
Message-ID: <20120430203215.GA15589@kroah.com>
References: <1335817637-2862-1-git-send-email-preston.fick@silabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335817637-2862-1-git-send-email-preston.fick-S6d6foEdJf7QT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preston Fick <pffick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, preston.fick-S6d6foEdJf7QT0dZR+AlfA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 30, 2012 at 03:27:17PM -0500, Preston Fick wrote:
> This fix contains several changes that allow toggling of GPIO on CP210x
> devices that support it. Changes include:
> * Added in part number support, necessary to see if the connected device
> supports the GPIO functionality
> * Added two IOCTLs and ioctl function to allow GET/SET of GPIO
> * Added in new #defines for partnum support, new USB requests
> * Changed "Config request types" section to contain more correct definitions
> for request recipient

No, please break this out into one-patch-per-change, don't bundle all of
this together into one, as I can't take it as-is, sorry.

Especially with those new ioctls...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
