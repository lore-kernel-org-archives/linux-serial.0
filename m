Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743046;
	b=Ka/Ue9aX0b9CCkuBrhwXzJHKPaIJENyfojJpa+lU1QVd5A3/DDzN+LeaUKe/5iUA4snh
	 LjFSLU+36xuqlaWNlRpZoJs3RR9pN3mKaeGE+rkYEQ672DJz7GYuhYNjvDODCbAq007Bu
	 hUl4Kqt+zhbx3gzhQjZucJ68EzFThHcY6qQzPfXrsgQwN+ntr6E/VvNUQ7Fg/en4SzPuu
	 XniyowZTx6SUDFABi61MynFUQTBfg0l2mB9gyqg108tOwZ4Vad09RNGH6VrPlIT6fxoff
	 mGa2raeg+cuOZ2gYV7bm1eBubFtZg0kGbkP1AniBbLupfX7Akiqf5TqrWTrShSAkTuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hCQw+Oy3ltEh97xwuNupNlvqm7FWNspcdz+iYSidavQ=;
	b=0D+kiOgE5nGpZUdnb5YCB1iNqCMjmgtu20Vc0lwU219XCGO0OhjLEKHkpr1BCs5+pHVa
	 qsQMTziINICKDohSc7VFzg038Ek6FIdaoOzR8KR/SoroTcGJ5swkoWYly+hcNDKzDLkdg
	 k7+VnnsCDHsk/C2ex2AUmaJseiOdeAHrnfjG0ziYB89EIvo3Ujh8tv6wdsqEE3hxRi0z3
	 UW6XWDobjQ4KhMlDjIH7TiPmcH788HKvCiRHnwAWkcymQ/5QSPMAYY4d+jl70fP7tCbZE
	 zzTFJKTDh93kiiAOn7ydRZyCuYTbTs7DNvRICeIqUYzoPD+SlLgLudGJR3EV1tdya8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvgVXpGc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D93606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvgVXpGc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C6B1F000C1;
	Tue,  3 Nov 2026 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743046;
	bh=hCQw+Oy3ltEh97xwuNupNlvqm7FWNspcdz+iYSidavQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvgVXpGcoOZBRpl2QMjVHQxBUalZWuRNK6CFfHQoA3q5E/dYHs/r/KgcD3BiSNemj
	 2qxtVUbjR0S/I9Wkq2j+xLO5oo9erOCoegK7aKuNJ9yPPFr9kxqBga5clcDzvgZc7l
	 DO8WI/H1O6WgIPHiTzNGvHl/e8tLoIvhgpaLY2lNsgkxvIbXmKMQd4mUKzI0Uzw8nl
	 m2l60gzITTEglJnGqpL/Cir3l8/Yv11RY8TiaPenQjH76z7G1+2tFF/x05e4dd1INb
	 RC5rMQsoLWVz0lN2gOwlSD5yZReijB32SZEO7gOKpjaZULOYM8LX9Sv1ZSsSxYsriB
	 NcefeJ4BTbi+A==
Message-ID: <sashiko-outbox-196086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/12] serial: 8250_dw: derive RX trigger thresholds
 from the FIFO depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-5-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-5-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:57:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> DW_apb_uart uses receive thresholds of one byte, one quarter full,
> one half full and two bytes below full. The generic 16550A table describes
> these encodings only for a 16-byte FIFO. For example, the half-full setti=
ng
> on a 64-byte DW FIFO is reported as eight bytes instead of 32, and a sysfs
> request for 32 bytes selects the 62-byte encoding.
>=20
> Build a per-port threshold table from the discovered FIFO depth in dwlib
> and install receive-trigger callbacks for CPR-described FIFOs, including
> LPSS ports. Keep the setup helper available to integrations which obtain
> the depth without probing the optional DW registers. Validate that each
> threshold is positive and representable before constructing the table.
>=20
> Serialize FCR updates with termios and the port lock, acquire a runtime PM
> reference before accessing the device, and propagate resume errors without
> changing the shadow or hardware. Update only the trigger field so changing
> the threshold preserves the FIFO contents.
>=20
> The FCR mapping is documented in the DW_apb_uart databook, section 6,
> FIFO Control Register. The existing default FCR encoding is unchanged.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D5

