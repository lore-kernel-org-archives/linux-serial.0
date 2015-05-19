From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3] serial: 8250_uniphier: add UniPhier serial driver
Date: Tue, 19 May 2015 17:54:02 +0900
Message-ID: <CAK7LNARrjkCcMsVJwe5hdB71QsEQAf51sNf4xYVMkNazdbdxKA@mail.gmail.com>
References: <1431997900-18390-1-git-send-email-yamada.masahiro@socionext.com>
	<CABuKBeJwOp3Km=Vw+xn8cRtH8DC-TNB_m7s8WSdPxzKHdzrdcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBeJwOp3Km=Vw+xn8cRtH8DC-TNB_m7s8WSdPxzKHdzrdcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, John Crispin <blogic@openwrt.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Matthias,

2015-05-19 17:22 GMT+09:00 Matthias Brugger <matthias.bgg@gmail.com>:
> 2015-05-19 3:11 GMT+02:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Add the driver for on-chip UART used on UniPhier SoCs.
>>
>> This hardware is similar to 8250 with a slightly different register
>> mapping, so it should go into drivers/tty/serial/8250 directory.
>
> The patch is for a driver in this folder, so no need to but it in the
> commit message.
> Instead just write a short description about the difference to a
> standard 8250 device.
>
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v3:
>>   - Just add *_SHIFT macro for the special case
>>
>> Changes in v2:
>>   - Drop unnecessary #include <linux/init.h>
>>   - Sort includes in alphabetical order
>>   - Use devm_clk_get() rather than of_clk_get()
>>   - Delete unneeded clk_put() from uniphier_uart_remove callback
>>   - Delete unneeded IS_ERR_OR_NULL check from uniphier_uart_remove callback
>>   - Use UNIPHIER_UART_*_SHIFT instead of hard-coded shift values
>>   - Change the first argument type of uniphier_of_serial_setup()
>>     from (struct platform_device *) to (struct device *) for code-cleanup.
>>
>>  drivers/tty/serial/8250/8250_uniphier.c | 237 ++++++++++++++++++++++++++++++++
>>  drivers/tty/serial/8250/Kconfig         |   7 +
>>  drivers/tty/serial/8250/Makefile        |   1 +
>>  3 files changed, 245 insertions(+)
>>  create mode 100644 drivers/tty/serial/8250/8250_uniphier.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
>> new file mode 100644
>> index 0000000..50349bf
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_uniphier.c
>> @@ -0,0 +1,237 @@
>> +/*
>> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/serial_8250.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/serial_reg.h>
>> +#include "8250.h"
>> +
>> +/* Most (but not all) of UniPhier UART devices have 64-depth FIFO. */
>> +#define UNIPHIER_UART_DEFAULT_FIFO_SIZE        64
>> +
>> +#define UNIPHIER_UART_CHAR_FCR 3       /* Character / FIFO Control Register */
>> +#define UNIPHIER_UART_LCR_MCR  4       /* Line/Modem Control Register */
>> +#define     UNIPHIER_UART_LCR_SHIFT    8
>> +#define UNIPHIER_UART_DLR      9       /* Divisor Latch Register */
>
> Nit pick: Please fix identation. After "define" just put one blank.
> I personally prefer that the define values are aligned by tabs, but
> that's up tu you.
>

I intentionally use deeper indentation for *_SHIFT
because I want to clearly show  UNIPHIER_UART_LCR_SHIFT
belongs to UNIPHIER_UART_LCR_MCR register.

I also want to describe them within 80 columns including comments,
so I cannot insert extra TABs to align the values.

-- 
Best Regards
Masahiro Yamada
