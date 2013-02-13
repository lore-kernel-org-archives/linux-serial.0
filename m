From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] USB: serial: fix null-pointer dereferences on disconnect
Date: Wed, 13 Feb 2013 16:34:36 +0200
Message-ID: <20130213143436.GE4819@arwen.pp.htv.fi>
References: <20130213142513.GA21078@localhost>
 <1360765731-23164-1-git-send-email-jhovold@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360765731-23164-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2013 at 03:28:51PM +0100, Johan Hovold wrote:
> Make sure serial-driver dtr_rts is called with disc_mutex held after
> checking the disconnected flag.
>=20
> Due to a bug in the tty layer, dtr_rts may get called after a device has

why don't you fix the bug in the tty layer instead ?

--=20
balbi

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRG6R8AAoJEIaOsuA1yqRExfsP/jPKWASGqVavV9FYevQaeQtq
wWRPrZD20uFgqpOSX+9DLiPPZSc2FNmocOvrCJ+swaAZ9bCB0VZxc/hoFJn6hJpd
GbzSeFixiieILneTFv/RKAc6c84gdoxk55koZZ7Zm4eapv+Znomhcj2bEM7qr7ky
NJ5xfPUY0U9SezAA5z/TsZ7+BjQ0ZaStQuID2n75D1U0J3dfWKyin+g0/++dVb2A
7O5dIFDTx7FMA0DM9nOZtqO9Gnahd+88uoYlD6JSAbEjvRsoq5CgWcE+HHZZ9x4P
ERcsCIm/720k+XIHtMPz0+BShLOAChRI4Msv6ehmxymisBSDf/pKpHJTHejrtz+4
0phidaHauFBQ0FsmF1E37FzBJrfDBF/rugMe2nlCW3smQsF4Co1jM48FDYDwJFn2
0TM24boyVDn/4acYkb6wDI+7kUpICodlfEYY/CSzFEFKoZVaD0BtyYVQljJ21J5+
Turbrms3LnnAqz01RL3o2nZMSWGwlWaKlh1YEqKf6u9X+RGqU0FZctHRxPRo/XXi
K0GKZkFBNPzOXf2iuaSVmPLuiukvEIIGfhuHNFrI1tuT5R9ZBP6ozPZcNYcOaUYn
gvZ3MwybJpvxLKv8kM3pSs/290PPjrNd7E9B3gu+g20U0LdbjCAypa3Kao/JQs6L
L7vWCJe2P4jsqecWFQAj
=GO66
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
