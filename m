Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669E23C506
	for <linux-serial@vger.kernel.org>; Sat, 27 Sep 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759011371; cv=none; b=o770np0G2YdHtNT7r25MSY9WRX46n+oQ7fobQ056GDsPYaAZVB6qBlx1VxRTzpe8ugqgEmq9nKdesjYdCot4GjfdqUE5xIj8UnBrSxkKoLXq/DAd+SiakUB0TTPbmC8hKXJHopSSVKAgwYrYN0bwFZnBanRnpZ4e94Qz3TsAMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759011371; c=relaxed/simple;
	bh=8vZRA8xRfEWHtkYllia01JpTEqLlFc+lx75FdnO+oo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvTFQrTUIdsZ0jdKHMqeV25YFG+aDBIAMrs5Iv1K74jLdJKLk3CmgmEPLSUS9FX0J5YcKRjUbTKOth+aWXoFxok9Ukka8/N0ymUNk3jBturglCvwe91Cc/XjevzhuD1WDY70UWN0r0D3F2sygdayuYk+1Gk94VCr29w8GW9MuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZxDdRP0Q; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZxDdRP0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8vZR
	A8xRfEWHtkYllia01JpTEqLlFc+lx75FdnO+oo8=; b=ZxDdRP0Q11za1yd8Vw0S
	39MC2odiNNSqyQy9M8o++tRzYkll+aTX+jZIG4I9rB+A95mEkRtGIWi/gIeGI5e7
	7raiklWdW1rMR4zH2k/IJfcp01W/uAxmqGO91NMXOkZx5UtIklw8bj+BqUAzlR02
	ZycgbVLUAowkFdQMtNj9XjN4O41gXaeWOSlkZaDUrJg/1vBG1zoISTG1zCuwbbXp
	9AhiMmzjieRoC2wqOEf+DtxvbdE7plcD/YyCHWBhd1osnLbUsfDjgeU5RLIrwagP
	aGxTaMbnE3+SeoFuXcQslZh4UqQVOmYhvO/wsZUwQ/Vt65KOoS/UMnlN49xC57Ca
	sw==
Received: (qmail 2700299 invoked from network); 28 Sep 2025 00:16:02 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2025 00:16:02 +0200
X-UD-Smtp-Session: l3s3148p1@YU5jv88/kN0ujnsw
Date: Sun, 28 Sep 2025 00:16:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: delete email for Tharun Kumar P
Message-ID: <aNhiIcMl7VBk98NK@shikoro>
References: <20250925204020.4544-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpi23hzH5U9f6IiJ"
Content-Disposition: inline
In-Reply-To: <20250925204020.4544-2-wsa+renesas@sang-engineering.com>


--fpi23hzH5U9f6IiJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:39:44PM +0200, Wolfram Sang wrote:
> The email address bounced. I couldn't find a newer one in recent git hist=
ory,
> so delete this email entry.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--fpi23hzH5U9f6IiJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjYYiEACgkQFA3kzBSg
KbaZDQ/9G3icVYvY8mxCYm9hx4UxRs563Dd8VyMI5SHYF97mVqj95vtlwoOj1Uz4
d/UZ7/8/rXtd16vT/soIrUhPGTx7bMe6jbfWpJx+C91Qnn+ZOkVl4Z8DsXQuRXyk
Co1NuR+MYkrz9cpWS4muZ6WSH+gAUcSKlnGicMFW/T/EE9UwDy//+Z43LyGNBkAY
CtgdVUKhCQEAxuFJtihcq1Ct7S57elEQBiqPLLy1dEsRXR9ADv9XbiahZe4BgLob
CiojrpKQislOeWTnC8kb5oyjSUJhu7gCEg0BSvrafkqDMm0VrTj3b4UY/J8HXe6Q
fBO7wiLCini9kEVzgkhObDiuwAnogwaZ1+iziMnr3XMAL9L5kmFzJ25CH/+g/8fp
fHxsPu82jbQhHki1cNF2w5QI28oIbYZeKpp2zL5JYCyxsZbgcDtKWpJZT4ONb0kf
RdsV9f/zIx/wb2GrJuilrh8/a7ogZwFCxLdsvu9QdcGyUQ8lHc/eFNAip2g29ps4
+yg+VJDFLJUXE2AKj30O9m+sxDSfjeoDmBYkWjThPaupEN1eFp1oLPWYKc2syTgX
TtxqDePB8Ufxhs+y/vKiXPxW4NvtpG9p1NyEmeIMI28NcGMIUIOKe5/tjyipVbEx
u0XBGQlDHV9HWprecBCzBpNfqPBysAU0SX47CD9wQZphICfs0Mc=
=Qvgk
-----END PGP SIGNATURE-----

--fpi23hzH5U9f6IiJ--
