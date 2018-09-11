From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Tue, 11 Sep 2018 21:04:56 +0200
Message-ID: <CAMuHMdV_btX=HcTpfnrP6iUfrBNvQfDybE_tKtJZZERMQ8n=ZA@mail.gmail.com>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell> <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net> <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell> <20180911185839.GA25212@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911185839.GA25212@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Lee Jones <lee.jones@linaro.org>, radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-spi <linux-spi@>
List-Id: linux-serial@vger.kernel.org

Hi Alexandre,

On Tue, Sep 11, 2018 at 8:58 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 11/09/2018 19:39:30+0100, Lee Jones wrote:
> > On Tue, 11 Sep 2018, Geert Uytterhoeven wrote:
> >
> > > On Tue, Sep 11, 2018 at 5:36 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > > On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> > > > > <alexandre.belloni@bootlin.com> wrote:
> > > > > > Then you'd have multiple compatible strings for the same IP which is a
> > > > > > big no-no.
> > > > >
> > > > > It's still the same hardware device, isn't?
> > > > > What if the SPI or UART slave is not on-board, but on an expansion board?
> > > > > Then the SoC-specific .dtsi has no idea what mode should be used.
> > > > >
> > > > > Hence shouldn't the software derive the hardware mode from the full
> > > > > hardware description in DT? If that's impossible (I didn't look into detail
> > > > > whether an SPI bus can easily be distinguished from a UART bus), perhaps
> > > > > a mode property should be added?
> > > >
> > > > Yes, this is exactly what is done:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/drivers/mfd/at91-usart.c?h=ib-mfd-spi-tty-4.20-1#n33
> > >
> > > OK.
> > >
> > > I guess the main "hackish" part is that the mfd_cell uses of_compatible,
> > > which thus requires having additional compatible values?
> > >
> > > I think those can just be removed. AFAICS, the SPI and serial drivers already
> > > match against the "at91_usart_spi" resp. "atmel_usart_serial" platform device
> > > names?
> >
> > The hackish part of this driver is that it's using MFD for something
> > which is clearly not an MFD.  It's a USART device.  Nothing more,
> > nothing less.
> >
> > Does anyone have the datasheet to hand?
>
> It is not a simple usart, it is either a usart or a full blown SPI
> controller with registers changing layout depending on the selected
> mode. Otherwise, I'm not sure how you would get a USART to do SPI.

Note the "S" in USART. SPI is just synchronous serial with a shared clock
for transmit and receive. So the hardware is not that unrelated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
