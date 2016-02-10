From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Wed, 10 Feb 2016 18:42:53 +0100
Message-ID: <3C1ABADD-C0B2-430A-99B3-EAF9B56D0A49@martin.sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org> <56BB719B.8070007@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <56BB719B.8070007@i2se.com>
Sender: linux-clk-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Eric Anholt <eric@anholt.net>
List-Id: linux-serial@vger.kernel.org


> On 10.02.2016, at 18:21, Stefan Wahren <stefan.wahren@i2se.com> wrote=
:
>=20
> Hi,
>> Maybe someone has gotten any idea?
>=20
> this sounds like an issue i had with the compute module here:
>=20
> http://permalink.gmane.org/gmane.linux.kernel.rpi/2197
>=20
This one was fixed - if I remember correctly.

> Unfortunately i don't have the cm anymore.
>=20
> Maybe you can try this downstream patch:
>=20
> https://github.com/raspberrypi/linux/commit/09041f7ccbd1cde792edae91c=
41266886d5d1382
>=20
I wonder if it is really interrupts that are the root cause
to mee it looks like a clock problem - especially as it actually
impacts the PL011 driver and not the aux driver=E2=80=A6

And initializing the other way (pl011 is console, aux as tty)
works without any issues - so it HAS to do with accessing the
PL011 or the clock framework.

Martin

