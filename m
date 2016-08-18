From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 22:29:00 +0200
Message-ID: <20160818202900.hyvm4hfxedifuefn@earth>
References: <20160818011445.22726-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l3wrhatavbnsvhsx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--l3wrhatavbnsvhsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Thanks for going forward and implementing this. I also started,
but was far from a functional state.

On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
> Currently, devices attached via a UART are not well supported in
> the kernel. The problem is the device support is done in tty line
> disciplines, various platform drivers to handle some sideband, and
> in userspace with utilities such as hciattach.
>
> There have been several attempts to improve support, but they suffer from
> still being tied into the tty layer and/or abusing the platform bus. This
> is a prototype to show creating a proper UART bus for UART devices. It is
> tied into the serial core (really struct uart_port) below the tty layer
> in order to use existing serial drivers.
>=20
> This is functional with minimal testing using the loopback driver and
> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
> device). It still needs lots of work and polish.
>=20
> TODOs:
> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
>   hoping all that complexity is from the tty layer and not needed here.
> - Split out the controller for uart_ports into separate driver. Do we see
>   a need for controller drivers that are not standard serial drivers?
> - Implement/test the removal paths
> - Fix the receive callbacks for more than character at a time (i.e. DMA)
> - Need better receive buffering than just a simple circular buffer or
>   perhaps a different receive interface (e.g. direct to client buffer)?
> - Test with other UART drivers
> - Convert a real driver/line discipline over to UART bus.
>=20
> Before I spend more time on this, I'm looking mainly for feedback on the
> general direction and structure (the interface with the existing serial
> drivers in particular).

I had a look at the uart_dev API:

int uart_dev_config(struct uart_device *udev, int baud, int parity, int bit=
s, int flow);
int uart_dev_connect(struct uart_device *udev);

  The flow control configuration should be done separately. e.g.:
  uart_dev_flow_control(struct uart_device *udev, bool enable);

int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);

  UART communication does not have to be host-initiated, so this
  API requires polling. Either some function similar to poll in
  userspace is needed, or it should be implemented as callback.
 =20
-- Sebastian

--l3wrhatavbnsvhsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXthqJAAoJENju1/PIO/qaJroQAI8Iyb5InhWdQk3s1cEQHSKh
gtEvQV4GOmZ6fRlbTergD31fUuiayMi0WMxauWLRKZIpXxFiNSRwiuC2CIz411TV
EfN1JoSLxF5wCrjDu9ez6BldC41g/jDo/GwAkryQ7xiqihJ8CryYAIqGLjFZ01sn
h3iZq/CZghh8qacWdgT1XUtNZ2lcKYISzvNnRysziUyFSICmsHnQr3Vx74Ar0hYv
5uPfjoI7SSheFWydCIcDs/fScAfJnoRboWrm3TGut0Q6MmJZCS/JZyCZUERIoacy
Slg2Y2aAVtuwjzKb/GYA0ftgJn3RlefYftneDiGoVh0EPXESMYUi0fccDdBUafIB
MXOPfUr4rMXpSoDo+hNSoTa5DcLfTIzjjIFJmiV8STgNkXhSo067BZDvziyVx/LY
2j7VbMQTX4MMM7OXg/MWTF6i4o+Gag0TBfuKngy2tR4csTmtE6N+85njaTYutRLj
X2hQeodW7Jwx7RV6mKtoscne66CmjaFAkJF8PjPIQkgCuiejpb4PM6bEsEkOcC3h
uYrfskuGVsmaVzRvizCSV2X3yRBKpE3IQHmITvWeR+CRVmKs8NU5kCOnyy/+ASXO
veVugvLw4Dr0ZaGcqR13BBW9bmQ8a6uBfznV9UL6KHOGlP4IqySf+1OlMWiYeYNV
0uJiK8W7yTedoCcVU7uA
=0Po/
-----END PGP SIGNATURE-----

--l3wrhatavbnsvhsx--
