From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Date: Mon, 14 May 2018 20:38:15 +0300
Message-ID: <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com> <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>, devicetree <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, alexandre.belloni@bootlin.com, Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-serial@vger.kernel.org

First of all, do not remove mailing lists from Cc and people if you
are not sure they do not need your stuff.

On Mon, May 14, 2018 at 11:11 AM, Radu Pirea <radu.pirea@microchip.com> wrote:
> On Sun, 2018-05-13 at 16:33 +0300, Andy Shevchenko wrote:
>> On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com
>> > wrote:

>> > +static void at91_usart_spi_cleanup(struct spi_device *spi)
>> > +{
>> > +       struct at91_usart_spi_device *ausd = spi->controller_state;
>> > +
>> > +       if (!ausd)
>> > +               return;
>>
>> Is it even possible?
> Theoretically yes.

I would like to know real circumstances when it might happen.

>>
>> Anyway the code below will work fine even if it's the case.
>>
>> > +
>> > +       spi->controller_state = NULL;
>> > +       kfree(ausd);
>> > +}

>> The question is, why you didn't utilize what SPI core provides you?
> I tried, but it did not work the way I expected.

So, what is not going as expected in "SPI core takes care of CSs" case?
Did you use oscilloscope for that?

-- 
With Best Regards,
Andy Shevchenko
