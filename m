From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] tty: uartps: Initialize ports according to aliases
Date: Thu, 23 Jan 2014 15:49:53 +0100
Message-ID: <52E12C11.4090008@monstr.eu>
References: <c1882ea5f2e45b19cc1930b624254cb1b59b2fe0.1390488303.git.michal.simek@xilinx.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="udadgKURhCcQeKGE52NmVSj188lsgXU76"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1882ea5f2e45b19cc1930b624254cb1b59b2fe0.1390488303.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--udadgKURhCcQeKGE52NmVSj188lsgXU76
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/23/2014 03:45 PM, Michal Simek wrote:
> Register port numbers according to order in DT aliases.
> If aliases are not defined, order in DT is used.
> If aliases are defined, register port id based
> on that.
> This patch ensures proper ttyPS0/1 assignment.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---

oou - Ignore this version - will send v2.

Sorry,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--udadgKURhCcQeKGE52NmVSj188lsgXU76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLhLBEACgkQykllyylKDCEJ5QCfduCqJCBtG/4F9P4Fm8TGH5vg
RTAAnRX0YL5/eYgCTa7r1fcXFrJbWfiK
=47Jj
-----END PGP SIGNATURE-----

--udadgKURhCcQeKGE52NmVSj188lsgXU76--
