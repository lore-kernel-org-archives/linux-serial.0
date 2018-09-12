From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Wed, 12 Sep 2018 14:12:48 +0100
Message-ID: <20180912131248.GA21544@dell>
References: <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
 <20180912111757.GC2760@piout.net>
 <20180912114352.GT4185@dell>
 <20180912121420.GE2760@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912121420.GE2760@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>linux-spi <l>
List-Id: linux-serial@vger.kernel.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 12/09/2018 12:43:52+0100, Lee Jones wrote:
> > > > But ... we can't have it both ways.  *Either* it's a true MFD, in
> > > > which case it can/should have 2 separate compatible strings which can
> > > > be specified directly from the DT.  *Or* it's not an MFD.  In the
> > > > latter case, which I think we're all agreeing on (else we'd have 2
> > > > compatible strings), MFD is not the place to handle this (my original
> > > > point).
> > > > 
> > > 
> > > If that is what bothers you, then let's move it out of mfd.
> > 
> > As I've already mentioned.  I don't just want it moved out of MFD and
> > shoved somewhere else.  My aim is to fix this properly.
> > 
> 
> If it is out of MFD, then I'm not sure why you would care too much about
> it as you won't be maintaining that code. And I still this what was done
> was correct but I'm open to test what you suggest.

I care for the kernel in general, not just the areas I'm responsible
for.  I guess I'm just that kinda guy! ;)

> > > > So ... this is a USART device which can do SPI, right?
> > > > 
> > > > My current thinking is that; as this is a USART device first &
> > > > foremost, the USART should be probed in the first instance regardless,
> > > > then if SPI mode is specified it (the USART driver) registers the SPI
> > > > platform driver (as MFD does currently) and exits gracefully, allowing
> > > > the SPI driver to take over.
> > > > 
> > > > Spanner in the works: is it physically possible to change the mode at
> > > > run-time?  :s
> > > 
> > > Yes it is possible but on Linux that will not happen without probing
> > > the drivers again.
> > 
> > Not sure I understand what you mean.
> 
> I was just commenting on changing the mode at runtime.

Oh I see.  My question was relating to whether the H/W is physically
capable of changing modes on-the-fly, rather than how Linux would
handle that.  If this is something we'd wish to support, then it would
have to be a single driver, which is why I was asking.  By separating
the drivers this way, we are blocking that as a possibility.  Although
I guess the OP has already thought about that and made the decision
not to support it.

> > I'm suggesting that you use the same platform_* interfaces MFD uses to
> > register the SPI driver if SPI mode has been selected.  Only do so
> > from the appropriate driver i.e. USART.
> 
> Yeah, I understood that but I didn't comment because I'm not sure this
> will work yet.

Other drivers already do this.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
