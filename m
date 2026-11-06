Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986828;
	b=fUP808vDkmqyH2y0Td2hbpNDg45sWLVhpZ98TgkkPWx9qcGptcGCgaE9JgRRdX67w24A
	 k2Bra05i3/ZG/q+uJHWcHCBP7BFpmMunyczxxOS/PoKgXZ8AV+NYoxLTzhgIJVPZeLVhc
	 yrdbDokZUaGzdDUH0nnn6RNv/3ed3YKiLRhBVU9x6VwNIfYCbM2uEnY+BHhMtwH0CiRke
	 sd3bBRIvthGfBSm+3sLTXrT0AXBaXkhlAtPiA5MlSD4gwq77k8VELli0FN5AXhXSvDeNq
	 8sdsX1H+K2eFulzJaE6OrPqmPyzXd9TzqckuxvTzNdEKQJwuDuCGAwCY2JibPexIVxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6iCz8uPmaivGK2IfBvxWCreSuE+UWU0XRqrSzi+k0Sw=;
	b=G83pxNq+6Rn/VbVbj8s9AMfrXD7n1AW1rr3FpsPeXKMl+EaU6ffv3R6/QrFC3QXBWzfh
	 s8hb6pgkXzc21XSNtZb+m4laLwYwF7UwD+WBUTECWDKsRSn/NOnIzeHzSBLQ6BEYTnQ6f
	 Uh8frfSBi3+IT6P2PvGxY+blBJu9JG5QQ/gSXerK7+d9aOFLPgcy1D9p9thFNvGkpRc0p
	 4y98UJTlm9KeC05blEmW8HNwrW3ThmcSjvlTwylFg7lKaNGlGIlWOz0TkryMVRiTAlLDl
	 2+js+o/X65ERXStSW4VDzNu7d4dcQEZV6+6JXjLXgkvPmC73dn9ttGHK0SrtZzg80qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amHYenwN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B9606A329;
	Fri,  6 Nov 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amHYenwN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653E01F0089F;
	Fri,  6 Nov 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986827;
	bh=6iCz8uPmaivGK2IfBvxWCreSuE+UWU0XRqrSzi+k0Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=amHYenwN3Ln2et+kOQfWN1SJNABijL2Js0a5jRmO6CZZBpwmogMZbQNXk8UaJQ77K
	 pRlHlptn6we3Cz9/4fvgNiCKJ3y/q7iymXFHpHNOtyCtA5kHEOHAn6kW8AC9XBgV1W
	 PyBCeazkuXC1nAuvutr8op5aGvmkccpMFFKqS0SUPf3J2PMihYQyMBjodqu0Ty/yRv
	 0WuC79D9XDKmg3CU37LdP0Vd1XXOdLgmxbxES4O5jwOcq3cSUHeB7CKlDVbexNGK7N
	 p98A0G5HuXe65ZXZhV4RiYRkWj5e12u6TlAIRt7z7rVtB+OE+YvI2jK81Hf4Nd6d3u
	 pqGWO4EQ0/P7g==
Date: Fri, 6 Nov 2026 17:40:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: serial: mediatek,uart: Add compatible
 for MT6895
Message-ID: <20261106-gulf-extended-fe3771d9d70e@spud>
References: <20261105210622.523747-1-asalde.le1@gmail.com>
 <20261105210622.523747-3-asalde.le1@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JYHp8Y84ezkOabFk"
Content-Disposition: inline
In-Reply-To: <20261105210622.523747-3-asalde.le1@gmail.com>

--JYHp8Y84ezkOabFk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--JYHp8Y84ezkOabFk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4RBwAKCRB4tDGHoIJi
0qIZAP9BbUTJCJBFwXZbdcK7EV7D1qfEEy9W5eTCWsx9+SR3ZAD/ZSPl3XM2WvFy
tQJtKWnZ4EK9GySbgthNiOBevVPZbgA=
=Nrh4
-----END PGP SIGNATURE-----

--JYHp8Y84ezkOabFk--
