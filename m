From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 00/10] serial: st-asc: Allow handling of RTS line
Date: Fri, 3 Feb 2017 10:10:43 +0100
Message-ID: <20170203091043.GA10386@kroah.com>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170201143145.31962-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 01, 2017 at 02:31:35PM +0000, Lee Jones wrote:
> When hardware flow-control is disabled, manual toggling of the UART's
> reset line (RTS) using userland applications (e.g. stty) is not
> possible, since the ASC IP does not provide this functionality in the
> same was as some other IPs do.  Thus, we have to do this manually.
> 
> This set ensures the correct Pinctrl groups are configured and
> obtained for both manual toggling of the RTS line and for the IP to
> take over the lines when HW flow-control is requested by the user.

I see 2 series that are listed as "v2", which one to take?

I know, I'll drop both and wait for an updated set with all of the acks
added to them...

Please fix up and resend.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
