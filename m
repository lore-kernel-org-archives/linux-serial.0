From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: Which is better to specify console, "console= " or "stdout-path"
 ?
Date: Wed, 28 Oct 2015 12:00:01 -0400
Message-ID: <5630F101.1080803@hurleysoftware.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
 <562753A6.3070107@arm.com> <56278911.9050704@hurleysoftware.com>
 <CAK7LNAQ_+_9K-y7bmpdGwcH2u4uqJhJhON1Ew4OvzSSa-amyvw@mail.gmail.com>
 <5627BCBC.5040701@hurleysoftware.com>
 <CAK7LNASqjd_Xf53WKa=Ogesf80HQzEoKEyVtw-BMh7JF=jq+xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7LNASqjd_Xf53WKa=Ogesf80HQzEoKEyVtw-BMh7JF=jq+xQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Masahiro,

On 10/22/2015 12:20 AM, Masahiro Yamada wrote:
> 2015-10-22 1:26 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
>> On 10/21/2015 11:38 AM, Masahiro Yamada wrote:
>>> 2015-10-21 21:46 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
>>>> On 10/21/2015 04:58 AM, Sudeep Holla wrote:
>>>>> On 21/10/15 06:09, Masahiro Yamada wrote:
>>>>>> I think there exist two ways to specify the console port and baudrate.
>>>>>>
>>>>>>
>>>>>> [1] Specify console in bootargs
>>>>>>
>>>>>>    chosen {
>>>>>>          bootargs = "console=ttyS0,115200";
>>>>>>    };
>>>>>>
>>>>>>
>>>>>> [2] Specify stdout-path
>>>>>>
>>>>>>     chosen {
>>>>>>           stdout-path = "serial0:115200n8";
>>>>>
>>>>> This will work for even early/boot console, so this is better than
>>>>> option [1]
>>>>
>>>> Be aware that options specified via /chosen/stdout-path are
>>>> currently ignored by earlycon. There were some hiccups getting the
>>>> initial support upstream; when 4.4 hits mainline, I'll resubmit
>>>> my series that implements the of_serial i/o properties and
>>>> options passthrough to earlycon setup.
>>>
>>>
>>> As I said in another thread ("serial: earlycon: allow to specify
>>> uartclk in earlycon kernel-parameter"),
>>> stdout-path can pass dev->baud, but not port->uartclk.
>>
>> That's true but I'm not seeing in that thread where you wrote that?
> 
> Sorry, I made you confused.  I was talking about the kernel parameter (console=)
> in the thread.
> 
>> My replies there were specific to uartclk on the kernel command line,
>> which isn't necessary if the bootloader has already initialized the
>> uart.
>>
>>> It is usually specified "clocks" phandle, but
>>> clk is not ready at the point of earlycon.
>>>
>>> It seems impossible to set up the baudrate even if the options are passed.
>>
>> It's difficult to understand what you're trying to do when I can't
>> see the code you're referring to.  For example, I only recently
>> understood that you're talking about a earlycon implementation
>> that you're working on and not the 8250 earlycon itself.
> 
> Sorry again for making you confused.
> 
> I was talking both.
> 
> Now I am tackling on some ARM board porting.
> 
> 
> The board has a pure 8250 family device (compatible = "ns16550a") on it.
> 
> In addition, there exist 8250-variant IPs inside the SoC.
> (this is similar to 8250, but slightly different.
> drivers/tty/serial/8250/8250_uniphier.c)
> 
> 
> What I want to do is:
>   [1] To use  drivers/tty/serial/8250/8250_early.c  for the on-board ns16550a.
>   [2] To implement my own EARLYCON_DECLARE() in
> drivers/tty/serial/8250/8250_uniphier.c
> 
> 
> 
>> If you look at other non-8250 earlycons, you'll see they all ignore
>> the baud rate, on the assumption the bootloader already set it up.
> 
> OK, I will do so for [2].
> 
> 
>> The 8250 earlycon is a little different because legacy platforms
>> do not initialize the uart.
> 
> 
> Make sense.
> 
> For legacy platforms, earlycon initializes the uart,
> assuming the hard-coded "port->uartclk = BASE_BAUD * 16"
> is the value.
> 
> 
> For embedded boards such as ARM, the boot-loader should initialize the UART
> and the earlycon should preserve it because port->uartclk varies from
> board to board.
> (For example, the ns16550a on my board expects   BASE_BAUD is 1228000,
> but it does not match the one in include/asm-generic/serial.h )

I want to clarify one point: if you have a configuration for which the
earlycon uart is not initialized by the bootloader (or boot prom), then
we can add a way for the ASoC init to set BASE_BAUD. This was done for
the ARC arch, but I would like to use this as a last resort for the ARM
arch.

An example configuration I can envision that would require this solution
is u-boot's so-called 'falcon mode' without devicetree (or boot prom).

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
