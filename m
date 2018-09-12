From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Wed, 12 Sep 2018 09:36:40 +0100
Message-ID: <20180912083640.GM4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <CAMuHMdUMt=HJGCDZvJF99=45mecn5AjnTr-tA_LioxWrNKM2ag@mail.gmail.com>
 <20180911224302.GJ4185@dell>
 <20180912073056.GA2557@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912073056.GA2557@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>linux-spi <l>
List-Id: linux-serial@vger.kernel.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 11/09/2018 23:43:02+0100, Lee Jones wrote:
> > > I haven't read it, but I believe it's not unlike Renesas SCIF, which is
> > > served by both drivers/tty/serial/sh-sci.c and drivers/spi/spi-sh-sci.c.
> > > But the latter is not used from DT, so we haven't experienced (and solved)
> > > the similar issue yet.
> > > 
> > > Would it work if the UART driver and SPI driver would match against the
> > > same compatible value, but the UART driver would do in its probe()
> > > function:
> > > 
> > >     device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > >     if (opmode != AT91_USART_MODE_SERIAL)
> > >         return ENODEV;
> > > 
> > > while the SPI driver would do:
> > > 
> > >     device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > >     if (opmode != AT91_USART_MODE_SPI)
> > >         return ENODEV;
> > > 
> > > ? No MFD driver involved.
> > 
> > I haven't looked at the code in a while, but if memory serves I
> > believe platform code gives up once it has found its first match, so
> > by doing this, one of the drivers will never be matched/probed.
> > 
> > It's midnight here, so cracking out the datasheet isn't going to
> > happen just now, but it's my current belief that if the IP serves 2
> > very different modes of operation, even if the registers are in a
> > shared space, they could have their own compatible strings in DT.
> > 
> > That is what the MFD driver provides after all.  Why would it be okay
> > to allocate different compatible strings from the MFD, but not in the
> > Device Tree?
> > 
> > It would be the easiest solution.
> > 
> > Has Rob commented on this yet?
> 
> V4 of the bindings were acked by Rob and you:
> https://patchwork.kernel.org/patch/10428087/

We didn't Ack the bindings.  We Acked the location change.

I mean, has Rob specifically spoken out about using a compatible
string for each function.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
