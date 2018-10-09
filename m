From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Tue, 9 Oct 2018 02:04:54 -0700
Message-ID: <20181009090454.GD4939@dell>
References: <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
 <20180912111757.GC2760@piout.net>
 <20180912114352.GT4185@dell>
 <20180912121420.GE2760@piout.net>
 <20180912131248.GA21544@dell>
 <a143edd3c0de2ba98b64e642b4384edf4323be2b.camel@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a143edd3c0de2ba98b64e642b4384edf4323be2b.camel@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.k>
List-Id: linux-serial@vger.kernel.org

On Wed, 12 Sep 2018, Radu Pirea wrote:

> On Wed, 2018-09-12 at 14:12 +0100, Lee Jones wrote:
> > On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > 
> > > On 12/09/2018 12:43:52+0100, Lee Jones wrote:
> > > > > > But ... we can't have it both ways.  *Either* it's a true
> > > > > > MFD, in
> > > > > > which case it can/should have 2 separate compatible strings
> > > > > > which can
> > > > > > be specified directly from the DT.  *Or* it's not an MFD.  In
> > > > > > the
> > > > > > latter case, which I think we're all agreeing on (else we'd
> > > > > > have 2
> > > > > > compatible strings), MFD is not the place to handle this (my
> > > > > > original
> > > > > > point).
> > > > > > 
> > > > > 
> > > > > If that is what bothers you, then let's move it out of mfd.
> > > > 
> > > > As I've already mentioned.  I don't just want it moved out of MFD
> > > > and
> > > > shoved somewhere else.  My aim is to fix this properly.
> > > > 
> > > 
> > > If it is out of MFD, then I'm not sure why you would care too much
> > > about
> > > it as you won't be maintaining that code. And I still this what was
> > > done
> > > was correct but I'm open to test what you suggest.
> > 
> > I care for the kernel in general, not just the areas I'm responsible
> > for.  I guess I'm just that kinda guy! ;)
> 
> Well, Lee, like you, I think this driver should not be a MFD driver,
> but Alex has a good point of view. 
> 
> > 
> > > > > > So ... this is a USART device which can do SPI, right?
> > > > > > 
> > > > > > My current thinking is that; as this is a USART device first
> > > > > > &
> > > > > > foremost, the USART should be probed in the first instance
> > > > > > regardless,
> > > > > > then if SPI mode is specified it (the USART driver) registers
> > > > > > the SPI
> > > > > > platform driver (as MFD does currently) and exits gracefully,
> > > > > > allowing
> > > > > > the SPI driver to take over.
> > > > > > 
> > > > > > Spanner in the works: is it physically possible to change the
> > > > > > mode at
> > > > > > run-time?  :s
> > > > > 
> > > > > Yes it is possible but on Linux that will not happen without
> > > > > probing
> > > > > the drivers again.
> > > > 
> > > > Not sure I understand what you mean.
> > > 
> > > I was just commenting on changing the mode at runtime.
> > 
> > Oh I see.  My question was relating to whether the H/W is physically
> > capable of changing modes on-the-fly, rather than how Linux would
> > handle that.  If this is something we'd wish to support, then it
> > would
> > have to be a single driver, which is why I was asking.  By separating
> > the drivers this way, we are blocking that as a
> > possibility.  Although
> > I guess the OP has already thought about that and made the decision
> > not to support it.
> 
> Is possible to change modes on-the-fly, but you have no reason to do
> that. On the PCB you will have a SPI slave or a serial console :)
> Anyway, the current form of the driver, and through this I want to say
> "this ugly hack", allows the user to switch from serial to SPI mode by
> adding only one property to the device tree node of USART. If the
> driver were in his first form, a simple SPI driver, how you will make a
> dtsi file for an IP like this? You will add two nodes for the same IP
> in dtsi and will take care to enable correct node in dts?
> I think this driver is only a tradeoff between having an ugly hack in
> kernel or having an messy device tree.
> 
> > 
> > > > I'm suggesting that you use the same platform_* interfaces MFD
> > > > uses to
> > > > register the SPI driver if SPI mode has been selected.  Only do
> > > > so
> > > > from the appropriate driver i.e. USART.
> > > 
> > > Yeah, I understood that but I didn't comment because I'm not sure
> > > this
> > > will work yet.
> > 
> > Other drivers already do this.
> 
> Can you give me an example please?

Sorry for the delay, I have been on vacation.

Grep for 'platform_device_add' in drivers/

> I am open to suggestions.
> 
> Sorry for that acked-by. There was a lot of "reviewed-by", "acked-by",
> etc in a single version and I messed up :).
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
