Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D2233932
	for <linux-serial@vger.kernel.org>; Sun, 12 Jul 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874764; cv=none; b=TZ2UdL2L5TT+a/+Zqeq/o32D6WIPyXkGbQqfzNMNltGHj0cWF16YhW5Wo80ksIHPlllWGRhRuzNTPqtJaZa/6nc/IGdV6McLNvAO0LRCkVS74Yxg0wl/kznfxuXJ5iXwiOpbC+fhV1vx3AGWNdX9alLPE5L6aocL20TBSPDJMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874764; c=relaxed/simple;
	bh=dLgXJ4se6GTMKbUu6g4REZwLRXiLPxlioqm2Rd88UAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCQutycsTbEw3EigtxK+ye1ZSUgeQrCGwPkJjGrbDLLngFBWQk+m/rX4y5BTmuesrdkP2d3aU00ug3JI5SsJDGC4uWr4wvrWb+yFujBdQ20lk/GH73F3bRvZSwGoDFfVgzC4ua+wqmtFNcSITHGpRAdqyDq++/2Tc4GY0LvzPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=IiZi6jLO; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="IiZi6jLO"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 019D1240101
	for <linux-serial@vger.kernel.org>; Sun, 12 Jul 2026 18:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1783874761;
	bh=T/sNdPX9t3bTHnoacgdtIYM3Zq5R5h3foo+9AAzr280=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=IiZi6jLO5UF78mJMkIB0WvVIVgSPP87sy2rT/19hABtL8aksP4mw4IyY+aI5P9hp+
	 eiFjB3vWQVu/uZCSkh5E7TuqBuTalCjErxRFlFZpakgdGL45LTieNi/Q1bdlWxNdca
	 T/nUYJ5Zqd7vCzlCyWrDe4fic0LH3fGbJ9lG5LaAKru6v1tUG3keT+sZ/oS+RyWcAK
	 UkCxA62ga8KbVQX+JrVgB8lFmgiKjWVMxA8i2kWOqRm3fCySRdXKZrQb8vx8bJW3WW
	 b8XTke2e9ejU0t5H3STpLAPY8aMEx0CRxiJhF9m40Ys/7zzBLbGTff9Z+tG+nzOAak
	 eM/MbxmfLFZPA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gyrzr01c3z6tvx;
	Sun, 12 Jul 2026 18:45:59 +0200 (CEST)
Message-ID: <35ace8acaa3b611444b645eaf96b63bb56821936.camel@posteo.de>
Subject: Re: [PATCH v3 1/2] serial: earlycon: add uart_clk_freq parameter
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Date: Sun, 12 Jul 2026 16:46:00 +0000
In-Reply-To: <2026071251-unifier-vastly-dce4@gregkh>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
	 <20260615-acpi_spcr-v3-1-9a59ebad74ea@posteo.de>
	 <2026071048-imprudent-pumice-9b28@gregkh>
	 <41b6b5d8810dc9ab658541840c1ebf8ad31ca8bc.camel@posteo.de>
	 <2026071251-unifier-vastly-dce4@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-xZqS3ZcNPf5JbhjahcrT"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-xZqS3ZcNPf5JbhjahcrT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-07-12 at 18:40 +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 12, 2026 at 04:36:17PM +0000, Markus Probst wrote:
> > On Fri, 2026-07-10 at 14:36 +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 15, 2026 at 12:40:21AM +0000, Markus Probst wrote:
> > > > Add function `setup_earlycon_with_uartclk`. This allows the
> > > > options string to be reused with `add_preferred_console`, while sti=
ll
> > > > allowing to set the uart clock frequency. This will be used in the
> > > > following commit ("ACPI: SPCR: Support UART clock frequency field")=
.
> > > >=20
> > > > No logical change intended.
> > > >=20
> > > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > > ---
> > > >  drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
> > > >  include/linux/serial_core.h   | 11 +++++++++--
> > > >  2 files changed, 21 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/ear=
lycon.c
> > > > index ab9af37f6cda..5a20fe9e3fb6 100644
> > > > --- a/drivers/tty/serial/earlycon.c
> > > > +++ b/drivers/tty/serial/earlycon.c
> > > > @@ -135,11 +135,14 @@ static int __init parse_options(struct earlyc=
on_device *device, char *options)
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > -static int __init register_earlycon(char *buf, const struct earlyc=
on_id *match)
> > > > +static int __init register_earlycon(char *buf, unsigned int uart_c=
lk_freq,
> > > > +				    const struct earlycon_id *match)
> > > >  {
> > > >  	int err;
> > > >  	struct uart_port *port =3D &early_console_dev.port;
> > > > =20
> > > > +	port->uartclk =3D uart_clk_freq;
> > >=20
> > > This looks like a logical change, the code today does not do that
> > > anywhere, right?
> >=20
> > `register_earlycon` only gets executed once.
> > Thus early_console_dev.port->uartclk is always 0.
> > Since all current callers in this patch series use `setup_earlycon`,
> > the uart_clk_freq parameter is also always 0.
> >=20
> > So in case of behaviour/logic, this line does nothing without the 2.
> > patch.
>=20
> Then it belongs in the second patch, right?
No.

It does nothing, because the newly added function
`setup_earlycon_with_uartclk` isn't used yet (first caller in the
second patch).

Moving this line in the second patch, would make the
`setup_earlycon_with_uartclk` function obsolete.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-xZqS3ZcNPf5JbhjahcrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpTxMcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSoLkP/RYGwU8eFlT1NyQj3i1d
ayC6lF59Db6oN3AsHEbyM3Bdrflp0r2Jxlf0ikhfyllLtAgKE1YQZaQzT6EA3uUW
vaGxCUTntSAD+obwNmvaaXmaygfrXm87IlX6qq51vEQ5DJB8w7wSzCvVYHtvwj0u
w2BS/f66pTdQfInRHADcgbWid063NCJKMU2/YXdxfhg4sUEQ9WO7c3QnDRQIpKrG
tY5ei5xfYBI32mEHiROcDfah3ivgA0wL9uWeQHpymX2GIPcwNtHKUOFxwwSEDOFS
5+D8tC47Un3JPb51r7ZhSgzjquHhcLRcYMWIgpiIEsWfOYgEWert1XVfZroRmM4a
+FgwdIqdxCiZ7T/iTbhYmFL2fvXAkU3rn3OkFtKGRx5n5i07243LLa1PWXDjxZJA
KvIp6LaXevxhb0W2uLYBEvH+ljXdTmc5YIx6EBp33bjdFaIBWCdiU6r6cCSuqrzj
exPcKiP6zdv0jccI1Vau/b35HOPpneXU02FN8HR2IMlhXapoXiTy/Z1OLCVgnwzN
+JokUWSoqVx7FupAAzxCBJS7E2dYXJnKgn6hyCCOVNzkBERokWPD+7qxUvpW8tDW
3/wg4iGHJYRCmoM1Holbr/dM0JzOY9sv4h1Wg9EFjlOPsK7vTcsRAX8e1HxRWxnw
muCtwZIdUbbR4BJD8FY5di0H
=Bw27
-----END PGP SIGNATURE-----

--=-xZqS3ZcNPf5JbhjahcrT--
