Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620806;
	b=bd8Ur952g3mcMCW83NemeCXHTmegalckSmSIk+H8yyftDA0EkVrja7lwCUI443qoO1Po
	 2tuZanxy26janXsRfFty5npYP7WpjrLJJdSyoxHF1YeYye/mtXaQ1qqc3xGkMYyTAfBIs
	 +uHPTRdu3L4kUGH3vrsaZE+wCWM3jYAw9hrIB2NJzJd/j7QglMUXtHGDbLsAVHoEIGJBf
	 FRdltchZQoeqXbfZzWEQW3/Q2Mp+5hrv3mz5wyKMIjoyzXCm5lLTSw+mmSgkVftFVW20k
	 ap3AiFtosTnhoOPHX3G+2sVF04YeWHreh/uytqI2zpJSZyMOIVGDo5JOcfmI+bhcwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bc5l2P5dkniSYVt2rYnpORKu/pyRYnygtX7XBF/WI44=;
	b=nnGGZ5j21P6ZalEAZFoGhW7VTf//xO5TOU9Ok/ytc1Wb0qHxY5Jx1AXkDeIK9mwEgocM
	 Ohvv4cjFXTMj6h8uW5TilLE7p8zZoNSWCQ2yO62M/l9TRbHF2TjcD6RwjDu4gS7tmgvqt
	 Dsl9JMADj9TN6JF3L+9NX9Jck6LqN6VY+NgxZYZzZHdhmTvdz+0Ss6fvtUYAeTfzaDjmc
	 ICh2ePgXcaLqq8ttZT4HJL5HdGLTUsyFPA/rYwh3vfgJkUwojnyD7TrSrHbzAbEpvlnre
	 +iWZxS0SDVqORjBu9Cc1JsiRrQuDeIh8y5/LfIiGQzexBDIV4EMNrrqYutB1KCdo8JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAv8pMwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C8606A328
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAv8pMwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3F91F000CA;
	Wed, 21 Oct 2026 22:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792620806;
	bh=bc5l2P5dkniSYVt2rYnpORKu/pyRYnygtX7XBF/WI44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jAv8pMwJ9E61tnlegq0NNhM2YfLemJRewRlrxOGstl3Fgsh3boGkGKx20sHrsqWPT
	 Lks26KuNfnyRm/HJfktILwALkeCz/n3Vy1En3tZHX3caSBBjr65cg+ero+cYjS1+ip
	 V/2/qNtT8Y4xNDjM+5/b+VHmVcAHbW+vMAAcOK6RA/a3E5uHTlF2DF4yjs1yY5FZxe
	 SegO5lp16wviCIRCnyTGML61RyPXaPBsyTLycWhhM49emzI96XN8Dhbq5aZVJ7ZY2u
	 oCAUHzsC6ZAXxvoJ+KaA8GnXpGPaF9dHxnkEJZaGJrCr5wlJw5asnWGcAhhXVchhDq
	 fa/x8kcTBrd8A==
Message-ID: <sashiko-outbox-180719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: account for partial receive DMA delivery
 to TTY
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com>
References: <20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:13:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> tty_insert_flip_string() can accept fewer bytes than requested when the
> flip buffer cannot grow. The DMA receive path advances past the entire
> range regardless, but does not record that some bytes were dropped.
>=20
> Increment buf_overrun on a short insertion, as the PIO receive path
> does for a failed character insertion. Keep rx accounting for bytes
> received from hardware and do not retry data after the DMA buffer has
> been released.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-submit-ser=
ial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com?part=3D1

