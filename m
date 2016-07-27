From: Sebastian Reichel <sre@kernel.org>
Subject: Re: debug tip after earlycon is closed?
Date: Wed, 27 Jul 2016 04:17:49 +0200
Message-ID: <20160727021748.GA9857@earth>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 27, 2016 at 10:23:09AM +0900, Masahiro Yamada wrote:
> When the kernel fails to boot and its log console is silent,
> I use earlycon and I often find the cause of error with it.
>=20
> But, I have been wondering if there is an easy-to-use
> debug tip which is available after earlycon is disabled.
>=20
> I noticed the current mainline would not boot on my ARMv8 board.
> According to the following log, I am guessing something wrong
> is happening after the "bootconsole [uniphier0] disabled" log.
>=20
> Is there a good practice to see more log?

Documentation/kernel-parameters.txt=20
	keep_bootcon	[KNL]
			Do not unregister boot console at start. This is only
			useful for debugging when something happens in the window
			between unregistering the boot console and initializing
			the real console.

-- Sebastian

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXmBnJAAoJENju1/PIO/qalJQP/3ff6J+lufTDyNIxHQk+FCSz
hG1yiHBGPReYalD5CABd0av4PQkcTZ56oUVv6+YVr4D7MeVMv+CaGdRTqQx5IpBg
q6u4TP7fUjXEMrVCz3mNu9LiPvc+sudOYYfchZh98Z5zJkl37ymXjWeZHvDRvJNw
bdkQv3H5040OYwAQdSmr7hU2zUyBOV+qBD7vc2OmLvYC+WiZwKS8PXUyCJFDAYDy
GQ+xbSph9bEFb0YKchq4tzHHoryl2PiB7qh3d3rIeylHDdB0AYvuyIWhCjuR5EYv
KB7+tUx+prXBXk13ipkGkd3HF9+xQIZba0Ng59cbklcWQ/V9cxeE9/0wK+epw2pf
KudvytcQDZtnJqe3TBgkMjTnrqJzzfdYY2jQ1zkBHLR6UYtDpxLRAxVHqdggId42
tGkS2quMXjcCNC9kLjI0WQuLrg84SPitgkHuiVXPsEiURUFXuvHDKu++4MRQ+k+X
byS75TBlXDtXQgO4OwW3S6epYDH6vlDCnox1zGYj9WT59XP3hhpiPbZgMDg2/2vq
xBC2d/NgltMQgdWM3M7TDZVBrUh9R7i88WD2ImxzqwYL3TwSQsISURsjwRLo5gGH
TFvNy0dfafCNkKWnrQ9zc+CwAfegZGewitruj9v1hMnL2xWXDUsCQPH8RQTQK11f
glgEay1WPCOJHjM5d2yB
=lo4L
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
