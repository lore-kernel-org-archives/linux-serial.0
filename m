From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: Which is better to specify console, "console= " or "stdout-path" ?
Date: Thu, 22 Oct 2015 00:38:15 +0900
Message-ID: <CAK7LNAQ_+_9K-y7bmpdGwcH2u4uqJhJhON1Ew4OvzSSa-amyvw@mail.gmail.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
	<562753A6.3070107@arm.com>
	<56278911.9050704@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56278911.9050704-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Peter.

2015-10-21 21:46 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
> On 10/21/2015 04:58 AM, Sudeep Holla wrote:
>> On 21/10/15 06:09, Masahiro Yamada wrote:
>>> I think there exist two ways to specify the console port and baudrate.
>>>
>>>
>>> [1] Specify console in bootargs
>>>
>>>    chosen {
>>>          bootargs = "console=ttyS0,115200";
>>>    };
>>>
>>>
>>> [2] Specify stdout-path
>>>
>>>     chosen {
>>>           stdout-path = "serial0:115200n8";
>>
>> This will work for even early/boot console, so this is better than
>> option [1]
>
> Be aware that options specified via /chosen/stdout-path are
> currently ignored by earlycon. There were some hiccups getting the
> initial support upstream; when 4.4 hits mainline, I'll resubmit
> my series that implements the of_serial i/o properties and
> options passthrough to earlycon setup.


As I said in another thread ("serial: earlycon: allow to specify
uartclk in earlycon kernel-parameter"),
stdout-path can pass dev->baud, but not port->uartclk.

It is usually specified "clocks" phandle, but
clk is not ready at the point of earlycon.

It seems impossible to set up the baudrate even if the options are passed.


-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
