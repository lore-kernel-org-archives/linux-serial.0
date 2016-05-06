From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake
 interface
Date: Fri, 06 May 2016 17:48:05 +0200
Message-ID: <20160506174805.61f64dba@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

----- Original Message -----
From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
To: Maarten Brock [mailto:m.brock@vanmierlo.com]
Cc: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com], Bryan O'Donoghue [mailto:pure.logic@nexus-software.ie], Peter Hurley [mailto:peter@hurleysoftware.com], linux-serial@vger.kernel.org [mailto:linux-serial@vger.kernel.org], Vinod Koul [mailto:vinod.koul@intel.com], linux-kernel@vger.kernel.org [mailto:linux-kernel@vger.kernel.org], dmaengine [mailto:dmaengine@vger.kernel.org], Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org], Puustinen, Ismo [mailto:ismo.puustinen@intel.com], Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com]
Sent: Fri, 06 May 2016 13:38:44 +0200
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake interface


> On Fri, May 6, 2016 at 2:20 PM, Maarten Brock <m.brock@vanmierlo.com> wrote:
> >> > >
> >> > > +       bool                    polarity;
> >> > So this variable is not very intuitively named.
> >>
> >> There is a help above. This is a property of the Synopsys DesignWare DMA
> >> engine. Anyone familiar with datasheet easily understands this.
> >>
> >> >
> >> > You end up setting somepointer->polarity = true; in a later patch.
> >> >
> >> > Since you're respining a V4 I'd suggest a name that describes a little
> >> > bit better than polarity. Setting polarity = true is a little bit
> >> > liked being asked "you you like ice-cream or apple pie" and then
> >> > saying "yes please".
> >>
> >> It's about handshake interface polarity, so, what about hs_polarity?
> >
> > So it means: handshake has polarity (true) or handshake has no polarity
> > (omnidirectional?) (false), right?
> 
> It means that handshake polarity _signal_ is inverted (true) or
> default (false) in terms of hardware gates.

Would it not be better then to name it handshake_inverted ? That is
something you can ask and answer with true or false.

Maarten

> -- 
> With Best Regards,
> Andy Shevchenko
> 
