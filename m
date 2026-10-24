Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873590;
	b=Yjf36ytg/qQfrcYimJAcFugQcr9UzeKYQB0ATVEIjn4Am08H1ZOGPXB3SifDyD5RcRA7
	 aJezz84tg8o51Ngp76Of5sOGOdeSOaD0bBBekAoAd/hKSHJbKnyVIUUqlJH3UTG/hpR+s
	 A+zkYkYT+dJc0FHdFHmfbGuaBKMCr/YlU5AwMVUIOxGqVSNOIZMTVlgDNVdGfzhFEBqbf
	 JiDq7D9g0+bx2XeP/OTgMACp6x16TT3xr9od53n2kMbE4m+BM7S0+8hc0MI5IbePlOMn7
	 LsshlHkd12WjBgdXaC9nPPhhD/5azkrbWnKmW5DRGu17TWe0Ljpir+sujO43IBDbwOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kp3SosH9xhPx1ipDhe8BfvMI0pIYTqNnnibmRSoP+No=;
	b=XGtlLzT/ul+LO11MeQACMCYMuJYPYDoqrqv5BdoKSxlobpWtVhCd7RzZbe1O+L1skZjU
	 dT4lLBIuvPUBzNY2MzP2KuSPRpHw/6m0JO6TY4VaYMIKbeP1qeIjwrGtI33CJ1XwxQMyb
	 M3YByWZNfNjAlTCE2rut3zpykmemEzr95LIf2lnaFrAOGyy/0EtBUimxn+AdoED4ENWG2
	 zo+mEx8mWXXbPp+94TQ5IxEyMFuC+tSDnQhPGYfmOD+B5JPsWb1WpMb9pB9Yr5LJiDKqg
	 DCNkHyoEOQxGoFFagMscqIlNuHWi7SaYDzDNJlMebciYTLUz4X7YUUrl915M5RV9sqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+iCNgpE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D1606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+iCNgpE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4861F01829;
	Sat, 24 Oct 2026 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792873589;
	bh=kp3SosH9xhPx1ipDhe8BfvMI0pIYTqNnnibmRSoP+No=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+iCNgpEkSX3ix8eDBLGJ2/C/RxjpwvD6W6x0aN3rxFk4Lf7EgltNFqM0ByWUxd9H
	 21TKG3RQ0epxcvnGI3O9k/O3TUi7Sw0CxMT5agrfbHeVhyPXL2AclvhSHc7KIbF+V6
	 8SUKZSaRnQMQQJ4kYjpifDpLNKPFfZt5vRJDmO71IykX+IWZWMmIJcTLHr7MnT5cyG
	 kwiPD01YfHCVrZw3iiwf3i+NwxFhV6TOyVHgRkc+Jgezo0WkG5JvUJgw+cK4N1DeLz
	 h/8GfupUttG2cTJxYiWDVWUXmo4aaiO86FVQGU0w2WksfVhPZZL3KpoK8lBKTgzcRj
	 Hi33p3aW5ph/g==
Message-ID: <sashiko-outbox-183871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 20:26:29 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible for the integration and allow the standard
> fifo-size property to describe the capacity. Require the documented
> 256-byte size for H616, retaining snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-h61=
6-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com?part=3D2

