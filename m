From: Niklas Cassel <niklas.cassel@axis.com>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Wed, 22 Jul 2015 17:31:52 +0200
Message-ID: <55AFB768.1010105@axis.com>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net> <20150721210115.GJ9981@pengutronix.de> <55AEC50E.3030202@roeck-us.net> <20150722070659.GK9981@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150722070659.GK9981@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, linux-cris-kernel <linux-cris-kernel@axis.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 07/22/2015 09:06 AM, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jul 21, 2015 at 03:17:50PM -0700, Guenter Roeck wrote:
>> On 07/21/2015 02:01 PM, Uwe Kleine-K=C3=B6nig wrote:
>>> On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
>>>> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get fun=
ctions")
>>>> makes the flags argument to devm_gpiod_get_optional mandatory but =
does not
>>>> update all users. This results in the following build error.
>>>>
>>>> drivers/tty/serial/etraxfs-uart.c:933:16: error:
>>>> 	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=
=80=99
>>>>
>>>> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get fun=
ctions")
>>>> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> We discussed this driver while I worked on updating the gpiod API. =
I
>>> don't care much about this driver, but if you want to do something =
about
>>> the build failure, I'd prefer:
>>>
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfi=
g
>>> index 76e65b714471..3a6a7c235f09 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -1066,6 +1066,7 @@ config SERIAL_VT8500_CONSOLE
>>>  config SERIAL_ETRAXFS
>>>  	bool "ETRAX FS serial port support"
>>>  	depends on ETRAX_ARCH_V32 && OF
>>> +	depends on BROKEN
>>>  	select SERIAL_CORE
>>>
>>>  config SERIAL_ETRAXFS_CONSOLE
>>>
>>> Best regards
>>> Uwe
>>>
>>
>> Uwe,
>>
>> I understand the value of BROKEN, but I do not think it would be
>> appropriate here. It would be appropriate for a driver which is real=
ly
>> broken, not one that doesn't build anymore because an API it uses
>> was updated and the driver code wasn't updated for some reason.
>>
>> With your suggested patch I would no longer be able to run my qemu t=
ests
>> for this architecture, which I would not entirely be happy about.
>>
>> You may not care, but maybe others do.
>>
>> Makes me wonder: It used to be that API changes were handled by thos=
e
>> making the API changes, not by those responsible for the code using
>> the API. Has this changed recently, ie is it now acceptable to not
>> update all callers of a modified API (on purpose, as it looks like
>> it was done here) ?
> While I stumbled over the calls to gpiod_get variants in the etraxfs
> serial driver I noticed several problems with that driver. I pointed
> them out in
>=20
> 	http://www.spinics.net/lists/linux-serial/msg17794.html
>=20
> . If you read the follow-ups Jesper Nilsson then said:
>=20
> 	I can push a patch that just drops all signal handling (since
> 	it's bogus ATM), or you can ignore the driver as currently
> 	implemented.
>=20
> I explicitly did the latter. Apart from that single driver I fixed al=
l
> users. @Jesper: You said you poked Niklas to care for that. Any news
> from that front?

I've talked to Rabin Vincent, who has created an extraxfs gpio driver
that supports gpiolib (will come with 4.2).
Because of that, it might be nice to keep the modem control stuff.

The proper fix is probably to remove the devm_gpiod_get_optional calls
and instead use the serial_mctrl_gpio.c API.

I'll cook a patch this weekend.

>=20
> I'm all for the usual habit that API changes should be handled by the
> API changer. But if the code was already relying on undefined behavio=
ur
> before the change and fixing that needs testing on the respective
> hardware, I think pushing the needed work back to the driver owner is
> fine. IMHO a simple build fix that doesn't fix the brokeness isn't th=
at
> helpful here.
>=20
> Having said that I don't care for that driver. So if you say it's goo=
d
> enough for you to simply add GPIOD_ASIS and the responsible maintaine=
rs
> are ok, too, I won't stand in the way.
>=20
> Best regards
> Uwe
>=20
