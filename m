From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: earlycon: allow to specify uartclk in
 earlycon kernel-parameter
Date: Thu, 22 Oct 2015 10:34:11 -0500
Message-ID: <CAL_JsqL2MjN9_K5tBOEAnM7j5SXzipXXcBMUyyUacaFnpVOOJw@mail.gmail.com>
References: <1445312189-28876-1-git-send-email-yamada.masahiro@socionext.com>
 <1445312189-28876-3-git-send-email-yamada.masahiro@socionext.com>
 <5626491A.8040908@hurleysoftware.com> <CAK7LNAQYbg4L9dX4riQ8Zb_NN7pbhx60aXwb4rZJgdTz-pocsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQYbg4L9dX4riQ8Zb_NN7pbhx60aXwb4rZJgdTz-pocsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Stefan Agner <stefan@agner.ch>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 20, 2015 at 8:20 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Peter,
> (+ Rob Herring, Stefan Agner)
>
> 2015-10-20 23:00 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
>> On 10/19/2015 11:36 PM, Masahiro Yamada wrote:
>>> The input clock frequency varies from device to device, but the
>>> earlycon uses the fixed frequency (BASE_BAUD * 16).  It makes
>>> impossible to set the correct divisor to the register.
>>
>> So the bootloader hasn't setup the serial port?
>
> It does.
> I use U-boot and the serial port is already set up by U-boot.

This problem is now moving into u-boot which is using DT for configuration.

> But, earlycon setup functions update hardware registers.
> See  early_serial8250_setup(), ingenic_early_console_setup(), etc.
>
>
> Without port->uartclk set to a valid value,
> the init code in earlycon setup does not make sense.
>
>
> What I want to clarify is,
> what should we do in the earlycon setup function?
>
> Currently, I see
>  [1] set device->con->write callback
>  [2] initialize UART port registers
>
>
> For [2], we need to know baudrate and input clock frequency.
> (and the latter is missing, that's why my patch is here.)

I'm missing context of what you did, but it needs to be parse-able
from a flattened tree. My suggestion would be use clock-frequency
property in the uart node. We should be able to parse that. This came
up with u-boot as well[1].


> In order to be independent of a boot loader, we also need
>   [3]  pinctrl (pin-muxing)

We have to draw the line somewhere and I think this falls below it.
What if we have to turn on a regulator for the pins or RS-232
transceiver, turn on power domain, take peripheral out of reset, and
the list goes on... Hopefully a debug path would never be that
complicated.

> But, it is difficult to handle pinctrl in the earlycon framework.

earlycon is for debug. Either fix your bootloader or you need some
platform specific setup hacks to get the h/w in a working state if you
need to debug.

Rob

[1] https://patchwork.ozlabs.org/patch/492697/
