From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Sun, 8 Jan 2017 23:46:00 +0100
Message-ID: <20170108224600.3ecr5p3zsdoyhwld@earth>
References: <20170106162635.19677-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2yvfjazprwpnhi7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106162635.19677-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--h2yvfjazprwpnhi7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Jan 06, 2017 at 10:26:26AM -0600, Rob Herring wrote:
> Here goes another attempt at a serial device bus (aka uart slaves, tty
> slaves, etc.).
>=20
> After some discussions with Dmitry at LPC, I decided to move away from
> extending serio and moved back to making a new bus type instead. He didn't
> think using serio was a good fit, and serio has a number of peculiarities
> in regards to sysfs and it's driver model. I don't think we want to inher=
it
> those for serial slave devices.
>=20
> This version sits on top of tty_port rather than uart_port as Alan
> requested. Once I created a struct tty rather than moving everything
> needed to tty_port, it became a lot easier and less invasive to the tty
> core code.
>=20
> I have hacked up versions of the BT ldisc and TI ST drivers moved over to
> use the serdev bus. I have BT working on the HiKey board which has TI BT.
> With the serdev bus support, it eliminates the need for the TI userspace
> UIM daemon.
>=20
> This series and the mentioned drivers can be found here[1].
>=20
> Rob

After adding kernel docs in patch 1, the DT binding change and mine
and Andy's comments in patch 7 the series is

"Reviewed-By: Sebastian Reichel <sre@kernel.org>"

-- Sebastian

--h2yvfjazprwpnhi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhywSgACgkQ2O7X88g7
+poJ6BAAibKFa0utWHcZ3uuZhCtKRa8spj6cNKOa0Az8dxUWIFBG+2qdwbncYEgM
Sojo64zqCmqu94QrgMWgQZ9et6dd0PUoLFHqLvzVmdu731h4sGHWrYVbgRDSglgl
g0ZWa7Z5y0sE/yPtJr4ruPbLvFQekerwSR9S2QhJnATohUTwbZbmXpkz22b/tmRJ
kYdDAkrSR8j9puazzDadMjeMhSMX9g6l3TXdw2xuQT1WN5puXeep8gFHpw0eniLC
kwIGAAlM3KNpf1kEx2dubbxnuBUgXIDxykVoGoGESKp45Jm5xXUG5a2mCTj0F1L/
txH46wMCjlsszjayt+pbZsPEOQrj0NgkbmLbotttoWXCllkaFCXKPPrXphn1qiVm
49HroK/8fEk/uh++3YQRLntFFjamMldma3KMLtxlLIQsN/zali4lE/xDMg3Rr17f
ERdoN/fEw2Xc/ZrDqXwCinKKBQpr9WBo5x1whEkRxGrnpbvqp/bvz+Gqa2MxCMSX
RDS07VW4IVxTZ4T3evKdS/yVc3dWB+Zc+tbgJ9WJvUhrHhRWAXYOCCp7gkur1io0
nB2UkdcNs+fo1q+o0wPZX1uAZf8oFqIZcR5emSXZWIgf8XmkzyLSR5bSQe9beODD
ZaWnE8vL2ozSz5fxVh8RLMhRTOXycXLmnE9ZmArvK1mTpsPn8dA=
=EJqO
-----END PGP SIGNATURE-----

--h2yvfjazprwpnhi7--
