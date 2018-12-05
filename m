From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 11/14] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
Date: Wed, 5 Dec 2018 14:03:48 +0900
Message-ID: <5dcbde7f-8458-8630-9f7e-115a9c8364e4@socionext.com>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
 <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi

Thank you for your comments.

On 2018/12/04 20:23, Masahiro Yamada wrote:
> Hi Sugaya-san
> 
> On Mon, Nov 19, 2018 at 10:01 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Add Milbeaut M10V pinctrl.
>> The M10V has the pins that can be used GPIOs or take multiple other
>> functions.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> 
> 
> This patch was sent to:
> 
> linux-clk@vger.kernel.org,
> devicetree@vger.kernel.org,
> linux-arm-kernel@lists.infradead.org,
> linux-kernel@vger.kernel.org,
> linux-serial@vger.kernel.org
> 
> 
> 
> 
> Unfortunately, the most important ML
> 
>    linux-gpio@vger.kernel.org
> 
> was not addressed.
> 
> 
> The pinctrl maintainer may not notice this patch.

Ah I took a critical mistake...

> 
> 
> 
> 
> 
> 
> 
>> diff --git a/drivers/pinctrl/pinctrl-m10v.c b/drivers/pinctrl/pinctrl-m10v.c
>> new file mode 100644
>> index 0000000..d4ca713
>> --- /dev/null
>> +++ b/drivers/pinctrl/pinctrl-m10v.c
>> @@ -0,0 +1,765 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Socionext Ltd.
>> + * Copyright (C) 2015 Linaro Ltd.
>> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> 
> 
> My company name is "Socionext Inc." instead of "Socionext Ltd."

Yes, modify it.

> 
> 
> 
> 
> 
> 
> 
>> +static struct platform_driver m10v_pinctrl_driver = {
>> +       .probe  = m10v_pinctrl_probe,
>> +       .driver = {
>> +               .name           = "m10v-pinctrl",
>> +               .of_match_table = m10v_pmatch,
>> +       },
>> +};
>> +
>> +static int __init m10v_pinctrl_init(void)
>> +{
>> +       return platform_driver_register(&m10v_pinctrl_driver);
>> +}
>> +arch_initcall(m10v_pinctrl_init);
> 
> 
> Can't it be builtin_platform_driver()?

I think using builtin_platform_driver() is no problem.

> 
> Which device requires this to be arch_initcall()?

This driver was originally a module, so no need to be arch_initcall().
I will use arch_initcall() instead.

Thanks
Sugaya Taichi

> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 
