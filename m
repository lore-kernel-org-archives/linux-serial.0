From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] serial: earlycon: allow to specify uartclk in
 earlycon kernel-parameter
Date: Fri, 23 Oct 2015 20:15:33 +0900
Message-ID: <CAK7LNARFOzkBVabThTOyZc28F2Kyt3fXnbJTWO632D1yUdg4oQ@mail.gmail.com>
References: <1445312189-28876-1-git-send-email-yamada.masahiro@socionext.com>
	<1445312189-28876-3-git-send-email-yamada.masahiro@socionext.com>
	<5626491A.8040908@hurleysoftware.com>
	<CAK7LNAQYbg4L9dX4riQ8Zb_NN7pbhx60aXwb4rZJgdTz-pocsQ@mail.gmail.com>
	<CAL_JsqL2MjN9_K5tBOEAnM7j5SXzipXXcBMUyyUacaFnpVOOJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqL2MjN9_K5tBOEAnM7j5SXzipXXcBMUyyUacaFnpVOOJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Stefan Agner <stefan@agner.ch>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

2015-10-23 0:34 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Tue, Oct 20, 2015 at 8:20 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi Peter,
>> (+ Rob Herring, Stefan Agner)
>>
>> 2015-10-20 23:00 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
>>> On 10/19/2015 11:36 PM, Masahiro Yamada wrote:
>>>> The input clock frequency varies from device to device, but the
>>>> earlycon uses the fixed frequency (BASE_BAUD * 16).  It makes
>>>> impossible to set the correct divisor to the register.
>>>
>>> So the bootloader hasn't setup the serial port?
>>
>> It does.
>> I use U-boot and the serial port is already set up by U-boot.
>
> This problem is now moving into u-boot which is using DT for configuration.
>
>> But, earlycon setup functions update hardware registers.
>> See  early_serial8250_setup(), ingenic_early_console_setup(), etc.
>>
>>
>> Without port->uartclk set to a valid value,
>> the init code in earlycon setup does not make sense.
>>
>>
>> What I want to clarify is,
>> what should we do in the earlycon setup function?
>>
>> Currently, I see
>>  [1] set device->con->write callback
>>  [2] initialize UART port registers
>>
>>
>> For [2], we need to know baudrate and input clock frequency.
>> (and the latter is missing, that's why my patch is here.)
>
> I'm missing context of what you did, but it needs to be parse-able
> from a flattened tree. My suggestion would be use clock-frequency
> property in the uart node. We should be able to parse that. This came
> up with u-boot as well[1].

Right.

But, I think things have been going wrong
since SPL started to parse a device tree.




-- 
Best Regards
Masahiro Yamada
