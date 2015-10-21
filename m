From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: Which is better to specify console, "console= " or "stdout-path"
 ?
Date: Wed, 21 Oct 2015 12:26:36 -0400
Message-ID: <5627BCBC.5040701@hurleysoftware.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
 <562753A6.3070107@arm.com> <56278911.9050704@hurleysoftware.com>
 <CAK7LNAQ_+_9K-y7bmpdGwcH2u4uqJhJhON1Ew4OvzSSa-amyvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7LNAQ_+_9K-y7bmpdGwcH2u4uqJhJhON1Ew4OvzSSa-amyvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 10/21/2015 11:38 AM, Masahiro Yamada wrote:
> Hi Peter.
> 
> 2015-10-21 21:46 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
>> On 10/21/2015 04:58 AM, Sudeep Holla wrote:
>>> On 21/10/15 06:09, Masahiro Yamada wrote:
>>>> I think there exist two ways to specify the console port and baudrate.
>>>>
>>>>
>>>> [1] Specify console in bootargs
>>>>
>>>>    chosen {
>>>>          bootargs = "console=ttyS0,115200";
>>>>    };
>>>>
>>>>
>>>> [2] Specify stdout-path
>>>>
>>>>     chosen {
>>>>           stdout-path = "serial0:115200n8";
>>>
>>> This will work for even early/boot console, so this is better than
>>> option [1]
>>
>> Be aware that options specified via /chosen/stdout-path are
>> currently ignored by earlycon. There were some hiccups getting the
>> initial support upstream; when 4.4 hits mainline, I'll resubmit
>> my series that implements the of_serial i/o properties and
>> options passthrough to earlycon setup.
> 
> 
> As I said in another thread ("serial: earlycon: allow to specify
> uartclk in earlycon kernel-parameter"),
> stdout-path can pass dev->baud, but not port->uartclk.

That's true but I'm not seeing in that thread where you wrote that?
My replies there were specific to uartclk on the kernel command line,
which isn't necessary if the bootloader has already initialized the
uart.

> It is usually specified "clocks" phandle, but
> clk is not ready at the point of earlycon.
> 
> It seems impossible to set up the baudrate even if the options are passed.

It's difficult to understand what you're trying to do when I can't
see the code you're referring to.  For example, I only recently
understood that you're talking about a earlycon implementation
that you're working on and not the 8250 earlycon itself.

If you look at other non-8250 earlycons, you'll see they all ignore
the baud rate, on the assumption the bootloader already set it up.

The 8250 earlycon is a little different because legacy platforms
do not initialize the uart.

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
