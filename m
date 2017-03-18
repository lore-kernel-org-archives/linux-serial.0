From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 01/10] ARM: dts: N9/N950: add bluetooth
Date: Sat, 18 Mar 2017 01:58:24 +0100
Message-ID: <20170318005824.ax2pgx4sl4tbwz6o@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-2-sre@kernel.org>
 <20170317152529.GA8723@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xygpnfdwh4gfkf27"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317152529.GA8723@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--xygpnfdwh4gfkf27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 17, 2017 at 04:25:29PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > The Nokia N950 and N9 have a wl1271 (with nokia bootloader) bluetooth
> > module connected to second UART.
>=20
> I don't get it. We are describing hardware, what does it have to do
> with bootloader? Is there something not described here, because it is
> already initialized by bootloader?

This is about the wl1271 "bootloader"/low-level interface. The same
chip exists with a TI low-level interface, which requires a
different driver/firmware.

-- Sebastian

--xygpnfdwh4gfkf27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljMhioACgkQ2O7X88g7
+pq9xBAAlRf1BMRW1SR5qz7WsJXVvbK5+fD5G07NvDI2jX13p5PY/pQcnm4BlGMi
jK3wSkN1+t/6G5YoKS3zkP5qkbtvR0g4k3qtYeLIWHDMJFy5mptfeloPRc8LF3yO
YiXSrWAt0ye/jSecjZJMRU7unobms/x4xkJ56pM5pxUUTJOJwwiZm5xSEj3CfXC0
vRC005rDWi9+S3RsjKis9AqEwahp0opaIURavutL+4+uz0H4qCzhlIrXw9x6Rn0q
r1O0lNfVqRdygvPokzN3WzyH3y/vR7NtWBCFJbOVr7+/7S8RQa7w10+AOVFbohWU
qbD5DllS/pgB2SvkQi8aIQKf7879JU71jh1BrcwRrUPaFRC6/ZfcRfobZ3IwaeSz
v+l/dDo7OWA8nBYRPdf4SRXHH4bHtQooZJMww6Y+fTE1ETnrBbhH2aro+HoMbQWE
hDUaB34tFPZwI7dSkeHsGGQ+/YTkhcD9Ywjk8EC71PIddqDtN5Aha6YpNaDGwlss
9Tx2QvvovYRwhLi4je+KIFrMoM1Do6xqyt5/0xVfkIHwDI3eCfO6YK3Tnnaxuevn
N20yxh5VSB6QdIGD2hnuhgV1JiEM2YUdOGZCt23zNfP0vzG+nyVCYoNU7+C4wDLZ
OQLOXCeOOehFdeYtAykmjfQuSgR5I/WBxZ1SxZaUgvsVMat6HXo=
=MAbP
-----END PGP SIGNATURE-----

--xygpnfdwh4gfkf27--
