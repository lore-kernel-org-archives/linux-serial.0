From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [patch v1 0/2] JTAG driver introduction
Date: Mon, 28 Aug 2017 22:03:05 +0200
Message-ID: <20170828200305.GA5132@amd>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <20170802141209.GB25781@lunn.ch>
 <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
 <20170803174822.GI15018@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170803174822.GI15018-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org" <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, system-sw-low-level <system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, "openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org" <mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org>, "joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org" <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org" <vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org>, "tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org" <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Thanks a lot for review.
> >=20
>=20
> > We used user space tool for that, which is an adaptation of some
> > Lattice tools, which allows programming of SVF files. We are using
> > it for Lattice CPLD burning, since we have for such devices on our
> > system, but this tool could be used for programming other devices
> > from other vendors as well.
> =20
> > https://github.com/mellanoxbmc/mellanox-bmc-tools
>=20
> Since you are defining a new Kernel ABI here, it would be good to get
> some buy-in from potential users for the ABI. Maybe for the next
> version of the patchset you can cross post to the OpenOCD-devel list?

Actually, since you are defining a new ABI, it would be nice to have a
Documentation/ file with the ABI description, so that people can
review it...

Otherwise... yes, this looks like a step in right direction from 60000
feet above. I guess it is still a lot of work to get gdb running...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmkdvgACgkQMOfwapXb+vKkXQCghrgqdzW9nSfI8109zd6tzRlZ
5xoAniVlWnQFwV4TrpfbMvOW2cNp+FcA
=b1qT
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
