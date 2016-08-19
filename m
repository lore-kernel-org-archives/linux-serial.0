From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 16:44:29 +0200
Message-ID: <20160819144428.akddnwfl5g5qhtq3@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
 <20160819052125.ze5zilppwoe3f2lx@earth>
 <20160819120305.4a3b1b54@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrml2jhy6jbpr337"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819120305.4a3b1b54@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--xrml2jhy6jbpr337
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Fri, Aug 19, 2016 at 12:03:05PM +0100, One Thousand Gnomes wrote:
> > I meant "Either some function similar to userspace's poll() is
> > needed, ...". Something like uart_dev_wait_for_rx()
>=20
> You can't really do that - it might never return and then how do
> you want to handle timeouts and cleanups

Well there could be some timeout. As I said, I was thinking about
an API similar to poll(), but I agree, that a callback based API
is probably the better solution. It's simpler to implement and in
most cases simpler to use.

> > Alternatively the rx function could be a callback, that
> > is called when there is new data.
>=20
> That's what the existing API gives you as an ldisc, it can't be
> immediate in many cases however but must be buffered.

I know and I think the ldisc API is fine in this regard. Also
the buffering allows DMA, so that's obviously preferred.

> > > I'm assuming the only immediate consumers are in-kernel. =20
> >=20
> > Yes, but the driver should be notified about incoming data.

-- Sebastian

--xrml2jhy6jbpr337
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtxtKAAoJENju1/PIO/qaAUEP/0pZt38WXTfx5lUI9bgBQYaW
Hv+B23gbd76158vPyuEwuktxCoTXwvV1E3avLtycfnrsCxvzp3DhNI6pw5HP2lcB
U4harpzxzP8aOwR8psWGs8t1JYJmzb7Y4aTn3Agi8pjPiS5lifvOlWpad07/4Z5k
tMPi5wdTgDKG6Pt22loNJec86u40+OBgAtppwILqgiUYAzc4X+P0DZ3a4SMzQ7HJ
P6bqk9OGmflrtWeiEc1kkAt3ElZxC+wRIRjlONpnJb5RichIVKMz6GasKkWNAvIG
y8fTAf7cC2xaK0G1aHNPc1Yi8osCPEaHe5hLVwQSSoZmCLC0p6Ccs5hQZSCp/wIM
5R7x8X1V5LqBnNB0h/wiXhKQxo1mKCQIZdsCEc3Cqi5ZCUtBphh1AZu6Tj6b4B3m
mFNRIAS+pk2hgcmrrGEznZem1cSMQ1iTMAxky8Dxl+ynKeQQeK1nFTG5bT5ppMxD
73G/b3AtdWkRlUgED5M5ZVVVQRcjdtpjMxUbsF8ePAfcMliOwIdkO6IyElxO/6TS
pE0Xk0/oFj2puIgsTF3c9wN09BsmNq9pzgbdFBuuXOik6OPufbLLEx5YnzOIMzKv
3rgnwTLbzApSt7nqq3YtShgTV9P/KmuvewNcHt1M4rHJbPoYGyFSn/jBheu6T+iJ
ZR/3KfUgGfsaWb31DNJD
=ZKrp
-----END PGP SIGNATURE-----

--xrml2jhy6jbpr337--
