Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600004;
	b=KgfXnLl438lUcK2Uir9P6W48rKX/I9YtxTsBjbWD4ZbsXXLvH+VDLYZX3fl4b6CxvDye
	 GiyfsVRdoISKOqjLetKOisybSNuojJUbPr+bunZGqVEirZwUrrga5pDRCwJSnALSnu18X
	 2XVWWIcbrgh8R+bgiKP2jBtKPFqV9z+5Qv6g+5x/55oHMHOAzT4CSeOyW0jmWLJURJlpD
	 c/SlKQ8etVU7jaKjJHF7JSX01wSO1eW5u8T/6kP6+zDV3TdoMabdpjnS9fHy1+OFrmdfP
	 FhTvxjziXM6cxGu0GvzEiIj0Ra+GO6FSwtJMqObDuoteP/nnedHy9M9YJkJCW2N+H6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f9gS5ybTWhy9GwguS9e0gXaJ0SyfQd99zVnPS7xGK6g=;
	b=lHbmCQaDmMdq4m8jLVNOK7sDwztRQb03sxOdpXb9Vz7Y28KsjK+0MuYRxaDhBgfUrImt
	 ZmwxoFMm1alCgajJBSd72Xrr7bf4pgG8y6I28Wp9EiJM+gF1Xcg9+74uY1dWRfzzn0f4j
	 MwbfBM1A+xXs+bTMchWyoXS8ga92njzT4z4+zOlE/Xc/jzlg1xNeBpEjB8BJ/ro5AWl2w
	 wUh9Q/C3NuP754JuWN4oaryDutoqTtyogyL1UfMBpkFwu3EtXULCGx2oQMdTmmTm/AxMl
	 DVvdyZUCibDgMlJ2G8uVKmOpZACnoUE+5myfVbGn1QzQWpjeXtitwmaW2srV0oHKgOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+sYRBTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039BB606AEB7
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+sYRBTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC591F000C7;
	Fri, 13 Nov 2026 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600003;
	bh=f9gS5ybTWhy9GwguS9e0gXaJ0SyfQd99zVnPS7xGK6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+sYRBTYrNajAW6ZV/bvHVfVGZrW1vHi+BSCrVqolFVoKKVD9jY3uRyUDKUoCvtxi
	 iBJZWLu6k3z6/CX2gDWzLU7yKry+ltA1sW6cfToWDdhmR/tZ05iMnx9gxOL3Hw0/1d
	 b/CFOk7huNgymwfh0EggciFWEMnp8Sjx/kR3sEFvFMSKcNiY6WW7zD0Sr9NRa26gkM
	 I/C8zRfzogv1GI9n6fYdC6Y4s7AkjdMkubLQRjjOCopFFiu6i88x2cWLLbrpaTYz69
	 znEz7GrDKdjjYhyoJnbvw/dzlXVhXfOQRHhbY9pX14SKLrJc4b2kOfLzs9Y95hkXe8
	 fp0xLs/DcUb5g==
Message-ID: <sashiko-outbox-213595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] serial: rsci: Simplify rsci_transmit_chars()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-g2ul_sci-v4-7-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-7-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:00:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Now that sci_er_interrupt() no longer calls sci_tx_interrupt() on RSCI
> ports, rsci_transmit_chars() is only invoked when CSR.TDRE and CCR0.TE
> are set.
>=20
> Drop the redundant CCR0.TIE manipulation in the !CSR_TDRE guard and
> call rsci_stop_tx() instead of open-coding the CCR0.TIE/CCR0.TEIE
> update when transmission stops.
>=20
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D7

