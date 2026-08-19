Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0A48A8BB
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157858; cv=none; b=Dy104/K9Scp2DgYMhp2e4+AJMFRLs2EJO5t5l+XOjXzYYtDJ1hkFfZCHxk/VnWGAH0Fpa7TCciCVym6JYnzo6XBcieZq160PuqHZAhqfIW63w8cPniQGz/Z5Gzsw5lYDwcLbyzEwxd1ql+x2CNgUjZxQP6b0N3qlE8cMzsWUuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157858; c=relaxed/simple;
	bh=+8ygwU+oRd9RrEP2oGSLFg0kkBGM1O/CnNSr1lz0D9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lb6DoHDcqzYzpKegfx9X4TEhtiy3irA9gMJV8tvoXcD5ppfJbIB2dyNnvOVsVfPFD8ZOP1umiKzwC8EI+coO1fUNDEeWJkeokBQ//ptZB+8JFT/iW0VrN/CuVRRzRpoafnTTs7/hZECSvN+RZtfNRCro37tS+LponIIUZaAlWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=MSfkKytm; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="MSfkKytm"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8A4CF240028
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 18:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1787157852;
	bh=UJwdSsh+Jl6iVnQxa4U2bYTKs6Ykn6infgkpGZC1ZRk=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=MSfkKytmDHmCZ881/zGeVOYV4WdOmNh4+EBsGa0q9+gtzYu+G4J2luY9nJdajm0p5
	 J238PrQebE9gt+qw3jnJrcOs04mvcp8K1tmxIIL/SO9vtR/9VfRSaWIO30Q3bnER7N
	 uIR7YB+SoZLNzcH6MZFJ5UmfhYRAogscWuKa7/MawDjM6KdZ8x/3yb606ZA6jpojo3
	 hLjDDBTsL9QCzFz2VxJ7vNcC7JHeJHnTCyijGDdsYUnt975lMwy2wiQpbSKisxUfIC
	 3E1ar1CfqE6i+QaIlQ/SB2BHTyy2NqPFlCW+CrWBP+T/V1uX4BsgNNhQSio9fXHRwA
	 6enrgxHcsA1wg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hQC8C37LSz6trs;
	Wed, 19 Aug 2026 18:44:11 +0200 (CEST)
Message-ID: <e9e7a52f8d11ec8f57a72424bfaa40eaf738f1e9.camel@posteo.de>
Subject: Re: [PATCH] serdev: ttyport: Clear serport->tty after freeing
From: Markus Probst <markus.probst@posteo.de>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>, Rob Herring	
 <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby	 <jirislaby@kernel.org>
Cc: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>, 
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org
Date: Wed, 19 Aug 2026 16:44:12 +0000
In-Reply-To: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
References: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-q5Qe+PMmpLkX876UKUI3"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-q5Qe+PMmpLkX876UKUI3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-19 at 14:57 +0200, Hans de Goede wrote:
> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
>=20
> Both error paths in ttyport_open(), and ttyport_close(), release the tty
> with tty_release_struct() and leave serport->tty pointing at freed memory=
.
>=20
> The serdev core itself never dereferences it afterwards. However, a buggy
> driver could easily trigger a use-after-free by calling a ttyport operati=
on
> on a port that is not open, or by calling close() twice. While those
> drivers should be fixed, clearing the pointer, makes them fail
> deterministically instead of touching freed memory.
>=20
> Note that a driver which currently double closes gets away with it only b=
y
> chance, depending on whether the freed tty has been reused. After this
> change such a driver oopses immediately instead, which is the intended
> outcome, but it may surface latent bugs elsewhere.
>=20
> Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

I recently took the role as maintainer for serdev [1].

Please add me to CC if sending another revision.
I only look loosly at the linux-serial mailing list, so I might
otherwise miss a patch.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
/commit/MAINTAINERS?h=3Ddriver-core-next&id=3D6b71fef6f05cee64ebbaa8aec6dc6=
88169f47e9c

> ---
>  drivers/tty/serdev/serdev-ttyport.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index bab1b143b8a6..b6638f9f40d2 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -137,6 +137,7 @@ static int ttyport_open(struct serdev_controller *ctr=
l)
>  err_unlock:
>  	tty_unlock(tty);
>  	tty_release_struct(tty, serport->tty_idx);
> +	serport->tty =3D NULL;
> =20
>  	return ret;
>  }
> @@ -154,6 +155,7 @@ static void ttyport_close(struct serdev_controller *c=
trl)
>  	tty_unlock(tty);
> =20
>  	tty_release_struct(tty, serport->tty_idx);
> +	serport->tty =3D NULL;
>  }
> =20
>  static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl,=
 unsigned int speed)

Always good to see hardening.

Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst


--=-q5Qe+PMmpLkX876UKUI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqF3VobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSjZsQAIhpqpKP4U0au63s9Nh4
cJtzroMgUu2K+7OTTiLydZoKLJBditjTbtRNKr1J7iYG8xTyM/j7W1ZTlkFpXYpY
+h4irDbEyj2Kcd8CtQNtBMoA2/jVBOW7+hG5CR/vxps+WIBallOIJETdgxG9g5Y/
LdGk/RBhbKeVic51BVWL0avl1mOhNhHJasLp/w22Oxjvy1nokLIobVLIuMU5ahyC
c21OvutXYPmYK/tVO69X7q/9Knkwy600eD1pRecIsDcySYDAP8m2VO5+3lRvpTNo
3vdfTe2BhUhqhMW1krIQcXX3NWQbycdARNdlOBaZokXCnHWSWnVaszKSAqWyUqvb
GdrtIneOVAU44Xas8bybJcLJJCokko0WpVBctBuv8ZyzwZvXWO8JL/d0wY3tDyex
V5P+r1QnvVWR/auw8Px16HcnYZaLfhA/26heL3BWacy3j58eXMVwBHTMgRT1T/mE
/5Nd+9SPVUFkPlI9j68eMli5e3KHysGIEeTA39kVdSEbIqZyid2HCmdmNAJENEhA
uqMqdRX0nuVCUs01Vkou2AE7fLw1/EJOmXqjjAp9MCtlJI8/fm59VNagt/6ZcIBr
BBEfHzc+FOUcSJ1Fqrzy6yXevKePuLTqPJx3E8be/foylLn54emVfRfaoC32xrT9
WEyJRPF0jwKUJcfkOt9JhnSM
=ypTE
-----END PGP SIGNATURE-----

--=-q5Qe+PMmpLkX876UKUI3--
