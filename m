From: Niklas Cassel <niklas.cassel@axis.com>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Mon, 27 Jul 2015 15:29:37 +0200
Message-ID: <55B63241.7080409@axis.com>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>	<20150723222349.GB9973@kroah.com> <CACRpkdZce3Jfh3Mz0mW=XS72UUD5RP5okocLs_--N1B2aLNJDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZce3Jfh3Mz0mW=XS72UUD5RP5okocLs_--N1B2aLNJDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Cassel <niklass@axis.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-cris-kernel <linux-cris-kernel@axis.com>, Jesper Nilsson <jespern@axis.com>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7Zu?= =?UTF-8?B?aWc=?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On 07/27/2015 03:16 PM, Linus Walleij wrote:
> On Fri, Jul 24, 2015 at 12:23 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
>>> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get func=
tions")
>>> makes the flags argument to devm_gpiod_get_optional mandatory but d=
oes not
>>> update all users. This results in the following build error.
>>>
>>> drivers/tty/serial/etraxfs-uart.c:933:16: error:
>>>       too few arguments to function =E2=80=98devm_gpiod_get_optiona=
l=E2=80=99
>>>
>>> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get func=
tions")
>>
>> This patch isn't in Linus's tree, so whatever tree this commit is in=
,
>> needs to also take this fix.
>=20
> OK I'll take it. It's a bit messy with this breakage but it is for
> a good cause.
>=20
> Niklas: send me your patch when finished.

I've already sent them to the linux-serial and linux-kernel mailing lis=
ts.

I'm sorry that I didn't think of CC:ing you Linus.
It might be better if you take them, since you got
the devm_gpiod_get_optional patches in your tree.


http://marc.info/?l=3Dlinux-serial&m=3D143778406314867

http://marc.info/?l=3Dlinux-serial&m=3D143778407714871
