From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 2/6] mfd: at91-usart: added mfd driver for usart
Date: Sat, 19 May 2018 09:08:09 +0200
Message-ID: <20180519070809.GB23730@piout.net>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-3-radu.pirea@microchip.com>
 <20180518221949.GA13443@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518221949.GA13443@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Radu Pirea <radu.pirea@microchip.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, richard.genoud@gmail.com, nicolas.ferre@microchip.com, broonie@kernel.org
List-Id: linux-serial@vger.kernel.org

On 18/05/2018 17:19:49-0500, Rob Herring wrote:
> On Fri, May 11, 2018 at 01:38:18PM +0300, Radu Pirea wrote:
> > This mfd driver is just a wrapper over atmel_serial driver and
> > spi-at91-usart driver. Selection of one of the drivers is based on a
> > property from device tree. If the property is not specified, the default
> > driver is atmel_serial.
> > 
> > Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> > ---
> >  drivers/mfd/Kconfig                  | 10 ++++
> >  drivers/mfd/Makefile                 |  1 +
> >  drivers/mfd/at91-usart.c             | 75 ++++++++++++++++++++++++++++
> >  include/dt-bindings/mfd/at91-usart.h | 17 +++++++
> >  4 files changed, 103 insertions(+)
> >  create mode 100644 drivers/mfd/at91-usart.c
> >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > 
> 
> > +#ifndef __DT_BINDINGS_AT91_USART_H__
> > +#define __DT_BINDINGS_AT91_USART_H__
> > +
> > +#define AT91_USART_MODE_SERIAL	1
> > +#define AT91_USART_MODE_SPI	2
> 
> Won't this require a DT update for serial mode to add the mode property? 
> That breaks compatibility.
> 

If the mode property is not present, it defaults to serial to keep
compatibility.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
