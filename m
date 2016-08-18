From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 20:31:52 +0200
Message-ID: <C03540BC-1F35-45EE-8B9F-24E24AB75C40@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818152528.569eb426@lxorguk.ukuu.org.uk> <227BE734-C9C1-4059-B0B4-EB47819703A8@goldelico.com> <20160818163809.1b2fcfe5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818163809.1b2fcfe5@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


> Am 18.08.2016 um 17:38 schrieb One Thousand Gnomes =
<gnomes@lxorguk.ukuu.org.uk>:
>=20
>>> Your changes also don't work because serial uart drivers are not =
obliged
>>> to use any of the uart buffering helpers and particularly on the rx =
side
>>> many do not do so and the performance hit would be too high. =20
>>=20
>> The SoC I have, is using it.
>=20
> The Linux kernel does generalised implementations. Yes it may work on
> your board but it doesn't work for everything.

It needs to work only on boards with a SoC UART. Not with a tty over
USB or something else. This is the generalisation I see. Any SoC with
uart_port driver support (and as far as I see many are).

> It's the difference
> between doing it properly and hacking your board to work.

Agreed. But solving problems nobody really has is overengineering.

Especially if the generalised implementation that is being discussed
(tty_port) does not even solve the problem. Or only in a very clumsy
and difficult way. In such a case a generalisation seems to be the
wrong approach to me.

And we should start to accept that we mix up different requirements
and try a single solution for almost everyone we can imagine (which
isn't bad initially, but can prohibit to find a solution at all) except =
the
real use case that is on the table. That is why I always come back
to the practical problem to implement my driver and want to know
how it can be done.

BR,
Nikolaus
