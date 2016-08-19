From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 19:50:45 +0200
Message-ID: <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_3B8DB423-CB48-46E6-BD45-731B5C27893C"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--Apple-Mail=_3B8DB423-CB48-46E6-BD45-731B5C27893C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 19.08.2016 um 09:49 schrieb Oleksij Rempel =
<linux@rempel-privat.de>:
>=20
> Hallo Nikolaus,
>=20
> do i understand it correctly. This driver is to make kind of interchip
> communication and represent uart as a bus to allow use this bus from
> multiple kernel driver or expose it to user space?

The idea for UART slave devices is to handle devices connected on an
embedded board to an UART port in kernel. Currently most such devices
are just passed through to some /dev/tty and handled by user-space =
daemons.

So it is not necessarily about multiple kernel drivers to use the same =
UART, although
that could also be required.

A single one is already difficult... And some scenarios need to shield =
the UART
from user space (currently there is always one /dev/tty per UART - =
unless the
UART is completely disabled).

Some ideas where it might be needed:
* bluetooth HCI over UART
* a weird GPS device whose power state can only reliably be detected by =
monitoring data activity
* other chips (microcontrollers) connected through UART - similar to I2C =
slave devices
* it potentially could help to better implement IrDA (although that is =
mostly legacy)

What it is not about are UART/RS232 converters connected through USB or =
virtual
serial ports created for WWAN modems (e.g. /dev/ttyACM, /dev/ttyHSO). Or =
BT devices
connected through USB (even if they also run HCI protocol).

>=20
> Correct?
>=20
> Am 19.08.2016 um 09:29 schrieb H. Nikolaus Schaller:
>> Hi,
>>=20
>>> Am 19.08.2016 um 07:21 schrieb Sebastian Reichel <sre@kernel.org>:
>>>=20
>>> Hi,
>>>=20
>>> On Thu, Aug 18, 2016 at 06:08:24PM -0500, Rob Herring wrote:
>>>> On Thu, Aug 18, 2016 at 3:29 PM, Sebastian Reichel <sre@kernel.org> =
wrote:
>>>>> Thanks for going forward and implementing this. I also started,
>>>>> but was far from a functional state.
>>>>>=20
>>>>> On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
>>>>>> Currently, devices attached via a UART are not well supported in
>>>>>> the kernel. The problem is the device support is done in tty line
>>>>>> disciplines, various platform drivers to handle some sideband, =
and
>>>>>> in userspace with utilities such as hciattach.
>>>>>>=20
>>>>>> There have been several attempts to improve support, but they =
suffer from
>>>>>> still being tied into the tty layer and/or abusing the platform =
bus. This
>>>>>> is a prototype to show creating a proper UART bus for UART =
devices. It is
>>>>>> tied into the serial core (really struct uart_port) below the tty =
layer
>>>>>> in order to use existing serial drivers.
>>>>>>=20
>>>>>> This is functional with minimal testing using the loopback driver =
and
>>>>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for =
the slave
>>>>>> device). It still needs lots of work and polish.
>>>>>>=20
>>>>>> TODOs:
>>>>>> - Figure out the port locking. mutex plus spinlock plus =
refcounting? I'm
>>>>>> hoping all that complexity is from the tty layer and not needed =
here.
>>>>>> - Split out the controller for uart_ports into separate driver. =
Do we see
>>>>>> a need for controller drivers that are not standard serial =
drivers?
>>>>>> - Implement/test the removal paths
>>>>>> - Fix the receive callbacks for more than character at a time =
(i.e. DMA)
>>>>>> - Need better receive buffering than just a simple circular =
buffer or
>>>>>> perhaps a different receive interface (e.g. direct to client =
buffer)?
>>>>>> - Test with other UART drivers
>>>>>> - Convert a real driver/line discipline over to UART bus.
>>>>>>=20
>>>>>> Before I spend more time on this, I'm looking mainly for feedback =
on the
>>>>>> general direction and structure (the interface with the existing =
serial
>>>>>> drivers in particular).
>>>>>=20
>>>>> I had a look at the uart_dev API:
>>>>>=20
>>>>> int uart_dev_config(struct uart_device *udev, int baud, int =
parity, int bits, int flow);
>>>>> int uart_dev_connect(struct uart_device *udev);
>>>>>=20
>>>>> The flow control configuration should be done separately. e.g.:
>>>>> uart_dev_flow_control(struct uart_device *udev, bool enable);
>>>>=20
>>>> No objection, but out of curiosity, why?
>>>=20
>>> Nokia's bluetooth uart protocol disables flow control during speed
>>> changes.
>>>=20
>>>>> int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
>>>>> int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);
>>>>>=20
>>>>> UART communication does not have to be host-initiated, so this
>>>>> API requires polling. Either some function similar to poll in
>>>>> userspace is needed, or it should be implemented as callback.
>>>>=20
>>>> What's the userspace need?
>>>=20
>>> I meant "Either some function similar to userspace's poll() is
>>> needed, ...". Something like uart_dev_wait_for_rx()
>>>=20
>>> Alternatively the rx function could be a callback, that
>>> is called when there is new data.
>>>=20
>>>> I'm assuming the only immediate consumers are in-kernel.
>>>=20
>>> Yes, but the driver should be notified about incoming data.
>>=20
>> Yes, this is very important.
>>=20
>> If possible, please do a callback for every character that arrives.
>> And not only if the rx buffer becomes full, to give the slave driver
>> a chance to trigger actions almost immediately after every character.
>> This probably runs in interrupt context and can happen often.
>>=20
>> In our proposal some months ago we have implemented such
>> an rx_notification callback for every character. This allows to work
>> without rx buffer and implement one in the driver if needed. This
>> gives the driver full control over the rx buffer dimensions.
>>=20
>> And we have made the callback to return a boolean flag which
>> tells if the character is to be queued in the tty layer so that the
>> driver can decide for every byte if it is to be hidden from user
>> space or passed. Since we pass a pointer, the driver could even
>> modify the character passed back, but we have not used this
>> feature.
>>=20
>> This should cover most (but certainly not all) situations of
>> implementing protocol engines in uart slave drivers.
>>=20
>> Our API therefore was defined as:
>>=20
>> void uart_register_slave(struct uart_port *uport, void *slave);
>> void uart_register_rx_notification(struct uart_port *uport,
>> 		bool (*function)(void *slave, unsigned int *c),
>> 				struct ktermios *termios);
>>=20
>> Registering a slave appears to be comparable to uart_dev_connect()
>> and registering an rx_notification combines uart_dev_config() and
>> setting the callback.
>>=20
>> Unregistration is done by passing a NULL pointer for 'slave' or =
'function'.
>>=20
>> If there will be a very similar API with a callback like this, we =
won't have
>> to change our driver architecture much.
>>=20
>> If there is a uart_dev_wait_for_rx() with buffer it is much more =
difficult
>> to handle.
>>=20
>> BR,
>> Nikolaus
>>=20
>>=20
>=20
>=20
> --
> Regards,
> Oleksij
>=20


--Apple-Mail=_3B8DB423-CB48-46E6-BD45-731B5C27893C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXt0b2AAoJEIl79TGLgAm6tnwP/0PmnkZ6pMNbZD6VgEJzXh6U
zKrZKBxfI/q+ccwOH3NFU4cN0lj/pIqgo3PgifLwIdt6+3C3a1F9YOMG+InlbQa6
URQ4oRhtoadrATaQHu+EterNNZP8CgaHqr69BM/grmMFB8NuFVH3Cnq/DKdr5zp+
bllmkKC0pifK6YPvYHV2AM8uEoRTECOelwzjp2BVt5BxTbi4W6zdL32iRh4T9A0h
nkVAesc2fCgIJasolhP8LGPe/BL4iGOoqPwaocg3A6nU5+aHXvyacciKokJ/slnS
M33WnNN0GjPRh2jpRFlb5m7lcDKoRVJ6gnWTj77eKd5dVAFYcO1rLWm5dKvaEqf3
elZsjRslg+eE94iqeBwNdxqJquNrklw2W1ElxM32o/SLkeVuAAevcMUIwLMm/NrU
1sBcXUWj6DD85mhEdNe4ZZbVN6rT9G8srMEgShxKQO5N9BcSxL1K4tperQUwsDU8
vnIYEqHWXKPLOyQPVyGAsl2bTFwuO3O6Y0jVYKOdU2q8Tx0qYjXWBfwfwmMal+gn
OOOsA1hcpM7x0dPJcu8OyKKl3KZOKHCGzVWbOjkPK3tNVA+Av24zt8LdUcgAGcF2
Mrvg0LW0Vq4XY7JzV5N0ge3oaK/uw31lz2rhGeufmgJcIawQjl95Ok8efjWAveA1
b9MbeZlATdSkhLI6PNox
=BH+w
-----END PGP SIGNATURE-----

--Apple-Mail=_3B8DB423-CB48-46E6-BD45-731B5C27893C--
