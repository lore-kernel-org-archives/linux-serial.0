From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] serial: imx-serial - move DMA buffer configuration to DT
Date: Tue, 4 Jul 2017 10:13:25 +0200
Message-ID: <20170704081325.vvyn7meq3i5e6tfl@pengutronix.de>
References: <20170628101514.22610-1-romain.perier@collabora.com>
 <20170629182618.jpahpmuq364ldcv2@pengutronix.de>
 <20170703181738.xyxtwe246cfrkyd7@pengutronix.de>
 <20170704074159.GA21747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170704074159.GA21747-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 04, 2017 at 09:41:59AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 03, 2017 at 08:17:38PM +0200, Uwe Kleine-König wrote:
> > Hello Greg,
> 
> Please don't top-post :(

I only kept the mail for reference, as I didn't reply to specific stuff
in the mail I consider writing my stuff at the top of the mail ok (and
even better than below the mail because you don't need to scroll down to
see what I wrote and I think I gave enough context).

> > I'm a bit disappointed that you didn't drop this patch. At the time I
> > sent my review it was still in your tty-testing branch and now it's part
> > of your pull request for 4.13-rc1 (as commit
> > a3015affdf76ef279fbbb3710a220bab7e9ea04b). :-|
> 
> And now it's in Linus's tree! :)

Should I better answer to the pull request mail next time?

> > I'm still convinced that this patch is wrong in its current form.
> 
> Should I revert it, or can I get a fix for it?

I'd say revert for now. At least it's not clear to me how it should be
fixed as the property added to dt shouldn't be there (given my
current understanding of the problem).

> Reviewing the patch when it was submitted would have been best, not
> after it ends up in one of my trees...

Well, I reviewed in less than 24h. I now that Linux development is
quick, but please don't make it that quick.

Otherwise I might consider a procmail rule that sends a "please don't
apply yet" mail until I come around looking at imx-uart patches. :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
