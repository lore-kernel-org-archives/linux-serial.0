Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124D364959
	for <linux-serial@vger.kernel.org>; Sun, 12 Jul 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874187; cv=none; b=q32Vj6qaa/bcgqh7ERA9xU2PYYPBSm7B2TyRci/riI1HFyeX7lE9yiOSAlwNnxv+yIb+MGTeOCBW/EBCkuKSndj9teJjI6Gyw6+us8xFXxikQcAb5XK6B5/1BgSZ7hqC0uyzYv17uFKq3NU17YT+4QfR5U6RcXFCL/pFoSP6HjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874187; c=relaxed/simple;
	bh=bmHBG4VeOnxcyayh9+L6f4s5Ff5k5Ve3C3HJAL30BqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuvfSRL+sSZTmipAhgEF+TvGoIlBmP60BKafy0IokUq6gZg6KmQtOGXtbcj5DHKm63FD+3epremv+tcT2Jsapw7tEEZKFk2fpxm9mxJLUwOcXDPEvzV8fHqX/gfcJ+7uap6kgsnOYAV2ySlvcWVmitPFX6hEGvVeJLWD5nBZWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=lwCI5qH7; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="lwCI5qH7"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 351E3240029
	for <linux-serial@vger.kernel.org>; Sun, 12 Jul 2026 18:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1783874178;
	bh=bgrIxAj+hS6hQSatWpeQJy5RuvJAxoO2cwk1NUrq8eo=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=lwCI5qH7QPIDoZBZnVPmeRQ1ZdMYPKkiPC5suKbOVqPl6hAM5za2TMLy/x8LQxSC1
	 rzcT1+hY2pzJ+1i8FJN4eUdAn69r2nRRb6BAixIKNBxSwH/66uGjb97UKJ/+AWQHa+
	 nFTV9BLP70Sj9SQHHDb8pYPwE/6SiuPWt2N9m/zzFTu2HFegZUQj9sllLbPWCHlk64
	 26VkQoAZlm5ZmQ3vPpkGBGL+58ighufjR/99mXhhPCD4SYnwT9LJJH2J1p8CJU4t9C
	 thCZQwC1FGoS8b5LjnbQdXxCwCYlfLvJVwv0cx30C2tXId1LKwAkEo2bMNtJFt7fG4
	 E/ZDtREzpPI1g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gyrmc722Dz6twJ;
	Sun, 12 Jul 2026 18:36:16 +0200 (CEST)
Message-ID: <41b6b5d8810dc9ab658541840c1ebf8ad31ca8bc.camel@posteo.de>
Subject: Re: [PATCH v3 1/2] serial: earlycon: add uart_clk_freq parameter
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Date: Sun, 12 Jul 2026 16:36:17 +0000
In-Reply-To: <2026071048-imprudent-pumice-9b28@gregkh>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
	 <20260615-acpi_spcr-v3-1-9a59ebad74ea@posteo.de>
	 <2026071048-imprudent-pumice-9b28@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-u29FkTICRf5v7xHmDBfh"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-u29FkTICRf5v7xHmDBfh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-10 at 14:36 +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 15, 2026 at 12:40:21AM +0000, Markus Probst wrote:
> > Add function `setup_earlycon_with_uartclk`. This allows the
> > options string to be reused with `add_preferred_console`, while still
> > allowing to set the uart clock frequency. This will be used in the
> > following commit ("ACPI: SPCR: Support UART clock frequency field").
> >=20
> > No logical change intended.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
> >  include/linux/serial_core.h   | 11 +++++++++--
> >  2 files changed, 21 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlyco=
n.c
> > index ab9af37f6cda..5a20fe9e3fb6 100644
> > --- a/drivers/tty/serial/earlycon.c
> > +++ b/drivers/tty/serial/earlycon.c
> > @@ -135,11 +135,14 @@ static int __init parse_options(struct earlycon_d=
evice *device, char *options)
> >  	return 0;
> >  }
> > =20
> > -static int __init register_earlycon(char *buf, const struct earlycon_i=
d *match)
> > +static int __init register_earlycon(char *buf, unsigned int uart_clk_f=
req,
> > +				    const struct earlycon_id *match)
> >  {
> >  	int err;
> >  	struct uart_port *port =3D &early_console_dev.port;
> > =20
> > +	port->uartclk =3D uart_clk_freq;
>=20
> This looks like a logical change, the code today does not do that
> anywhere, right?

`register_earlycon` only gets executed once.
Thus early_console_dev.port->uartclk is always 0.
Since all current callers in this patch series use `setup_earlycon`,
the uart_clk_freq parameter is also always 0.

So in case of behaviour/logic, this line does nothing without the 2.
patch.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-u29FkTICRf5v7xHmDBfh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpTwnsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPScvMQAK6La++c5TgUg6Dh0ACe
aBqWeNBLPfLFiSbCdtmkXSKJw8uGpOyXc+rgpHXMFXQIcNtgfXjHh1Z9axDlv9/N
9Gx7wI0GPBUImZmZuSrzPdPZw43YxAchTXIMnYCDpW55RnXMSgMhe19hHI7xSALO
MdXpM8NrmQF7byHHWnMdfP8hVtVPdonjBTNsrUyGaqhHdxyuoRtp9JBSohm4yg7y
fGwwVQbu5w6ZM94ActeeV6nQVA2iYp4FKU5bk2LJYag1prCVBEXrLiDtq2opSAve
vC0pFPLY1rX6SEYuPzps9rk90T8YfQZocpZKKyLRxnyBAshytwd+WSyuEY4tYayk
/yck1LPahPu2vA5ZZCnqP5lcJ/i6hmoZ2NgRcmHtrVyOAQu48wRfa0pleB0YyFpV
fL+lUcon74AbML51tPX4LQstXlEZ3+zAY7AzlH9lNAQ3oTel17sexOXvx4qjs+2Q
bUw2E5gBiJe6FS1YGkkOC4zKBxQjNhwQayaAUtnU/ArFuNoOF1WtzBoVn+2XLOjH
kTrpPcH4Rh0uFuYqBS7RWnvJdBLjRSUIYsHW6G8R5s257Gj+RMa5kokvgs1ukziV
dZEQzvOsbQdoO5rClAlB5XAYNjNjSmcneLrLSbPBOBrHDP6Jr+ZErzhnDBcm5qAN
t9eoszg5WU5thpiETjjQg6cz
=cg6h
-----END PGP SIGNATURE-----

--=-u29FkTICRf5v7xHmDBfh--
