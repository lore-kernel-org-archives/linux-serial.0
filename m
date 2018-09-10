From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Mon, 10 Sep 2018 11:51:42 +0200
Message-ID: <2a8ccc95-bbf0-2211-0f88-c5a594600d34@microchip.com>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180910094817.GJ28860@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910094817.GJ28860@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com, richard.genoud@gmail.com, davem@davemloft.net, mchehab+samsung@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Lee,

On 10/09/2018 at 11:48, Lee Jones wrote:
> On Tue, 04 Sep 2018, Radu Pirea wrote:
>> Well, this is the 12th version of this patch series.
>> In this version I fixed a warning from kbuild-robot and I have no idea
>> how I forgot to add static in declaration of that functions. Also I
>> fixed the example for the SPI driver in bindings.
> 
> Okay great.  So which patches still require Acks?

None I would say: everything's ready to be integrated into your MFD tree 
as you proposed some time ago.

We are looking forward seeing this series integrated in linux-next as 
soon as possible.

Best regards,
   Nicolas


>> Radu Pirea (6):
>>    MAINTAINERS: add at91 usart mfd driver
>>    dt-bindings: add binding for atmel-usart in SPI mode
>>    mfd: at91-usart: added mfd driver for usart
>>    MAINTAINERS: add at91 usart spi driver
>>    spi: at91-usart: add driver for at91-usart as spi
>>    tty/serial: atmel: change the driver to work under at91-usart mfd
> 


-- 
Nicolas Ferre
