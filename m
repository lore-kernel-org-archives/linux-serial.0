Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767153B5E5
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789731; cv=none; b=uL8cQ99ILgw5Vmt44n65eg7ezstM5w1ExhHIMytMxHudTevTVSO1NgihDjZqvWvurm7SBYPN8TT8u3mButiH36pYhnB/GWPlR18YeJRXxn++fJ0xHnwCWnFpmv6zc34zziVJmvfy0dBC/eyIL2NnQnWVS9BCEx1pKGdrqx4ejfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789731; c=relaxed/simple;
	bh=vOKtFAes3FzbDDplqLaCiD5e4lVf9oFMBm4gHbTfOtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKkG4wViDUhelHKG6+XrMpC23KJesU5YxJkOwz8GocSG+TOdMxR5UV1DPNbqWlg2ZfDBoppjtuym7GMrY2wwMrlqZffj2f3B4fj/cCMk9gU/SkBikOQPZxPfVJl89dVub2gkP6IUwXfX1bSN4RkEwCg/PqGW4malYpqZjCEZ+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QYQ16/BD; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QYQ16/BD"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 399F3240106
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 19:35:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790789726;
	bh=dT/Hs+ay33oP7LeObujmA6DJM6pWp7qZoKPWA+ruDqI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=QYQ16/BD6HMxYpVyaN5otpnrMX/CQ9fHaNIEm9NljhPnMuTlOOBhnQwbkcBSgFQR6
	 q371LilnrM/lt7phUHynqKEPT6KRxbFNT+eLCkxvD+m6V8AH3WATs2+n6zoQu1efbd
	 cPlPilQ/P6FZbm7Ml37fXve8lgPyBDWfMFtQEGFdlNa7oMqY/l59fpwGo3fQWdP254
	 39yX5pu+09EGkAJmF4qrYxZDpsdqUHkq0v76lugMxlVnl/qB9aqvSb0H4o46Mycr+r
	 dEV2g10Ql3K8QpwV4cCWm1RzLg9WoXYlkQF147SrQdScoGzte61xfJjXHhVZFdCpjU
	 w6l/o83tWWU6Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hw2Hx1gTHz9rxR;
	Wed, 30 Sep 2026 19:35:25 +0200 (CEST)
Message-ID: <efe459f84fc81dcfb820fb8cdcc28dc0a13b2e8a.camel@posteo.de>
Subject: Re: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency field
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Date: Wed, 30 Sep 2026 17:35:25 +0000
In-Reply-To: <20260930154517.97E6B1F00898@smtp.kernel.org>
References: <20260930-acpi_spcr-v4-1-ab649aa1f09c@posteo.de>
	 <20260930154517.97E6B1F00898@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-BYg8AhYl4Gq//wFmZbEq"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-BYg8AhYl4Gq//wFmZbEq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-30 at 15:45 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] acpi: out-of-bounds read of SPCR uart_clk_freq field
> --
>=20
> commit 541ea063ef44d64e511d2deae13a8adcab45ebc7
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> ACPI: SPCR: Support UART clock frequency field
>=20
> This commit adds support for the UART Clock Frequency field introduced in=
 the
> Microsoft SPCR specification revision 1.08. It introduces a new function
> setup_earlycon_with_uartclk() to configure the serial port with the corre=
ct
> clock frequency from the SPCR table if available.
>=20
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table
>=20
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index 73cb933fdc89b..c79c809f49d46 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -228,7 +228,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bo=
ol enable_console)
> >  	pr_info("console: %s\n", opts);
> > =20
> >  	if (enable_earlycon)
> > -		setup_earlycon(opts);
> > +		setup_earlycon_with_uartclk(opts,
> > +					    table->header.revision >=3D 3 ? table->uart_clk_freq : 0);
>=20
> [Severity: Medium]
> Does this code risk an out-of-bounds memory read when accessing
> table->uart_clk_freq?
>=20
> In acpi_parse_spcr(), the table is mapped using acpi_get_table(), which
> only maps the number of bytes specified by table->header.length.
>=20
> If a malformed ACPI SPCR table is provided by system firmware where
> table->header.revision >=3D 3 but the length is too small to contain
> uart_clk_freq, could this access read past the mapped length?
>=20
> This could result in unmapped memory accesses leading to an early boot ke=
rnel
> panic, or silently reading garbage data which results in an incorrect ear=
ly
> console UART clock frequency.
>=20
> Should there be a validation of table->header.length against the expected
> size containing the uart_clk_freq field before accessing it?
>=20
> > =20
> >  	if (enable_console)
> >  		err =3D add_preferred_console(uart, 0, opts + strlen(uart) + 1);
Fields from revision 4 are being accessed, so I don't think accessing
one from revision 3 requires more checking.




--=-BYg8AhYl4Gq//wFmZbEq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmq9SFwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS5EUP/0YmKpV0x2JHlnW8iq+Z
/w4X0GTm29sQBzal+Lzh1+n8NJTwPdDKthxegKRi77FpBO03HAPDVQR8TipeCSn5
chdiGBCPwQSkTzbDzmB1CPZKPMDnXNJG16VKeiAZzZuYqHCFBWP7NKLNz9+pjVbq
ieageWTuyzo+nC2/Gy4IfTakTLoNZO0Mws8yy6gE65pT2tyzAD5jinbtmjIvMwmd
YZJsnJcdGYGjEWiC9ytmPjMwMPaQr4PpW7JLHHjRPhRtIZCDqb5UcqxZlRs451nq
apj8PIW980VYp3ANp05Ak55XWxlNUNIoA4PirTBkq8x4VMOr9lCeO5+W9Q0VU7cw
Uca4PSAib0df8si1O/S+Z+nq8Pyg0EM2XxLzWh+M5azMEirFDTKGtxDe8zpZbyW3
nERAExzUpTwh7o+Ij1jlIzL7llfK9Fmx8+tMAk1UoIA1ozug3+Bd5mEgHuUMgghN
SvtQITAUNWjoRxx0zjh5PKnyjnaWt5o427C3LnKNivqa9jy9Wx4sK7Cjt9mxofqe
3Zr4dvJjTDHOxaNrpevntwxJazPZMy8f6F6/3U3MeIMHJukCzyaTM8sxTfMEMVA7
6k0fZbnZm6NdLZ3quFE3+deapCAKwfufL3G9OSccfvNO2juPrQAS3lArJ0YVYmsO
J3rjQxwa5z6YMl1dLmNWiDkZ
=5LTw
-----END PGP SIGNATURE-----

--=-BYg8AhYl4Gq//wFmZbEq--
