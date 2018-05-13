From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/6] MAINTAINERS: add at91 usart spi driver
Date: Sun, 13 May 2018 16:14:38 +0300
Message-ID: <CAHp75VdXrQ_NKBmP0L9o8_2MSqehNuriQ0gBJ3dDWQdegALSaA@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com> <20180511103822.31698-4-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511103822.31698-4-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, alexandre.belloni@bootlin.com, Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> Added entry for at91 usart mfd driver.
>

You are adding a record for not existing file?

> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca06c6f58299..9243b9007966 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9199,6 +9199,13 @@ S:       Supported
>  F:     drivers/mfd/at91-usart.c
>  F:     include/dt-bindings/mfd/at91-usart.h
>
> +MICROCHIP AT91 USART SPI DRIVER
> +M:     Radu Pirea <radu.pirea@microchip.com>
> +L:     linux-spi@vger.kernel.org
> +S:     Supported
> +F:     drivers/spi/spi-at91-usart.c
> +F:     Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> +
>  MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
>  M:     Woojung Huh <Woojung.Huh@microchip.com>
>  M:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
