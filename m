From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Wed, 12 Sep 2018 13:17:57 +0200
Message-ID: <20180912111757.GC2760@piout.net>
References: <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912105407.GR4185@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>linux-spi <l>
List-Id: linux-serial@vger.kernel.org

On 12/09/2018 11:54:07+0100, Lee Jones wrote:
> On Wed, 12 Sep 2018, Geert Uytterhoeven wrote:
> > On Wed, Sep 12, 2018 at 10:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > > > On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > > > >
> > > > > > > USART doc starting p572, registers p621.
> > > > >
> > > > > After looking at the datasheet, I don't see any reason why one of the
> > > > > two drivers can't be selected using different compatible strings.
> > > >
> > > > Because there is only one IP and we don't use the device tree to selecet
> > > > linux specific drivers.
> > >
> > > We do it all the time.  There are loads of MFDs (def: same IP, with
> > > different functions) which have separate compatibles for their various
> > > functions.  If you wish this IP to operate as an SPI controller, it
> > > should have an SPI compatible, if you wish it to operate as a U(S)ART,
> > > then it should have a UART compatible.  It's what we do for most of
> > > the other MFDs in the kernel.
> > 
> > There is a big difference: MFD functions are(more or less) independent
> > functions, which can be used at the same time. It makes perfect sense for a
> > single IP block that has both SPI and UART interfaces, that can be used at
> > the same time.
> > 
> > In this case, there is a single piece of hardware that can perform
> > different functions, but not at the same time. Performing a different
> > function means configuring the hardware for that function, hence using a
> > different driver (from a different subsystem).
> 
> Yes, I can see that PoV.
> 
> But ... we can't have it both ways.  *Either* it's a true MFD, in
> which case it can/should have 2 separate compatible strings which can
> be specified directly from the DT.  *Or* it's not an MFD.  In the
> latter case, which I think we're all agreeing on (else we'd have 2
> compatible strings), MFD is not the place to handle this (my original
> point).
> 

If that is what bothers you, then let's move it out of mfd.

> So ... this is a USART device which can do SPI, right?
> 
> My current thinking is that; as this is a USART device first &
> foremost, the USART should be probed in the first instance regardless,
> then if SPI mode is specified it (the USART driver) registers the SPI
> platform driver (as MFD does currently) and exits gracefully, allowing
> the SPI driver to take over.
> 
> Spanner in the works: is it physically possible to change the mode at
> run-time?  :s

Yes it is possible but on Linux that will not happen without probing
the drivers again. I think DT overlays will be the only possible use
case because on SPI, you'd still have to provide nodes for the connected
SPI devices.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
