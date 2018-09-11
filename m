From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Tue, 11 Sep 2018 10:33:56 +0100
Message-ID: <20180911093356.GE4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com, richard.genoud@gmail.com, davem@davemloft.net, mchehab+samsung@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 04 Sep 2018, Radu Pirea wrote:
> Radu Pirea (6):
>   MAINTAINERS: add at91 usart mfd driver
>   dt-bindings: add binding for atmel-usart in SPI mode
>   mfd: at91-usart: added mfd driver for usart
>   MAINTAINERS: add at91 usart spi driver
>   spi: at91-usart: add driver for at91-usart as spi
>   tty/serial: atmel: change the driver to work under at91-usart mfd
> 
>  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
>  MAINTAINERS                                   |  16 +
>  drivers/mfd/Kconfig                           |   9 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/at91-usart.c                      |  71 +++
>  drivers/spi/Kconfig                           |   8 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/atmel_serial.c             |  42 +-
>  include/dt-bindings/mfd/at91-usart.h          |  17 +
>  11 files changed, 606 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 drivers/spi/spi-at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h

Seeing as this patch-set has caused some issues this morning, I took
the liberty to peruse back into its history to figure out where things
started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
I did!

My Acked-by has been attached to the MFD portion since v5, which is
why the code hasn't caught my eye before today.  I reviewed the
relocation of the *binding document* (serial => mfd with no changes)
in v4 and nothing else.  It appears as though you mistakenly added it
to the *MFD driver* instead.  This explains my confusion in v10 when I
told you I'd already reviewed the binding document.

As I said, I have re-reviewed the MFD driver and I'm afraid to say
that I do not like what I see.  Besides the missing header file and
the whitespace tabbing errors, I do not agree with the implementation.
Using MFD as a shim to hack around driver selection is not a valid
use-case.

What's stopping you from just using the compatible string directly to
select which driver you need to probe?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
