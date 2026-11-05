Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913552;
	b=KwmAQAYwR3A2fvARMdrwiO62TkoJ13jkIYmBElRitEtmj7+ZTYjl26pvDvkWsFS0rkPi
	 PHQvX9u24lyC5cRuKcMm/uU+vDmfRi0b7x7DZNM8MJ+wyjnF5v2j1a2aKSJ3M7/OQwMO0
	 /dR63cLVTtq5DyJ/RFFpb11p1GpInT+mxGVERR2W0D9uWLfxi2GrRsiZUwZW4blGCp4f7
	 kUHOWszHvTwWQxF7qv5OiLYpN7MnuhKVxQkh4ZdU5JmIpMyla3u/S7dJGR2QCZoMNeskX
	 QDORuW/Klolacbgup4CZPoxGAjY6j8gCOKpTIOQ46+rosNro6NY1FXPDM7A7h29wLZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zj/uF/57kyYI1OIivex3W9Rx8gOrgw4ZoUg5xuhpknI=;
	b=lg6zmSJjKVQB8zLUhLnbKahjjB6z2xNDHTSTx2lA1qLHXgevR++22IzTUKAZlGC2Qt6c
	 Bdt2gd6dPnr8ciEGImMape2VdVlZEPowDmbK4qLVFkHFeVrFs8NCSByoC6sFhPbHTauG8
	 ZSywfouZrjTwx4rvxqCN8tjHtQUoUfSh4aU7VYlg76/fbzQJG/fkKqMeyCVrEmgYxb+lX
	 BOGEYox6K48jLxqYhis34bwIgpHX/TXjaA1r296QfzJR+ax0EWifRlnDVCg0Jw8PPNjUr
	 mM2EfQnlGi3hHHHaHk3cf33nMeLCB2+XhsgWFNKcw6o1jVzHhXwbMRPaEY3Xc+pSLAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTrTtymo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEF606A32F
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTrTtymo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31781F008A7;
	Thu,  5 Nov 2026 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913551;
	bh=Zj/uF/57kyYI1OIivex3W9Rx8gOrgw4ZoUg5xuhpknI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTrTtymoRon6q2evizRWuaF5Ljxn8Qb2dlqIdild1ByBv3vMxFOmINNEQolIyvpMH
	 bs4SssZm2IkrVCCzE4s7bit3CNHiI1Sd1DQmqhC9LFI6KOLV5DniPxHu6q/kt5Gj3H
	 qOct72eysNkymaJekLI8AA6ilBd/BDFIIfDaq4fjFuO7Ead9VwRQOQOVFeZ6hktOF8
	 XWo/lZYfLMLXt1R5oYoFlHbMXpTbUyF7gZBF08VpR7GYaOPmM1idgb+BW41p7xemqZ
	 +GzKkwfkQP+bRCCORob4R71KhFeTEoRW+O18JIToo2rP76t4FOLMDs8Nz5MeK02X/J
	 hDIVDYL+P5PXQ==
Message-ID: <sashiko-outbox-200216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/11] serial: 8250_dw: derive RX trigger thresholds
 from the FIFO depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-6-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-6-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:19:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D6

