From: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] omap-serial high-speed fixes/improvements
Date: Mon, 18 Aug 2014 16:45:21 +0200
Message-ID: <20140818144521.GB9319@ci00147.xsens-tech.local>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <20140818134507.GC9662@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140818134507.GC9662-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 18, 2014 at 08:45:08AM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 29, 2014 at 04:52:54PM +0200, Frans Klaver wrote:
> > Hi,
> > 
> > Here's a couple of patches that should improve the behavior of the omap serial
> > driver at high data rates and baud rates.
> > 
> > I was actually surprised to see that proper dma support isn't there yet, but
> > there you go. Anyone got news on that, by the way?
> 
> please resend these patches and make sure you get the right Cc list.
> 
> You're missing linux-omap, Tony Lingren, linux-arm-kernel...
> scripts/get_maintainer.pl would give you a more exaustive list of
> people to Cc.

This CC list is what I got from get_maintainer.pl. I should have at
least remembered to add linux-omap, though. I take it everyone gets all
patches for consistency?

Thanks,
Frans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
