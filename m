From: Radu Pirea <radu.pirea@microchip.com>
Subject: Re: [PATCH v11 0/6] Driver for at91 usart in spi mode
Date: Wed, 22 Aug 2018 15:55:39 +0300
Message-ID: <ba108fbe-d3c4-a60e-a1c0-441fe3082212@microchip.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713164736.26028-1-radu.pirea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>, Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "richard.genoud@gmail.com" <richard.genoud@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Lee,

I saw that the patches were not applied to your tree for this kernel 
version. After the discussion with Nicolas, I remember that you said 
that you will take the patches in your tree. I addressed Mark comments 
related to the last version of patches. Is there something that must be 
reworked in order to take the patches?

On 7/13/18 7:47 PM, Radu Pirea - M19893 wrote:
> Hello,
> 
> This is the second version of driver. I added a mfd driver which by
> default probes atmel_serial driver and if in dt is specified to probe
> the spi driver, then the spi-at91-usart driver will be probed. The
> compatible for atmel_serial is now the compatible for at91-usart mfd
> driver and compatilbe for atmel_serial driver was changed in order to
> keep the bindings for serial as they are.
> 
> @Lee, could you take this patch series into your tree? I addressed all Mark
> remarks.
> 
> Changes in v11:
> - removed "depends on HAS_DMA" from drivers/spi/Kconfig because the driver has
> no dma support
> - changed "selects MFD_AT91_USART" to "depends on MFD_AT91_USART" in
> drivers/spi/Kconfig
> - changed comment style in spi-at91-usart.c
> 
> Changes in v10:
> -fixed kbuild test robot warning
> 
> Changes in v9:
> - minor changes
> - rebased on top of broonie/for-4.19
> 
> Changes in v8:
> - fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid
> 
> Changes in v7:
> - synced up  SPDIX license with module license
> - numbering of usart modes starts from 0 insteand of 1
> 
> Changes in v6:
> - removed unused compatible strings from serial and spi drivers
> 
> Changes in v5:
> - fixed usage of stdout-path property with atmel_serial driver
> 
> Changes in v4:
> - modified the spi driver to use cs gpio support form spi subsystem
> - fixed dma transfers for serial driver
> - squashed binding for spi and serial and moved them to mfd/atmel-usart.txt
> 
> Changes in v3:
> - fixed spi slaves probing
> 
> Changes in v2:
> - added at91-usart mfd driver
> - modified spi-at91-usart driver to work as mfd driver child
> - modified atmel_serial driver to work as mfd driver child
> 
> Changes in v1:
> - added spi-at91-usart driver
> 
> Radu Pirea (6):
>    MAINTAINERS: add at91 usart mfd driver
>    dt-bindings: add binding for atmel-usart in SPI mode
>    mfd: at91-usart: added mfd driver for usart
>    MAINTAINERS: add at91 usart spi driver
>    spi: at91-usart: add driver for at91-usart as spi
>    tty/serial: atmel: change the driver to work under at91-usart mfd
> 
>   .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
>   MAINTAINERS                                   |  16 +
>   drivers/mfd/Kconfig                           |   9 +
>   drivers/mfd/Makefile                          |   1 +
>   drivers/mfd/at91-usart.c                      |  71 +++
>   drivers/spi/Kconfig                           |   8 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
>   drivers/tty/serial/Kconfig                    |   1 +
>   drivers/tty/serial/atmel_serial.c             |  42 +-
>   include/dt-bindings/mfd/at91-usart.h          |  17 +
>   11 files changed, 606 insertions(+), 17 deletions(-)
>   rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>   create mode 100644 drivers/mfd/at91-usart.c
>   create mode 100644 drivers/spi/spi-at91-usart.c
>   create mode 100644 include/dt-bindings/mfd/at91-usart.h
> 
