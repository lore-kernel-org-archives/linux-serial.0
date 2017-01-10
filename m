From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Tue, 10 Jan 2017 13:40:21 +0100
Message-ID: <ABB60E46-46B5-4F8B-9458-83F61785A2BF@goldelico.com>
References: <20170106162635.19677-1-robh@kernel.org> <8E1651EC-E9E5-4BB5-84CB-8CFEE08009BA@goldelico.com> <D24F4B26-1F83-4154-A183-791C5C20DD1F@holtmann.org> <6C3E6EA6-5B22-47E8-B2B2-C37D4D080505@goldelico.com> <1484050829.2133.9.camel@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484050829.2133.9.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

> Am 10.01.2017 um 13:20 schrieb Andy Shevchenko =
<andriy.shevchenko@linux.intel.com>:
>=20
> On Tue, 2017-01-10 at 13:10 +0100, H. Nikolaus Schaller wrote:
>=20
>>> So the question is really if a driver only needs to do power
>>> management on open() and close() or if it also has to translate or
>>> transform the packets. There are devices who speak NMEA and all is
>>> good.
>>=20
>> The device I want to upstream the driver speaks NMEA but should be
>> powered down unless accessed...
>=20
> By the way, have you seen the series [1] I'm working on towards =
bringing
> runtime PM for all (current) serial drivers?
>=20
> [1] https://www.spinics.net/lists/linux-serial/msg24025.html

sorry no.

Interesting: "The series has been tested on our hardware with serial =
console and RxD
used as GPIO to wake it."

We had implemented a driver ca. 5 years ago (Neil Brown did it) for our =
GPS chip by
doing exactly this (setting the RxD to GPIO and interrupt mode to know =
when it sends
data but the UART is off).

This would have been completely based on existing APIs (pinmux states, =
gpio)
and would not even have needed any general serial device bus driver API =
because
it did not tamper with the UART+tty layers but the RxD line.

So from a viewpoint of encapsulation it would have done what it should =
inside the
driver.

But there was no consensus to accept that to mainline.

What we need for this chip is quite special regarding PM. It is not =
about knowing
when to suspend/resume or power down/up the UART or host.

It is about that the chip might be in the wrong state, i.e. powered on =
when it
should be off and vice versa. This can only be detected by monitoring =
RxD
activity and taking action if it is in the unexpected state. And that =
must
be possible independently of some user space having /dev/ttyO1 opened.

BR,
Nikolaus
