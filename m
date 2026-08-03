Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA13C6600;
	Mon,  3 Aug 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783448; cv=none; b=t9W+HQArqgIQuoTBb+iGp9bvJHqgT6vKXdtPZBtJeJVLZ4XDGZvgEnNmBAUuXLKqkQ1JUWTo1t5rr+P14fobD6rdihSsc2emGw+fyBoUwakzbmvcoo7XdTCB1IjLkpLLU5NdR8eMAidmMBejKs8C1nP3z+lLjut2iS5CoHjsFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783448; c=relaxed/simple;
	bh=6xANn9bWLTqvSKIDfXNLGO10lzxBTi/NzpDdpfmWzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vcv7Yo5f31VD2sPOSxClz5zJ1CY+gloXiDlInjslOYGiqVFdsmlZ7cgRdHpZ3/U2xDSqVAHSuVroxVGcs5oU8/RE5E1RR+8+Lc1qlNyc6aeKRknYUr6NUZl6LmEHVfEqhgkyUBz0DrBYLVSicjbfFXOOWoK5rvSx4QO5JRSeNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu1U9kHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu1U9kHY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 90DB21F000E9;
	Mon,  3 Aug 2026 18:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783447;
	bh=hZ9zToYyMXMcN2SzABuxy3TMHdTu3SvlM0LiJ4ATrDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hu1U9kHY8ufmG1FW+0uHWvYPk+BQeWv2QcDNblovOCyJzjuyo1EounC1No/S1MgCw
	 KGlh6CueNvAQr/NPuShpeHhA/XW9zZ769qI/51w46Vwjvcvz1fxe1qKzcenRaEJIAr
	 syC31bvKrny3bVlFOVP3eDJIKYHmbc2yqjPSFHQU5qs7cXTTdLfjlF6XQkxf7n6ry0
	 i+TKsa/AXttDj+CuqIsvnM5GMDPM/jCbwxVGvscN9Sx/zskYk8KA3Fra0C8JQUg17Q
	 pqQKA+eo3w/dLygKYByP1adzE9TrYgNyDahrrkTFS8ypqQx32Cm/JLexNAEIYPUso+
	 olSCSwdnOmkeg==
Date: Mon, 3 Aug 2026 20:57:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, John Ogness <john.ogness@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
Message-ID: <anDhTEbbTgEVeSsr@monoceros>
References: <cover.1785489518.git.ukleinek@kernel.org>
 <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>
 <2026080352-chatter-neurotic-48c3@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i63sme3zsfeqfqhw"
Content-Disposition: inline
In-Reply-To: <2026080352-chatter-neurotic-48c3@gregkh>


--i63sme3zsfeqfqhw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
MIME-Version: 1.0

On Mon, Aug 03, 2026 at 04:46:14PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 31, 2026 at 11:39:05AM +0200, Uwe Kleine-K=F6nig wrote:
> > In this driver .iotype is always UPIO_PORT. So uart_match_port() is
> > equivalent to comparing .iobase. Remove the call to uart_match_port()
> > which then only has a single caller that is handled in the next commit.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > ---
> >  drivers/tty/serial/serial_txx9.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/seri=
al_txx9.c
> > index 5ed20129b44b..2368081c3742 100644
> > --- a/drivers/tty/serial/serial_txx9.c
> > +++ b/drivers/tty/serial/serial_txx9.c
> > @@ -965,7 +965,7 @@ static int serial_txx9_register_port(struct uart_po=
rt *port)
> >  	mutex_lock(&serial_txx9_mutex);
> >  	for (i =3D 0; i < UART_NR; i++) {
> >  		uart =3D &serial_txx9_ports[i];
> > -		if (uart_match_port(uart, port)) {
> > +		if (uart->iobase =3D=3D port->iobase)
> >  			uart_remove_one_port(&serial_txx9_reg, uart);
> >  			break;
> >  		}
>=20
> Does this even build?

Sigh, it passed my build scripts (which is essentially allmodconfig for
arc, sh, alpha, arm64, x86_64, s390, riscv, mips, powerpc, loongarch,
sparc, m68k and parisc), but this driver is only compiled for certain
mips configs and not allmodconfig :-(

Will respin with a better suitable test build.

Best regards
Uwe

--i63sme3zsfeqfqhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpw5JIACgkQj4D7WH0S
/k6IvAgAjae8C55Be9XZiSYRiEkFAhX3+6rrIribu/i94EKIzaCherI5Ey7btJ5C
4lBeqIcaowivanHETZzOYkZIAIU1YmM5wzQRG/0TffdEjWfmFBMsfo7uYJqKzNVd
WYSryaaDrz3/K9t2ggKVdUPZZ/gzv1eP0xOOUUSDBP/HJgkP7vQjvDc1hU3qqRaL
TdLrnd1GtPf7VXmtBwHEX3tbgy+ZfXJpVCoTisLgkb0iTlMY7/TRbzbue5eOczXV
T6nqCbkU4i3gQnTJc4p91F1RpsxfJakr27HdnB1OjmBHf/zY5kW6vmAjrS9iJqBF
JcH/U7OLbJe9x/b+DDm4hADBWhs3oA==
=Lh51
-----END PGP SIGNATURE-----

--i63sme3zsfeqfqhw--
