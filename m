From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Which is better to specify console, "console= " or "stdout-path"
 ?
Date: Wed, 21 Oct 2015 13:54:21 +0100
Message-ID: <56278AFD.8000505@arm.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
 <562753A6.3070107@arm.com> <56278911.9050704@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56278911.9050704-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



On 21/10/15 13:46, Peter Hurley wrote:
> On 10/21/2015 04:58 AM, Sudeep Holla wrote:
>> On 21/10/15 06:09, Masahiro Yamada wrote:
>>> I think there exist two ways to specify the console port and baudrate.
>>>
>>>
>>> [1] Specify console in bootargs
>>>
>>>     chosen {
>>>           bootargs = "console=ttyS0,115200";
>>>     };
>>>
>>>
>>> [2] Specify stdout-path
>>>
>>>      chosen {
>>>            stdout-path = "serial0:115200n8";
>>
>> This will work for even early/boot console, so this is better than
>> option [1]
>
> Be aware that options specified via /chosen/stdout-path are
> currently ignored by earlycon. There were some hiccups getting the
> initial support upstream; when 4.4 hits mainline, I'll resubmit
> my series that implements the of_serial i/o properties and
> options passthrough to earlycon setup.
>

Yes I am aware of that. IIUC it's in -next now and works fine for me.
But having stdout-path in the DTS won't hinder normal console in anyway.
So I prefer it even without the patch you are referring(to support early
console parsing stdout-path)

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
