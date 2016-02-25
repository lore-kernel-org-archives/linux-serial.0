From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2] serial: xuartps: Enable OF earlycon support
Date: Thu, 25 Feb 2016 14:04:23 +0100
Message-ID: <56CEFBD7.40008@monstr.eu>
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
 <56C5F670.50005@hurleysoftware.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SNMRLUeo1PkB5uCxbDJHawLTKQ76UGaJu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C5F670.50005@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SNMRLUeo1PkB5uCxbDJHawLTKQ76UGaJu
Content-Type: multipart/mixed; boundary="HCfdR1aCouLhL4Hef6vRuDKR09jNqXMCh"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Peter Hurley <peter@hurleysoftware.com>,
 Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-ID: <56CEFBD7.40008@monstr.eu>
Subject: Re: [PATCH v2] serial: xuartps: Enable OF earlycon support
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
 <56C5F670.50005@hurleysoftware.com>
In-Reply-To: <56C5F670.50005@hurleysoftware.com>

--HCfdR1aCouLhL4Hef6vRuDKR09jNqXMCh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On 18.2.2016 17:50, Peter Hurley wrote:
> On 02/17/2016 11:57 PM, Michal Simek wrote:
>> Support early console setup via DT for all listed compatible strings.
>> Remove EARLYCON_DECLARE which was done by:
>> "Use common framework for earlycon declarations"
>> (sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
>> when OF_EARLYCON_DECLARE is defined.
>=20
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Can you please add it your queue for 4.6?
Or can we merge it via arm-soc tree as was suggested by Arnd here?
https://lkml.org/lkml/2016/2/16/315

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--HCfdR1aCouLhL4Hef6vRuDKR09jNqXMCh--

--SNMRLUeo1PkB5uCxbDJHawLTKQ76UGaJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlbO+9sACgkQykllyylKDCFF5ACfWn7s1pMiLbcd60OXhs/r6wzS
hGMAnRwBMYLMlm8YA9Z8u1JRF+VUdFRg
=pTaX
-----END PGP SIGNATURE-----

--SNMRLUeo1PkB5uCxbDJHawLTKQ76UGaJu--
