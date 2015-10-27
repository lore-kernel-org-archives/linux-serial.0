From: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Tue, 27 Oct 2015 16:45:12 +0100
Message-ID: <562F9C08.6050105@svenbrauch.de>
References: <1445958479.2043.6.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ifAh49fGP3CObuoQNM2eSw442KF5M9sgk"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445958479.2043.6.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ifAh49fGP3CObuoQNM2eSw442KF5M9sgk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Oliver,

On 27/10/15 16:07, Oliver Neukum wrote:
> the theory that the lack of support for put_char() is a
> major contributor to character loss in cdc-acm can be tested.
> Sven, could you test the attached patch? It implements
> the support.
Thanks a lot for caring about this. I applied the patch to a plain linux
4.2 tree, but unfortunately I couldn't see any improvements. Applying
the patch I originally sent to the list for comparison still fixed the
issue.

Best regards,
Sven



--ifAh49fGP3CObuoQNM2eSw442KF5M9sgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWL5wLAAoJEGjKjjjEuz9LFdIQAKT4hKwXVh95a8ckGgHuA4Q5
ZotZx4YDSBzhxoVQKzSnc0vwPvCGzmVZelCRY0Fkjs1Bzee1mrMcx8ScwxbA15j5
bPk+TgbDkmTqHIm5pMgr+bUt9DTlnV+bthbKzy9d1+tXo5x7dBPrO83bu3u5QHeP
xbeeUPe3+wtcFkFEfHR2uIYCHZRR23mfPHsmI9QuhDNtnwqSEV75zXykbiwVYI3V
1j9hspjQPkSkdLHrvKRrnYxOP9iz+eegzg4eOd43gGZzi3isfRu2WGCs2laNxs1C
5Fhm0yAdqNpovMhrzrZOPyAIOwnpfkKMauftcZIcp+e9c6iVQWO/FYdi9CIufEHk
v/nzaLgbmLvb8vFR6bz8z8dUze2GWQiKtaW8t3Vm63w1iGjzEKqb4GXw7YWHf/E5
tTGr7R3NrXSwCel0gVox7btfdEZwHAIn+PXXZjyl1jMn9r+mz8PaqWbfHAsqCd6h
eQusArQUJ5KL42Cu6DlBIusfT33yOXGn8RTiLIbUx0/401U55IBtBJZmEpLbEWfP
dY+r5zsTSdzrQNhlu3EvKZuJibQ84eNgtftTuiT0vJMD69zu/5sSaClG9XTYND9X
V4AYz9zvQnbZ0ie1u4TvrPWqdZC5OvPhIgivpFv/wCA3gxrKVzlOhDDgXIs9Kzdp
W+dcw3mFg8xpOQ7myGRw
=C+dg
-----END PGP SIGNATURE-----

--ifAh49fGP3CObuoQNM2eSw442KF5M9sgk--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
