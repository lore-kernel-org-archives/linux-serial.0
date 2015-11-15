From: Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Fix crash
Date: Mon, 16 Nov 2015 00:54:23 +0100
Message-ID: <56491B2F.30300@flawful.org>
References: <1446431576-4385-1-git-send-email-linux@roeck-us.net>
 <20151102073755.GN4931@pengutronix.de> <5637D1F5.2090608@flawful.org>
 <20151102212933.GB4931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151102212933.GB4931@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I think that Guenter's patch should be merged asap.
Right now the bug it fixes stops us from boot testing in qemu.

=46or the broken mctrl irq handling part, when Uwe
has converted mxs-auart to use the generic irq init,
I can do the same for etraxfs + make sure that it gets tested
properly on real hardware.

On 11/02/2015 10:29 PM, Uwe Kleine-K=C3=B6nig wrote:
> Helo Niklas,
>
> On Mon, Nov 02, 2015 at 10:13:25PM +0100, Niklas Cassel wrote:
>> On 11/02/2015 08:37 AM, Uwe Kleine-K=C3=B6nig wrote:
>>>> The function call in the etraxfs-uart driver was not renamed,
>>>> possibly due to interference with commit 7b9c5162c182 ("serial:
>>>> etraxfs-uart: use mctrl_gpio helpers for handling modem signals").
>>> Yes. BTW, 7b9c5162c182 looks broken, too, because the interrupt han=
dling
>>> is missing.
>> The only drivers including serial_mctrl_gpio.h is atmel_serial.c,
>> clps711x.c, mxs-auart.c and etraxfs-uart.c
>>
>> etraxfs commit
>> 7b9c5162c182 ("serial: etraxfs-uart: use mctrl_gpio helpers for hand=
ling modem signals")
>> is heavily influenced by
>> 62b0a1b3e759 ("serial: clps711x: Use mctrl_gpio helpers for handling=
 modem signals")
>>
>> a driver which also appears to lack mctrl irq setup/handling.
>>
>>
>> Uwe, are you going to convert all serial drivers that includes seria=
l_mctrl_gpio.h to
>> use the new mctrl_gpio_init? (which also sets up irqs)
> That is the plan. For drivers like mxs-auart (that do irq handling) t=
his
> is just simplification. When the irq handling is missing converting t=
o
> the new mctrl_gpio_init might introduce regressions because it does
> request_irq which might fail.
>
>> Since mctrl gpios are optional in the device tree, I guess mctrl_gpi=
o_init handles if
>> they are missing. So even if etraxfs-uart.c currently lacks mctrl ir=
q setup/handling,
>> if we migrate it to use the new mctrl_gpio_init, we will get this au=
tomatically?
> Right, if there are no gpios specified (new and old) mctrl_gpio is a
> nop.
>
> Best regards
> Uwe
>
