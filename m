From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v6] serial: 8250_uniphier: add UniPhier serial driver
Date: Mon, 25 May 2015 19:12:45 +0900
Message-ID: <CAK7LNASwP7YMs77C=pPQBDGpsDNGz=d_CGiMoHbUQh=Tq3=gtg@mail.gmail.com>
References: <1432525477-14051-1-git-send-email-yamada.masahiro@socionext.com>
	<1432545245.8736.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432545245.8736.5.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "manabian@gmail.com" <manabian@gmail.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "ricardo.ribalda@gmail.com" <ricardo.ribalda@gmail.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "blogic@openwrt.org" <blogic@openwrt.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Andy,


2015-05-25 18:14 GMT+09:00 Shevchenko, Andriy <andriy.shevchenko@intel.com>:
> On Mon, 2015-05-25 at 12:44 +0900, Masahiro Yamada wrote:
>> Add the driver for on-chip UART used on UniPhier SoCs.
>>
>> This hardware is similar to 8250, but the register mapping is
>> slightly different:
>>   - The offset to FCR, MCR is different.
>>   - The divisor latch access bit does not exist.  Instead, the
>>     divisor latch register is available at offset 9.
>>
>> This driver overrides serial_{in,out}, dl_{read,write} callbacks,
>> but wants to borrow most of code from 8250_core.c.
>
> Do not send series too often, let people to review what you did.
>
> More comments below.



>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "8250.h"
>> +
>> +/* Most (but not all) of UniPhier UART devices have 64-depth FIFO. */
>> +#define UNIPHIER_UART_DEFAULT_FIFO_SIZE      64
>> +
>> +#define UNIPHIER_UART_CHAR_FCR       3       /* Character / FIFO Control Register */
>> +#define UNIPHIER_UART_LCR_MCR        4       /* Line/Modem Control Register */
>> +#define   UNIPHIER_UART_LCR_SHIFT    8
>
> Indentation problem, needs to be fixed.


How should it be fixed?

Could you explain it more detailed, please?




>> +#define UNIPHIER_UART_DLR    9       /* Divisor Latch Register */
>> +
>> +struct uniphier8250_priv {
>> +     int line;
>> +     struct clk *clk;
>> +     spinlock_t atomic_write_lock;
>> +};
>> +
>> +/*
>> + * The register map is slightly different from that of 8250.
>> + * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
>> + */
>> +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
>> +{
>> +     int valshift = 0;
>
> Perhaps unsigned int?


OK, I will fix it (after waiting for some more comments).




>
>> +     bool normal = false;
>> +
>> +     switch (offset) {
>> +     case UART_FCR:
>> +             offset = UNIPHIER_UART_CHAR_FCR;
>> +             break;
>> +     case UART_LCR:
>> +             valshift = UNIPHIER_UART_LCR_SHIFT;
>> +             /* Divisor latch access bit does not exist. */
>> +             value &= ~(UART_LCR_DLAB << valshift);
>> +             /* fall through */
>> +     case UART_MCR:
>> +             offset = UNIPHIER_UART_LCR_MCR;
>> +             break;
>> +     default:
>> +             normal = true;
>> +             break;
>> +     }
>> +
>> +     offset <<= p->regshift;
>> +
>> +     if (normal) {
>> +             writel(value, p->membase + offset);
>
> Perhaps put this in place where normal == true and use return instead of
> break?


In that case, I do not know where I should put
   offset <<= p->regshift
, which I want to run for all the cases.




-- 
Best Regards
Masahiro Yamada
