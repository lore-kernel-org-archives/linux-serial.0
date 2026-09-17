Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872424F5E06
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662451; cv=none; b=WEOB5m1Rs3kHmN7ia2eZPkCD8nUk8wIxSnl8P1jtCPa7ldOGGYVACNg8aYVVGO7nlrcnF/ZvjVWf1YNXppViTYpHcTntTejsBsKRBDYOry+K5IhrqyOLe/J8uoOkfseFy7rjpncRI8L7EWtxfE1NRqumT++HOPA2il4YnxBpM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662451; c=relaxed/simple;
	bh=B8+jEW5xiDBYA6XIpfCO/fXh4wMckuV1U4jyl6X/PGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPQAQ79rFPP/nB/+vWCPQmy/DuB3ZcPsQ/uqPwRrRCZvSnvKv0voQGvAjc1faft9a3tfFCu/WO6nA+z7pxnaC1KdkIrtlmfk47Nfwg1KMuX6eoaY/s25vSWRQTK1sDUGpJ8HKG56SRFbAWkv0sBekJplkW5FS4rlheIPxoiGqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FcvPhYNK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FcvPhYNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=B8+j
	EW5xiDBYA6XIpfCO/fXh4wMckuV1U4jyl6X/PGs=; b=FcvPhYNKTj+YTIKGNptH
	yr2F6wI3oK8NAOREZkwMfFQmR7In4sAAbff1uy9qQntaczGeuNBmSnGYbB0s5flI
	R1v+R3AHHlsbQOBqIDH2tL+ow6J9aK2xS0Kwt74WGO+N+/JKN1H/ti7P5BIdVcoC
	fw7Z4h63j5TwVh+Y28qi455UjgsEzYKFTicPnm8FmHkfZgsn/n4KyziSwr3YWVds
	UasnfIcSU+t8nO0ySgjvDUeSKFh73Oetfsf4JrO6dszvexhBtRyL8kvql8FP9SmY
	k34TWzqhsazCt0WDXf4fwZU3J4TmfYVIAffaW6WOaLo47Gt1He41YWjg7dxMuPdy
	CQ==
Received: (qmail 2109604 invoked from network); 17 Sep 2026 18:27:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 18:27:23 +0200
X-UD-Smtp-Session: l3s3148p1@4As4QrBbto8ujnsL
Date: Thu, 17 Sep 2026 18:27:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: renesas,hscif: Increase number of
 DMA channels to 6
Message-ID: <aqwU5y48I43oTqEY@shikoro>
References: <a08834717c1df2c8974cb0b8300a20cc33c426fa.1789653869.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PYo/38dKqOjmvTAC"
Content-Disposition: inline
In-Reply-To: <a08834717c1df2c8974cb0b8300a20cc33c426fa.1789653869.git.geert@linux-m68k.org>

--PYo/38dKqOjmvTAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 04:06:15PM +0200, Geert Uytterhoeven wrote:
> On R-Car X5H, HSCIF serial interfaces are wired to three DMACs, hence
> referring to up to six DMA channels.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--PYo/38dKqOjmvTAC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqsFOcACgkQFA3kzBSg
KbY6/xAAqro96wkgA3dIhdBJ1L78JlQKZSrvwfBkV4K6UXcDxnSNINx2WZsLIscF
WPbS/5Ap95HA9raFUwNRdMfgBmnatmo+dVzaW6A7NQcAlMmL1kHV7o/UTKebWp4g
ln1wuLgI+JJkKqnF/n8TxTQ1KRkUwnN0SHAXr9tJGqAwJBqyHjlf6kKZywd6XlHB
Tz+5zm5CXRcrItxvzNBCFfedMmeVCVkrcrr+g2qgbvh+qD/gKiPsqaRf05KoEtbj
NvvutEBjpjnmIujNfhgni9r//SvdRYp+FsmxIx0jde63Xz+SPkkb4vikuWeWKjJq
pUJmiWnsExIqvTTPAEi/woAfU0QchFkWc/i16KlE0hwl0K9NQk5k3UVXRaW7DCgY
GnsB7Cj+qbvuvajv4diP7An0og9g2GWwD7d/k+vpV0qs1RGsXuPB2A4e3XDp3Gvr
om8kEakzk9EEJiSWI1LKf+MLZRtx+Jjf2TpT7xME8kEqShMNfzp5Ltn3SZzLTHry
/SL6Wuit55EYr1IruZgiqMcFXCWz/zdycl7YmIuaRleH6UN+E8SSbqTFi9ESn7+f
7pzTGVanKpM/jKIQd4Dj5z1Cm/f46+krKIdZR0SoST7en4ZPEZxwJsCzqCZSmxiq
np4necfE4KoWx+ArO3HooS5QUmFfy/Wjmu9HaEaUdzUFHy9sn98=
=M23u
-----END PGP SIGNATURE-----

--PYo/38dKqOjmvTAC--
