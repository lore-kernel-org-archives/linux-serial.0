From: Radu Pirea <radu.pirea@microchip.com>
Subject: Re: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
Date: Fri, 13 Jul 2018 12:56:22 +0300
Message-ID: <dc410321-5dfd-7c26-2a3e-d2b2840da214@microchip.com>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
 <20180710181559.GG8104@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710181559.GG8104@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 07/10/2018 09:15 PM, Mark Brown wrote:
> On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:
> 
> This is mostly good, just a couple of small things:
> 
>> +config SPI_AT91_USART
>> +	tristate "Atmel USART Controller SPI driver"
>> +	depends on HAS_DMA
>> +	depends on (ARCH_AT91 || COMPILE_TEST)
>> +	select MFD_AT91_USART
> 
> Why is this selecting rather than depending on the MFD like we normally
> do?
> 

Hi Mark,

If I add depends instead of select, current defconfigs will be broken 
and the proper driver will not be selected. Like this, there is no 
required change in any defconfig. Selecting the serial or spi driver 
from menuconfig makes the MFD completely transparent.
>> @@ -0,0 +1,432 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for AT91 USART Controllers as SPI
>> + *
>> + * Copyright (C) 2018 Microchip Technology Inc.
>> + * Author: Radu Pirea <radu.pirea@microchip.com>
>> + */
> 
> Please use C++ comments for the whole block so it looks a bit more
> intentional.

Ok. I will change it.

> 
> Otherwise
> 
> Reviwed-by: Mark Brown <broonie@kernel.org>
> 
