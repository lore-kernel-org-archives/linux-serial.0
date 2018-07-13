From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 0/6] Driver for at91 usart in spi mode
Date: Fri, 13 Jul 2018 08:37:05 +0100
Message-ID: <20180713073705.GT4641@dell>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <aecba39e-deba-c64b-9542-a446e074e95e@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aecba39e-deba-c64b-9542-a446e074e95e@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org, alexandre.belloni@bootlin.com, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 11 Jul 2018, Nicolas Ferre wrote:

> On 25/06/2018 at 19:22, Radu Pirea wrote:
> > Hello,
> > 
> > This is the second version of driver. I added a mfd driver which by
> > default probes atmel_serial driver and if in dt is specified to probe
> > the spi driver, then the spi-at91-usart driver will be probed. The
> > compatible for atmel_serial is now the compatible for at91-usart mfd
> > driver and compatilbe for atmel_serial driver was changed in order to
> > keep the bindings for serial as they are.
> > 
> > Changes in v10:
> > -fixed kbuild test robot warning
> > 
> > Changes in v9:
> > - minor changes
> > - rebased on top of broonie/for-4.19
> > 
> > Changes in v8:
> > - fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid
> > 
> > Changes in v7:
> > - synced up  SPDIX license with module license
> > - numbering of usart modes starts from 0 insteand of 1
> > 
> > Changes in v6:
> > - removed unused compatible strings from serial and spi drivers
> > 
> > Changes in v5:
> > - fixed usage of stdout-path property with atmel_serial driver
> > 
> > Changes in v4:
> > - modified the spi driver to use cs gpio support form spi subsystem
> > - fixed dma transfers for serial driver
> > - squashed binding for spi and serial and moved them to mfd/atmel-usart.txt
> > 
> > Changes in v3:
> > - fixed spi slaves probing
> > 
> > Changes in v2:
> > - added at91-usart mfd driver
> > - modified spi-at91-usart driver to work as mfd driver child
> > - modified atmel_serial driver to work as mfd driver child
> > 
> > Changes in v1:
> > - added spi-at91-usart driver
> > 
> > 
> > Radu Pirea (6):
> >    MAINTAINERS: add at91 usart mfd driver
> >    dt-bindings: add binding for atmel-usart in SPI mode
> >    mfd: at91-usart: added mfd driver for usart
> >    MAINTAINERS: add at91 usart spi driver
> >    spi: at91-usart: add driver for at91-usart as spi
> >    tty/serial: atmel: change the driver to work under at91-usart mfd
> 
> For the record or if needed by the MAINTAINERS changes, you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> for the whole series.
> 
> Once the remarks by Mark are addressed, you can certainly re-send the series
> with all tags collected for Lee to take it, if he is okay with this process,
> of course...

That's fine.  No problem.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
