From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] serial: imx-serial - move DMA buffer configuration to DT
Date: Tue, 4 Jul 2017 11:15:30 +0200
Message-ID: <20170704091530.GC21263@kroah.com>
References: <20170628101514.22610-1-romain.perier@collabora.com>
 <20170629182618.jpahpmuq364ldcv2@pengutronix.de>
 <20170703181738.xyxtwe246cfrkyd7@pengutronix.de>
 <20170704074159.GA21747@kroah.com>
 <4d222fcd-184d-92e6-7c9f-370614c23d38@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4d222fcd-184d-92e6-7c9f-370614c23d38-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 04, 2017 at 10:15:23AM +0200, Romain Perier wrote:
> Hello,
> 
> 
> Le 04/07/2017 à 09:41, Greg Kroah-Hartman a écrit :
> > On Mon, Jul 03, 2017 at 08:17:38PM +0200, Uwe Kleine-König wrote:
> >> Hello Greg,
> > Please don't top-post :(
> >
> >> I'm a bit disappointed that you didn't drop this patch. At the time I
> >> sent my review it was still in your tty-testing branch and now it's part
> >> of your pull request for 4.13-rc1 (as commit
> >> a3015affdf76ef279fbbb3710a220bab7e9ea04b). :-|
> > And now it's in Linus's tree! :)
> >
> >> I'm still convinced that this patch is wrong in its current form.
> > Should I revert it, or can I get a fix for it?  Reviewing the patch
> > when it was submitted would have been best, not after it ends up in one
> > of my trees...
> 
> I don't think there is a fix for it. Either you revert the patch and you
> code the fix differently, as I suggested by changing dma_rx_callback...
> but that's more intrusive... or you keep this patch.

I'll revert it after 4.13-rc1 is out, unless there are major objections
to that...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
