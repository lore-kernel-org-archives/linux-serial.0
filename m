From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
Date: Wed, 26 Oct 2016 04:51:08 +0200
Message-ID: <20161026025107.tb4x4qerqzenwsz7@earth>
References: <20160824232437.9446-1-robh@kernel.org>
 <20161025215521.5a5uxjpujmoatgor@earth>
 <CAL_JsqJQqkyz99SY=RcQ22ZzsQSuCjFkjEPLdEqLmJU-usBf-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wig7owtjqdlsl2ei"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJQqkyz99SY=RcQ22ZzsQSuCjFkjEPLdEqLmJU-usBf-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--wig7owtjqdlsl2ei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 25, 2016 at 05:02:23PM -0500, Rob Herring wrote:
> On Tue, Oct 25, 2016 at 4:55 PM, Sebastian Reichel wrote:
> > On Wed, Aug 24, 2016 at 06:24:30PM -0500, Rob Herring wrote:
> >> [...]
> > I had a more detailed look at the series during the last two weeks.
> > For me the approach looks ok and it should work for the nokia bluetooth
> > use case. Actually my work on that driver is more or less stalled until
> > this is solved, so it would be nice to get this forward. Whose feedback
> > is this waiting from? I guess
>=20
> I think it is mainly waiting for me to spend more time on it and get
> the tty port part done.

The general approach could already be commented on.

> I could use help especially for converting the BT part properly.

Ok, I will have a look at that.

> >  * Alan & Greg for the serial parts
> >  * Marcel for the bluetooth parts
> >  * Dmitry for the serio parts
> >
> > Maybe you can try to find some minutes at the Kernel Summit to talk
> > about this?
>=20
> Still waiting for my invite...
> But I will be at Plumbers if folks want to discuss this.

Ok. I obviously assumed invites have already been sent and that you
would be invited.

-- Sebastian

--wig7owtjqdlsl2ei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYEBoZAAoJENju1/PIO/qalWoP/2hMlQSat2GEaIxbgiQWqkv7
Ktx3m1IHWpIBeUQRf9n9tpEGzuyn68ObfnwuP7ES7y9FyQuQAvzJGJL23ZQ4+l2p
yWtOjpIZzERoQBDMFEgcNEXBCW/hYunTmcQbAtPtwHJ+OkAJxnoedVXCX/g4Dkmi
K8RiQmimGYfJ1iGCD/ID3gP/4ZvmVRri+KpWP/Z4IRfY/nByzOPGN6TMIKky5X1S
8XxWR6Nlkzo0fNDmG/9EJFwFXMQH8yt7BxQXIhdMlNV6NCU7SwtY7QiR7c9QXmUf
+as07Kt5qu/gLVIPTAl/2L2+ToLoyp5AT2VDVGMSvR6ZWdmsnGII1nKE2D1nnmIJ
hf/5DC6Brkn2EFgG0qlfylVBTrIYluRxvfEfdbxZfBD5f+3bTDZ+Y9Tsmhq3RSIp
CCd88TmtJ8++9vcqX42P+Ej1oOpWn42dbxyQyQPF7E8PH/KZxgtu4u+GXT+A6wc8
uCRQ2d3ofnYHhLInuf4O5Z1Uv6vF9ausYdrjFxVtpdfg4XCNrF0D9QF2xZIFE5EX
1YJ0zc19D/aIoTKANKSPBPGIc5zgV7U1cix5NcjwFWNSBZKv6D8hEpBFOXOgXPAw
9lKKjt3GnvbklHagHWLWm5NHhGyx3qcaIIp2K28gdqqOkJBAk9eOewj8iZkrq6Ji
VEUrfl5VunRt/0/lOH6d
=I4HM
-----END PGP SIGNATURE-----

--wig7owtjqdlsl2ei--
