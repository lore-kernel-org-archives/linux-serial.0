From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 01/16] serial: sh-sci: Drop the interface clock
Date: Mon, 14 Dec 2015 17:16:28 +0900
Message-ID: <20151214081628.GF9929@verge.net.au>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
 <1447958173-543-2-git-send-email-geert+renesas@glider.be>
 <20151213064237.GA16326@kroah.com>
 <20151214081540.GD9929@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151214081540.GD9929-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 14, 2015 at 05:15:40PM +0900, Simon Horman wrote:
> Hi Greg,
> 
> On Sat, Dec 12, 2015 at 10:42:37PM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Nov 19, 2015 at 07:35:58PM +0100, Geert Uytterhoeven wrote:
> > > From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > > 
> > > As no platform defines an interface clock the SCI driver always falls
> > > back to a clock named "peripheral_clk".
> > >   - On SH platforms that clock is the base clock for the SCI functional
> > >     clock and has the same frequency,
> > >   - On ARM platforms that clock doesn't exist, and clk_get() will return
> > >     the default clock for the device.
> > > We can thus make the functional clock mandatory and drop the interface
> > > clock.
> > > 
> > > EPROBE_DEFER is handled for clocks that may be referenced from DT (i.e.
> > > "fck" and deprecated "sci_ick").
> > > 
> > > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > > Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> > > [geert: Handle EPROBE_DEFER, reformat description, break long comment line]
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> 
> If its not too much trouble I would prefer if you took this into the serial
> tree.

Sorry, I meant to can this email rather than sent it.
Please ignore the above!!!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
