From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Sun, 21 Aug 2016 20:23:10 +0200
Message-ID: <FF7761E8-377A-43AD-96B2-83BA140E030B@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk> <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com> <20160820142226.6121e76d@lxorguk.ukuu.org.uk> <CC150758-1D16-4BB7-A35B-1A7F4D061C7C@goldelico.com> <20160821180910.51cf919d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160821180910.51cf919d@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


> Am 21.08.2016 um 19:09 schrieb One Thousand Gnomes =
<gnomes@lxorguk.ukuu.org.uk>:
>=20
>> Let me ask a question about your centralized and pre-cooked buffering =
approach.
>>=20
>> As far as I see, even then the kernel API must notify the driver at =
the right moment
>> that a new block has arrived. Right?
>=20
> The low level driver queues words (data byte, flag byte)
> The buffer processing workqueue picks those bytes from the queue and
> atomically empties the queue

When and how fast is the work queue scheduled?
And by which event?

> The workqueue involves the receive handler.

This should be faster than if a driver directly processes incoming =
bytes?

>=20
>> But how does the kernel API know how long such a block is?
>=20
> It's as long as the data that has arrived in that time.

Which means the work queue handler have to decide if it is enough for a
frame to decode and if not, wait a little until more arrives.

Or you have to assemble chunks into a frame, i.e. copy data around.

Both seems a waste of scarce cpu cycles in high-speed situations to me.

>=20
>> Usually there is a start byte/character, sometimes a length =
indicator, then payload data,
>> some checksum and finally a stop byte/character. For NMEA it is $, no =
length, * and \r\n.
>> For other serial protocols it might be AT, no length, and \r. Or =
something different.
>> HCI seems to use 2 byte op-code or 1 byte event code and 1 byte =
parameter length.
>=20
> It doesn't look for any kind of protocol block headers.

Which might become the pitfall of the design because as I have described =
it is an
essential part of processing UART based protocols. You seem to focus on =
efficiently
buffering only but not about efficiently processing the queued data.

> The routine
> invoked by the work queue does any frame recovery.

>=20
>> So I would even conclude that you usually can't even use DMA based =
UART receive
>> processing for arbitrary and not well-defined protocols. Or have to =
assume that the
>=20
> We do, today for bluetooth and other protocols just fine

I think it works (even with user-space HCI daemon) because bluetooth HCI =
is slow (<300kByte/s).

> - it's all about
> data flows not about framing in the protocol sense.

Yes, but you should also take framing into account for a solution that =
helps to implement
UART slave devices. That is my concern.

BR,
Nikolaus=
