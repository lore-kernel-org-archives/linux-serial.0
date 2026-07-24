Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FA445AD7
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906088; cv=none; b=I0jBC9WcI7A55dLFyezYgXGFiUDQLMHc3U9KSeODyOeB2aNEWimMRa659RYWdlC6MfsDXiRWMH6udENddlNguxE1qsLhSeQiDmGQli6AATWU4EOhzURhLF4zakC0xFmNOWgkLJK/qcNf2getj003vsIEtkod5U1j1aEQYW1WXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906088; c=relaxed/simple;
	bh=n0pBVxy5eNbWWv8Y33rhd5euKRFf+nQBn0YeKUrQEKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fk1imton7XOYKFwZc7AuBT6Va2by5yRBWN37HI0r96mCNqmSeczCKG9/Binhe0iskiKMLviedM7PiiwoDx1ZWOSfdHmHfk+R8h/FEmfwk3wW4ZzzIeCNPcMfBza8XAQDrgzbV1e/R7D24fLMqdQqN5jaRcyuDJgewjAOcxXeY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=WnzXKd4M; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="WnzXKd4M"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C2CC8240103
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 17:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784906080;
	bh=THbesUwzWx2HO5x6yeM0Yf8fs9T5DdvJebQlm+3NfH8=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=WnzXKd4McxK92ztBPCswiKJIQq8/d2FXs5r7PQoLyJO3aJTmEP7fO3DlV508MIf+d
	 xkNDIV9nrix305LNrZ1EsO8wVOCbTVQwOI/70VQ3manE9zVmtz8hxfOFwiTKt2489F
	 1M2e3l3RFtXSGwmOEaz/1KZQTgPp08Oa+wOYJXIwQDJ5s6ZTwW3mCftnmC4OVpnrJx
	 OCl1skTiTxxk02S5DfP1QoEhzz3j29LIch20jNh/OarP4Yr/xLkwGjk/HUlg7jHgRp
	 afMwNeLCIxAk1SQxNVRU/ZxPR2f9HXCXAljJcZscPhWaDO+B6bDsYUmDdcD/80GMdu
	 So9Smz6k7Cj/A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h6BNv4Nwjz9rxB;
	Fri, 24 Jul 2026 17:14:39 +0200 (CEST)
Message-ID: <90b044a8bc6c53130afde5fc5686ae8bb547031f.camel@posteo.de>
Subject: Re: [PATCH v3 2/2] ACPI: SPCR: Support UART clock frequency field
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Date: Fri, 24 Jul 2026 15:14:40 +0000
In-Reply-To: <2026071007-amaze-tartly-6282@gregkh>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
	 <20260615-acpi_spcr-v3-2-9a59ebad74ea@posteo.de>
	 <2026071007-amaze-tartly-6282@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Xed+nY/kxpigcvlehwto"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-Xed+nY/kxpigcvlehwto
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-10 at 14:34 +0200, Greg Kroah-Hartman wrote:

I just noticed, I never replied to this email.
My apologies for the late response.

> On Mon, Jun 15, 2026 at 12:40:22AM +0000, Markus Probst wrote:
> > The Microsoft Serial Port Console Redirection (SPCR) specification
> > revision 1.08 comprises additional field: UART Clock Frequency [1].
> >=20
> > It contains a non-zero value indicating the UART clock frequency in Hz.
>=20
> Ok, but then what are we going to do with this?  Please make this a lot
> more descriptive, I have no idea what this is supposed to be doing at
> all.
The SPCR table provides information about a serial port. This can be
used, to make use of a serial port, before the necessary drivers are
loaded. Linux makes use of this in the earlycon console, if `earlycon`
is added to the kernel parameters.

Currently the "UART clock frequency" field in the SPCR table is
completely ignored. Thus if the uart clock frequency differs from the
kernel default of `BAUD*16`, it results in a misconfiguration of the
serial port.

>=20
> >=20
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serpor=
ts/serial-port-console-redirection-table [1]
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/acpi/spcr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index 73cb933fdc89..c79c809f49d4 100644
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
> Why the magic number 3?
As seen on the Link in the commit message, the "UART Clock Frequency"
field was introduced in the SPCR table with revision 3. For lower
revisions, this value must be ignored (and should be 0 anyway).

Thanks
- Markus Probst

>=20
> thanks,
> greg k-h

--=-Xed+nY/kxpigcvlehwto
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpjgVobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSyoEP/1n08OeLwwzniIeiiIKC
L947nnmTc6831Xqt0RPLbme3Bj2Pk3UKrGx21DcbaDjojOEIBGYCa30rfshkatvZ
ISzKxn1iLjIiit3yNed6+jbS3mweEuIzHTRaTx2l66sUVLtVhPKKTU1/dOSVtYVW
EOzAuNloSTG4BFEhIipyV4RzkiC3YKAyUEL2E6xfKXifZkAfe4N1jYljyyGKCe97
J47SSML6DHoHfL6CdPdLVsEBXVbkt9EY6gpv1ZWt9TbPWZfEpx8W9RcF1auGRe8K
m1BdSDsrHTQMAOiab8qF/YGHwRxUQIvK7nPOiB7XTP+1Rem0B/BZpBl+iW50snoG
0YeNfNu3Btj6JUp/y+Z5XfPEdKASYZ0RKRKH1XPpMfl+eArKRFMRzVGedY+Qlm9K
X/G2G2VLPtoN//rJNSvsBQF/kfuDHowGVQCrG0QfncNynb3TGViSnfUqsjRVca3L
C46ahVgQqmDkBHjGdS05hnedZAaEM3lezXemjlzN3dw1EVx3doATyoKAby9IuY9N
g34qeRcQf6Am1uI89yEYA71gfgPt7tSeaMBtRPu+DGUQq4z9kIU2aGszKNLs+zAz
DuJ6vP4jLnw22BInATC4cFmlNaaL95gGI836mUO/Kqlce/uCEkelG3y6jgMnW4o4
EWfRpRESsXsape0nZIUzmZCb
=z/xK
-----END PGP SIGNATURE-----

--=-Xed+nY/kxpigcvlehwto--
