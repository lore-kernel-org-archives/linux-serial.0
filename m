From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
Date: Mon, 2 Jul 2018 15:47:31 +0200
Message-ID: <20180702134731.GI13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-7-mperttunen@nvidia.com>
 <20180702131851.GH13096@ulmo>
 <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 04:30:07PM +0300, Mikko Perttunen wrote:
> On 02.07.2018 16:18, Thierry Reding wrote:
> > On Mon, Jul 02, 2018 at 02:40:31PM +0300, Mikko Perttunen wrote:
> > > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > > multiplexing multiple "virtual UARTs" into a single hardware serial
> > > port. The TCU is the primary serial port on Tegra194 devices.
> > >=20
> > > Add a TCU driver utilizing the mailbox framework, as the used mailbox=
es
> > > are part of Tegra HSP blocks that are already controlled by the Tegra
> > > HSP mailbox driver.
> > >=20
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >=20
> > > Notes:
> > >      v2:
> > >      - Removed (void) casts for unused variables.
> > >      - Changed the uart_set_options() call to be on one line, even if=
 its
> > >        over 80 characters.
> > >      - Added defines for magic numbers.
> > >      - Style fixes.
> > >      - Changed Kconfig entry to depend on the Tegra HSP driver instea=
d of
> > >        just the mailbox framework.
> > >      v3:
> > >      - Removed FLUSH bit, as it's unnecessary and slows down printing
> > >      - Removed call to uart_set_options
> > >      - Added mbox_free_channel calls to remove()
> > >=20
> > >   drivers/tty/serial/Kconfig       |   9 ++
> > >   drivers/tty/serial/Makefile      |   1 +
> > >   drivers/tty/serial/tegra-tcu.c   | 291 ++++++++++++++++++++++++++++=
+++++++++++
> > >   include/uapi/linux/serial_core.h |   3 +
> > >   4 files changed, 304 insertions(+)
> > >   create mode 100644 drivers/tty/serial/tegra-tcu.c
> >=20
> > The driver looks good to me. But for my own understanding, is there some
> > way we can make use of the multiplexing? That is, could we add a
> > mechanism to have the driver filter out only a specific stream? Could we
> > also specify which stream to send data back to? What happens by default?
> > Which stream is data sent to?
>=20
> There is no multiplexing on the producer/device side (i.e. what this driv=
er
> does). The mailbox specified in device tree specifies the stream we send
> stuff to. The mailboxes are per-CPU (we use the CCPLEX mailbox here), so =
it
> cannot really be changed.

Oh, I see, so there is one stream per pair of mailboxes? That is, the
mailboxes we specify in the DT define which stream we receive from and
send to?

Thierry

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6LPEACgkQ3SOs138+
s6GgoRAAgtnbovyRq903FXdRr2JlpUdtYTe6KCeaqJKUJLW/jeCa3FbHzG6e3j2S
z4su9htK4XWFVirwoGDnJgcQfgqIyfMpynjD8j+ol9L6q5ZMKGqKdg1+sNG6DwkF
M5oYhrTJVaSLlw2X6u3EeBCekqHQjwMEKrKAF+dA7HXOxkZ7vgH9k78VbLgO8yyq
40O7VIuJuLzPicAj74uRYQYBSpX1nyUWIjtoyBxhojFoUvein50Ek1XzEPf/Bgdy
7CM/x9K3Qh/P+shnJXHbbr8pDOTL0LeeOxmJQ90rRbbb0K8gwNpc+U6ZA0KHHYWt
+bKholbST16nc23pvv35KImjgHis+tYJ8y0TTtNoRI+l8nNCqGGRHLrmHRnhZHj9
RKGN2nd0sZf/MtcsciLWsVkI7i85SvxzulWI1Xty4Y4yfKBYOKyC+ix4ul7w3TRJ
Ztd4BVF22PUTkA9KNATLhlX2YvCjIs1MPI28u2YgY2UqNu135OBT49ggiK7Ys8oo
PwftqVO/Ipp/fdHYHLB3xckvhY30XsBHZqRnj+4K9yw6K3wNOBv5cqNrAl94+uBL
Q91dMAos5hVjKg5rEwPdbELYT4f0r53GpC/3BRgPlZzUY9NIqIPIdJfZZX55VCs4
dLHS7tgo2KhTOlkOYod2x6HjmdID4Xn9kjrcvYvO+OMVXMib0Rg=
=fZKs
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--
