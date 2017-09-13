From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v1 03/10] clk: at91: pmc: Support backup for programmable
 clocks
Date: Wed, 13 Sep 2017 19:03:10 +0200
Message-ID: <20170913170310.grfv7j5xvh7chjdo@piout.net>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-4-romain.izard.pro@gmail.com>
 <b0c7e816-4a7c-609d-2bc7-281fc6ca751d@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b0c7e816-4a7c-609d-2bc7-281fc6ca751d-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 13/09/2017 at 14:29:35 +0200, Nicolas Ferre wrote:
> On 08/09/2017 at 17:35, Romain Izard wrote:
> > From: Romain Izard <romain.izard-Tny/h2m1dROW3RwJEphJ61AUjnlXr6A1@public.gmane.org>
> > 
> > Save and restore the System Clock and Programmable Clock register for
> > the backup use case.
> 
> "System Clock" seems to be handled in another patch.
> 
> > Signed-off-by: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/clk/at91/pmc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> > index 07dc2861ad3f..5421b03553ec 100644
> > --- a/drivers/clk/at91/pmc.c
> > +++ b/drivers/clk/at91/pmc.c
> > @@ -66,6 +66,7 @@ static struct
> >  	u32 pcr[PMC_MAX_IDS];
> >  	u32 audio_pll0;
> >  	u32 audio_pll1;
> > +	u32 pckr[3];
> 
> Some products have different numbers of PCK (only 2 on at91sam9x5 for
> instance)...
> 

My opinion is that it will be time to change that when multiple SoCs
will need to save their registers.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
