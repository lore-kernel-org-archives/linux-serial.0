From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 19:42:37 +0200
Message-ID: <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


> Am 19.08.2016 um 13:06 schrieb One Thousand Gnomes =
<gnomes@lxorguk.ukuu.org.uk>:
>=20
>> If possible, please do a callback for every character that arrives.
>> And not only if the rx buffer becomes full, to give the slave driver
>> a chance to trigger actions almost immediately after every character.
>> This probably runs in interrupt context and can happen often.
>=20
> We don't realistically have the clock cycles to do that on a low end
> embedded processor handling high speed I/O.

well, if we have a low end embedded processor and high-speed I/O, then
buffering the data before processing doesn't help either since =
processing
still will eat up clock cycles.

> The best you can do is
> trigger a workqueue to switch the buffer data around and call the =
helper
> while the uart may be receiving more bytes.

Ok, assuming DMA double buffering might (almost) double throughput.

The question is if this is needed at all. If we have a bluetooth stack =
with HCI the
fastest UART interface I am aware of is running at 3 Mbit/s. 10 bits =
incl. framing
means 300kByte/s equiv. 3=C2=B5s per byte to process. Should be enough =
to decide
if the byte should go to a buffer or not, check checksums, or discard =
and move
the protocol engine to a different state. This is what I assume would be =
done in
a callback. No processing needing some ms per frame.

>=20
> What you are asking for you'd get out of the first parts of tidying up
> the receive paths because you'd set a different port->rx() method and =
get
> bursts of characters, flags and length data.
>=20
> Alan
