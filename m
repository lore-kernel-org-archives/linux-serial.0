From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
Date: Fri, 10 Aug 2018 19:45:42 +0200
Message-ID: <0aa77961-fe60-6afe-e6c5-d2db4250cb22@suse.de>
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de>
 <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: SERIAL DRIVERS <linux-serial@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>, jringle@gridpoint.com, Michael Allwright <allsey87@gmail.com>, Jakub Kicinski <kubakici@wp.pl>, liuxuenetmail@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Am 10.08.2018 um 19:34 schrieb Rob Herring:
> On Sun, Aug 5, 2018 at 5:27 PM Andreas Färber <afaerber@suse.de> wrote:
>>
>> This is to allow using serdev.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index 243c96025053..ad7267274f65 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
>>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
>>
>>         for (i = 0; i < devtype->nr_uart; ++i) {
>> +#ifdef CONFIG_OF
>> +               struct device_node *np;
>> +               struct platform_device *pdev;
>> +               char name[6] = "uartx";
>> +#endif
>> +
>>                 s->p[i].line            = i;
>>                 /* Initialize port data */
>> +#ifdef CONFIG_OF
>> +               name[4] = '0' + i;
>> +               np = of_get_child_by_name(dev->of_node, name);
>> +               if (IS_ERR(np)) {
>> +                       ret = PTR_ERR(np);
>> +                       goto out_ports;
>> +               }
>> +               pdev = of_platform_device_create(np, NULL, dev);
> 
> Ideally, you would use of_platform_default_populate here. I think
> you'd have to add a compatible to the child nodes, but that wouldn't
> be a bad thing. I could envision that the child nodes ultimately
> become their own driver utilizing the standard 8250 driver and a
> compatible string would be needed in that case.

Separate compatibles would mean separate drivers.

Unlike your DUART example this is not an MMIO device that we can easily
split but a SPI slave (well, regmap due to some I2C models).

I don't see how separate drivers could work, given that the whole
spi_device has a single interrupt for all functions of this device.

That left me with this ugly but working construct.

Is the uartX naming correct, or should it be serialX?

Regards,
Andreas

> 
> You'd then have to loop over each child of 'dev' instead of the DT nodes.
> 
>> +               if (IS_ERR(pdev)) {
>> +                       ret = PTR_ERR(pdev);
>> +                       goto out_ports;
>> +               }
>> +               platform_set_drvdata(pdev, dev_get_drvdata(dev));
>> +               s->p[i].port.dev        = &pdev->dev;
>> +#else
>>                 s->p[i].port.dev        = dev;
>> +#endif
>>                 s->p[i].port.irq        = irq;
>>                 s->p[i].port.type       = PORT_SC16IS7XX;
>>                 s->p[i].port.fifosize   = SC16IS7XX_FIFO_SIZE;


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
