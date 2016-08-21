From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Sun, 21 Aug 2016 09:50:55 +0200
Message-ID: <CC150758-1D16-4BB7-A35B-1A7F4D061C7C@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk> <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com> <20160820142226.6121e76d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160820142226.6121e76d-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


> Am 20.08.2016 um 15:22 schrieb One Thousand Gnomes =
<gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:
>=20
> On Fri, 19 Aug 2016 19:42:37 +0200
> "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>=20
>>> Am 19.08.2016 um 13:06 schrieb One Thousand Gnomes =
<gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:
>>>=20
>>>> If possible, please do a callback for every character that arrives.
>>>> And not only if the rx buffer becomes full, to give the slave =
driver
>>>> a chance to trigger actions almost immediately after every =
character.
>>>> This probably runs in interrupt context and can happen often. =20
>>>=20
>>> We don't realistically have the clock cycles to do that on a low end
>>> embedded processor handling high speed I/O. =20
>>=20
>> well, if we have a low end embedded processor and high-speed I/O, =
then
>> buffering the data before processing doesn't help either since =
processing
>> still will eat up clock cycles.
>=20
> Of course it helps. You are out of the IRQ handler within the 9 serial
> clocks, so you can take another interrupt and grab the next byte. You
> will also get benefits from processing the bytes further in blocks,

if there are benefits from processing blocks. That depends on the =
specific
protocol.

My proposal can still check and then place byte by byte in a buffer and =
almost
immediately return from interrupt. Until a block is completed and then =
trigger
processing outside of the interrupt context.

> and if you get too far behind you'll make the flow control limit.
>=20
> You've also usually got multiple cores these days - although not on =
the
> very low end quite often.

Indeed. But low-end rarely has really high-speed requirements and then =
should
also run Linux. If it goes to performance limits, probably some =
assembler code
will be used.

And UART is inherently slow compared to SPI or USB or Ethernet.

>=20
>> The question is if this is needed at all. If we have a bluetooth =
stack with HCI the
>> fastest UART interface I am aware of is running at 3 Mbit/s. 10 bits =
incl. framing
>> means 300kByte/s equiv. 3=C2=B5s per byte to process. Should be =
enough to decide
>> if the byte should go to a buffer or not, check checksums, or discard =
and move
>> the protocol engine to a different state. This is what I assume would =
be done in
>> a callback. No processing needing some ms per frame.
>=20
> That depends on the processor - remember people run Linux on low end =
CPUs
> including those embedded in an FPGA not just high end PC and ARM class
> devices.
>=20
> The more important question is - purely for the receive side of things =
-
> is a callback which guarantees to be called "soon" after the bytes =
arrive
> sufficient.
>=20
> If it is then almost no work is needed on the receive side to allow =
pure
> kernel code to manage recevied data directly because the current
> buffering support throughout the receive side is completely capable of
> providing those services without a tty structure, and to anything =
which
> can have a tty attached.

Let me ask a question about your centralized and pre-cooked buffering =
approach.

As far as I see, even then the kernel API must notify the driver at the =
right moment
that a new block has arrived. Right?

But how does the kernel API know how long such a block is?

Usually there is a start byte/character, sometimes a length indicator, =
then payload data,
some checksum and finally a stop byte/character. For NMEA it is $, no =
length, * and \r\n.
For other serial protocols it might be AT, no length, and \r. Or =
something different.
HCI seems to use 2 byte op-code or 1 byte event code and 1 byte =
parameter length.

So this means each protocol has a different block format.

How can centralized solution manage such differently formatted blocks?

IMHO it can't without help from the device specific slave device driver. =
Which must
therefore be able to see every byte to decide into which category it =
goes. Which brings
us back to the every-byte-interrupt-context callback.

This is different from well formatted protocols like SPI or I2C or =
Ethernet etc.
where the controller decodes the frame boundaries and DMA can store the
payload data and an interrupt occurs for every received block.

So I would even conclude that you usually can't even use DMA based UART =
receive
processing for arbitrary and not well-defined protocols. Or have to =
assume that the
protocol is 100% request-response based and a timeout can tell that no =
more data
will be received - until a new request has been sent.

>=20
> Doesn't solve transmit or configuration but it's one step that needs =
no
> additional real work and re-invention.
>=20
> Alan

BR,
Nikolaus
