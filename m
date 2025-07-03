Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CA2F7D13;
	Thu,  3 Jul 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566888; cv=none; b=Mw92v69h3AGKr0sKb+kJK+BLC+9UJwvxsGbMAaBwmLZKdiVG0uEGkCfJEW9JGSc8ak3Yb8uI4Mo18zncIFlpkKj1Ze4IzWCnztWJehizWbpsDx9xkIjt5Y4OlgS2KgLiOqtbBMHXWeGzcTNULd/E1rX9PG+PRylEdsubZakwTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566888; c=relaxed/simple;
	bh=rnpOblscpX3ntu1FAMA+CUBVC54CGIJIaF4zdKL043w=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qf/oy7bhCDznS09tokBNcHaZ2HmSjqL3wXdkNy/JNywpnJJknwQjaOivG1GKUlJNw5vRAgIBhOL0RM3z/xc77EUJY30SMPuxBR+b5fx/uV8mvv68HT2EixpIT/KQMWxbgPCfL9NX09WfXnViuUV9J5dy0EMMR13SplwIrqGDNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=MIZuZO9f; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="MIZuZO9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566885;
	bh=rnpOblscpX3ntu1FAMA+CUBVC54CGIJIaF4zdKL043w=;
	h=Date:From:Cc:Subject:From;
	b=MIZuZO9fP13lhLu1cotNtf3djPwxhvsTwOJ016MtMit/TL7djdy9s8lBJakByYKlg
	 PVRsHTxOfoD19/qjnEf/nQ5bZzrhe7g+p9yDBUyM/EIh8XbzZ5Ntz4LzaLtMUaL81V
	 CnsI9fzXByUHtnuwid48PWlTjoME2uPdl+u8zqcBH/Ur68b2XItg9/S6qpGLnJy55Y
	 JFJppwmKfIODOnklxAs7jXAENd4uudLSbwhz19yy7YpT9B96mi7DV5g22f7SGcPi2n
	 eyke2g3240jOch3wF/yToAn9CP9LtbNoNz/taKdRI5ZtbKbl1AgMwNhLFuSuTUAW6L
	 vxqNXxRpN8Ndw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 94F2A438;
	Thu,  3 Jul 2025 20:21:25 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:25 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: jsm: fix misreading of "once in a while"
Message-ID: <7qcs4vwj3pbv6e6neh73e3an432jgdhbyrtcbrsv3ntuoboh6d@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2pbmhwlutmiktlc"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--s2pbmhwlutmiktlc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 drivers/tty/serial/jsm/jsm_neo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_=
neo.c
index e8e13bf056e2..2eb9ff26d6e8 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -1189,7 +1189,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 			/*
 			 * The UART triggered us with a bogus interrupt type.
 			 * It appears the Exar chip, when REALLY bogged down, will throw
-			 * these once and awhile.
+			 * these periodically.
 			 * Its harmless, just ignore it and move on.
 			 */
 			jsm_dbg(INTR, &brd->pci_dev,
--=20
2.39.5

--s2pbmhwlutmiktlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyiUACgkQvP0LAY0m
WPGEQA/8C8+azEv4xrPjaTRBwHJKYe61/JE/J+9jlPLcOrJ5M8ZjzAYRlKybhlLU
FQLk4pkrTcF+3DNGy8KyWDVVIrK4X1OXUZiHOFw5iQ/zsELPjCIpHUxDpWHpO1Ln
t9c0hIwgdvXbWDRaZ9H25DxSA6kr2kYDAo9RBoTYDD7eFDw2vmXomZ7tK76j4eG8
dcb7/V65ota3z9yWaoDB/9Bv3xDnNMhDObAw8wfx/H7Hkpr/U/TnFZT7cOMoNQRh
poKrY2iHOTnfzRh2Idi8J4jzOT5dDlpxQBm2AYMrRj1q5g60R8CpRv8gmNL2i1Hc
gUGYZzqQFpypR82oOxpDLN7ZNeEg6dLO+YwhLsnF61SoF1mTU6kyv0OVXmvWwLH+
iHaL8Y0295nxif9Bhrd24qGMJf1uPakasRlXjwFTrFXRGsyJg8ET0O0WqGatp81x
3PtZynPr6cDNJG4YkU8D+ZdU1WBGwO9+EvOQJ5j+cKd0x3hGj3DH5vfwVtjR8Cs6
bEeBgGDaYeZyeKGVCPZWRZv4thH43Hs7VcTeKGjXtlNILZD7vQHeL+xCFliSfLzV
jby/rUTE48ruxA3kXxnODZd+W6XFRGLMKAIukQZUpeStDfjg5MqULZxvfStW3KFa
PXBussELnuP/0dR+AMmVExF+sijrXI9pUksuxT456DK7lYnzZZc=
=lB7G
-----END PGP SIGNATURE-----

--s2pbmhwlutmiktlc--
