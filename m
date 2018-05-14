From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
Date: Mon, 14 May 2018 19:56:47 +0300
Message-ID: <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com> <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Radu Pirea <radu.pirea@microchip.com>, devicetree <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, alexandre.belloni@bootlin.com, Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, May 14, 2018 at 1:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> On 11/05/2018 12:38, Radu Pirea wrote:
>> This patch modifies the place where resources and device tree properties
>> are searched.

> I think it may be simpler with something like:

> +       int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;

Isn't resource_size() macro for this very purpose?

>> +     int size = to_platform_device(pdev->dev.parent)->resource[0].end -
>> +             to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>>
> ditto

Ditto.

-- 
With Best Regards,
Andy Shevchenko
