From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 09:29:38 +0200
Message-ID: <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_7CFF76AE-B5E5-4397-84A1-F92AAD8B3D3F"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819052125.ze5zilppwoe3f2lx@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--Apple-Mail=_7CFF76AE-B5E5-4397-84A1-F92AAD8B3D3F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 19.08.2016 um 07:21 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> Hi,
>=20
> On Thu, Aug 18, 2016 at 06:08:24PM -0500, Rob Herring wrote:
>> On Thu, Aug 18, 2016 at 3:29 PM, Sebastian Reichel <sre@kernel.org> =
wrote:
>>> Thanks for going forward and implementing this. I also started,
>>> but was far from a functional state.
>>>=20
>>> On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
>>>> Currently, devices attached via a UART are not well supported in
>>>> the kernel. The problem is the device support is done in tty line
>>>> disciplines, various platform drivers to handle some sideband, and
>>>> in userspace with utilities such as hciattach.
>>>>=20
>>>> There have been several attempts to improve support, but they =
suffer from
>>>> still being tied into the tty layer and/or abusing the platform =
bus. This
>>>> is a prototype to show creating a proper UART bus for UART devices. =
It is
>>>> tied into the serial core (really struct uart_port) below the tty =
layer
>>>> in order to use existing serial drivers.
>>>>=20
>>>> This is functional with minimal testing using the loopback driver =
and
>>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the =
slave
>>>> device). It still needs lots of work and polish.
>>>>=20
>>>> TODOs:
>>>> - Figure out the port locking. mutex plus spinlock plus =
refcounting? I'm
>>>>  hoping all that complexity is from the tty layer and not needed =
here.
>>>> - Split out the controller for uart_ports into separate driver. Do =
we see
>>>>  a need for controller drivers that are not standard serial =
drivers?
>>>> - Implement/test the removal paths
>>>> - Fix the receive callbacks for more than character at a time (i.e. =
DMA)
>>>> - Need better receive buffering than just a simple circular buffer =
or
>>>>  perhaps a different receive interface (e.g. direct to client =
buffer)?
>>>> - Test with other UART drivers
>>>> - Convert a real driver/line discipline over to UART bus.
>>>>=20
>>>> Before I spend more time on this, I'm looking mainly for feedback =
on the
>>>> general direction and structure (the interface with the existing =
serial
>>>> drivers in particular).
>>>=20
>>> I had a look at the uart_dev API:
>>>=20
>>> int uart_dev_config(struct uart_device *udev, int baud, int parity, =
int bits, int flow);
>>> int uart_dev_connect(struct uart_device *udev);
>>>=20
>>>  The flow control configuration should be done separately. e.g.:
>>>  uart_dev_flow_control(struct uart_device *udev, bool enable);
>>=20
>> No objection, but out of curiosity, why?
>=20
> Nokia's bluetooth uart protocol disables flow control during speed
> changes.
>=20
>>> int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
>>> int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);
>>>=20
>>>  UART communication does not have to be host-initiated, so this
>>>  API requires polling. Either some function similar to poll in
>>>  userspace is needed, or it should be implemented as callback.
>>=20
>> What's the userspace need?
>=20
> I meant "Either some function similar to userspace's poll() is
> needed, ...". Something like uart_dev_wait_for_rx()
>=20
> Alternatively the rx function could be a callback, that
> is called when there is new data.
>=20
>> I'm assuming the only immediate consumers are in-kernel.
>=20
> Yes, but the driver should be notified about incoming data.

Yes, this is very important.

If possible, please do a callback for every character that arrives.
And not only if the rx buffer becomes full, to give the slave driver
a chance to trigger actions almost immediately after every character.
This probably runs in interrupt context and can happen often.

In our proposal some months ago we have implemented such
an rx_notification callback for every character. This allows to work
without rx buffer and implement one in the driver if needed. This
gives the driver full control over the rx buffer dimensions.

And we have made the callback to return a boolean flag which
tells if the character is to be queued in the tty layer so that the
driver can decide for every byte if it is to be hidden from user
space or passed. Since we pass a pointer, the driver could even
modify the character passed back, but we have not used this
feature.

This should cover most (but certainly not all) situations of
implementing protocol engines in uart slave drivers.

Our API therefore was defined as:

void uart_register_slave(struct uart_port *uport, void *slave);
void uart_register_rx_notification(struct uart_port *uport,
		bool (*function)(void *slave, unsigned int *c),
				struct ktermios *termios);

Registering a slave appears to be comparable to uart_dev_connect()
and registering an rx_notification combines uart_dev_config() and
setting the callback.

Unregistration is done by passing a NULL pointer for 'slave' or =
'function'.

If there will be a very similar API with a callback like this, we won't =
have
to change our driver architecture much.

If there is a uart_dev_wait_for_rx() with buffer it is much more =
difficult
to handle.

BR,
Nikolaus



--Apple-Mail=_7CFF76AE-B5E5-4397-84A1-F92AAD8B3D3F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXtrVjAAoJEIl79TGLgAm6sm0P/2kw5R4mg9kCsnZVtRKSRcE0
/L+sFZdi+1spLq2qCOwda3iuGRiKIHGMKgsRWKOJ+tfTCMmX3AXiTh8/sWRYh+7N
wbu9PzgX2OYYTT16NEPJIWJ+b6Kq96oNQyEWVqko1ld4nuQiEEROEE9k5i5zpe8g
HxLPW/JLb5qq5SoQNK28lsOP4E+TTM18yWvUHAmO+zxfFOqdaKwYnbCtEfF0/VcZ
KHs7gwkEP44viiX7sEQ7TEi0eubal1+ZEePfTwl5x+ZqGSjC0LvitNocueNqn9is
Pi/kAZkgEI84MbdnG4651RGb2BpI+Wh0yTBqRHZAP/YeNQ7ryUJCVUK9I4K0z77S
oyM+rpl3mtBWa4mrnqZzf5AyEeGK8OQdOyBvG+4pnxbJ2fSoH305IuS6TEANe1yg
nlSJYkAZ8CH7xP/1LSD7dcDneL+uaqpbJqxDn8HkJ3DSNnsmWK6s/m/umx8Y/BYz
W8sVYVdP0MQqzPmX+R0lGetGpm+iLPuxsgyoG7buIS071wOE12Oq5B8j8Xzy6Gre
HKXewryHNdWL0efJRaaCIGSiBliIRpqmLtjiwcGbrlc5R4vq3BJ+keevMEgCqxWH
BSH+/DthS6iJT0ziZbUFaIjFAIF3tGknUepBsTbqVbNFWgYO5zwJFS8A8mA7BE9e
vBEHDYaaNq5WB9CNQnN7
=CgpS
-----END PGP SIGNATURE-----

--Apple-Mail=_7CFF76AE-B5E5-4397-84A1-F92AAD8B3D3F--
