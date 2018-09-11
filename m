From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Tue, 11 Sep 2018 23:44:18 +0100
Message-ID: <20180911224418.GK4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911185839.GA25212@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>linux-spi <l>
List-Id: linux-serial@vger.kernel.org

On Tue, 11 Sep 2018, Alexandre Belloni wrote:

> On 11/09/2018 19:39:30+0100, Lee Jones wrote:
> > On Tue, 11 Sep 2018, Geert Uytterhoeven wrote:
> > 
> > > On Tue, Sep 11, 2018 at 5:36 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > > On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> > > > > <alexandre.belloni@bootlin.com> wrote:
> > > > > > On 11/09/2018 10:33:56+0100, Lee Jones wrote:
> > > > > > > On Tue, 04 Sep 2018, Radu Pirea wrote:
> > > > > > > > Radu Pirea (6):
> > > > > > > >   MAINTAINERS: add at91 usart mfd driver
> > > > > > > >   dt-bindings: add binding for atmel-usart in SPI mode
> > > > > > > >   mfd: at91-usart: added mfd driver for usart
> > > > > > > >   MAINTAINERS: add at91 usart spi driver
> > > > > > > >   spi: at91-usart: add driver for at91-usart as spi
> > > > > > > >   tty/serial: atmel: change the driver to work under at91-usart mfd
> > > > > > > >
> > > > > > > >  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
> > > > > > > >  MAINTAINERS                                   |  16 +
> > > > > > > >  drivers/mfd/Kconfig                           |   9 +
> > > > > > > >  drivers/mfd/Makefile                          |   1 +
> > > > > > > >  drivers/mfd/at91-usart.c                      |  71 +++
> > > > > > > >  drivers/spi/Kconfig                           |   8 +
> > > > > > > >  drivers/spi/Makefile                          |   1 +
> > > > > > > >  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
> > > > > > > >  drivers/tty/serial/Kconfig                    |   1 +
> > > > > > > >  drivers/tty/serial/atmel_serial.c             |  42 +-
> > > > > > > >  include/dt-bindings/mfd/at91-usart.h          |  17 +
> > > > > > > >  11 files changed, 606 insertions(+), 17 deletions(-)
> > > > > > > >  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
> > > > > > > >  create mode 100644 drivers/mfd/at91-usart.c
> > > > > > > >  create mode 100644 drivers/spi/spi-at91-usart.c
> > > > > > > >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > > > > > >
> > > > > > > Seeing as this patch-set has caused some issues this morning, I took
> > > > > > > the liberty to peruse back into its history to figure out where things
> > > > > > > started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
> > > > > > > I did!
> > > > > > >
> > > > > > > My Acked-by has been attached to the MFD portion since v5, which is
> > > > > > > why the code hasn't caught my eye before today.  I reviewed the
> > > > > > > relocation of the *binding document* (serial => mfd with no changes)
> > > > > > > in v4 and nothing else.  It appears as though you mistakenly added it
> > > > > > > to the *MFD driver* instead.  This explains my confusion in v10 when I
> > > > > > > told you I'd already reviewed the binding document.
> > > > > > >
> > > > > > > As I said, I have re-reviewed the MFD driver and I'm afraid to say
> > > > > > > that I do not like what I see.  Besides the missing header file and
> > > > > > > the whitespace tabbing errors, I do not agree with the implementation.
> > > > > > > Using MFD as a shim to hack around driver selection is not a valid
> > > > > > > use-case.
> > > > > > >
> > > > > > > What's stopping you from just using the compatible string directly to
> > > > > > > select which driver you need to probe?
> > > > > > >
> > > > > >
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
> > 
> 
> It is not a simple usart, it is either a usart or a full blown SPI
> controller with registers changing layout depending on the selected
> mode. Otherwise, I'm not sure how you would get a USART to do SPI.

Make up your mind.  Either the IP is different, or it's not. ;)

> Datasheet here:

Great.  Thank you.

> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> 
> USART doc starting p572, registers p621.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
