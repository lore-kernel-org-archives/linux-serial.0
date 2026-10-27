Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121376;
	b=f1m2U4TuMNKhf4uh3Xetx5a3mC3Y/76lwekdNJi624u8RKt3QDUuJUA16KmXUBGKIXq7
	 i1Bco97D8ONAvb2dyV8Z6fcD8/EnHDsw3Ch81t0HBjItUiTOl+EjS7whGa4tgH+QSceFE
	 y2YheSpx7XnKpRXPBYVQEZ9aC5CuZMjpDWGXuUYVXRG+Ve0+FQb+Wq3Dzo22uxvqKtHsx
	 K/dy6ZbnAseGIPgNM8+Fe6ilo6vn69W1tRXIc87BDTtYI0I6IqsP8cBb+lHmaDXE64oz5
	 D+hIjaKCEMbUmGrTVtgwnluARkBvZElZhYRDAyWtfcrDMVIVgRNA2MsgIZOgzZ1RD/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121376;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dPGqEZhz1K47fCMbegZC+JlyKQdqvlPhCRpJ+bR/mwI=;
	b=UYd99e0TJWfhVo+hkr/Cuv7RKsRSrebJ77fQI6wPMUZDkOOfd2lxGzTW9svKATgleoOo
	 LzA722mwhQqab0OhbH/5H68W3RWFItBmqmKnWTLh2sxoVATjACu7ghNM1aRjIQrCUEFUD
	 Aq+g1xkV/p1UzwgnKePxmk1o2youzYpUfcW4Nr7O2NhL6oqNVfP0c3hmk63VkV9zNWHSa
	 sRKuMcQNmyBo2YO6I0lJPU0gUuq3cgH75xL4qq77Hh4qFTaeix+gQJpdDj11cTqBJGtae
	 PdQHsAxAjVgin8iVeVWP/ddjDS7vKnopqdSTd6FxB7WC7SusNQ9hnEA2IupQ4nS2AsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frNhDIqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB66606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frNhDIqV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCD1F01825;
	Tue, 27 Oct 2026 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121376;
	bh=dPGqEZhz1K47fCMbegZC+JlyKQdqvlPhCRpJ+bR/mwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frNhDIqVI8ijY53Nf6Aiw+AXX8hrFNsdP5FJJlND75ByFsWYomZo6hr2oMVxKC3mP
	 l9MQ/e9VkNmwW0t7XaejIIbXp9pharD19ppxsOO7jkyArM2/91sUzIJHgv4JgGZ1gH
	 oxPGVzBg7AVj3ltjv6dXrViIDHlM9JFL1+osbSRdPu97G4ShyPg/VjsXnVybtNNP2u
	 GPyWXqOX6P9HFNZfpC16ENHQrvaBGCXKRwtImMh0gnOkprbpvH9zsA9b4DAol9y2WF
	 3hBK4uZrCkD46lJEAaKJ0m5gQ5e0fZjEQ4McrWh6tgg12uhaLQBCpxwXNTc7U/t29u
	 uDbtLYZezBvIg==
Message-ID: <sashiko-outbox-186979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] serial: 8250_dw: preserve BUSY-safe fractional
 divisor programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
References: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:16:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
>=20
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
>=20
> Expose the library's fractional-divisor calculation and DLF write as
> shared helpers. Install the BUSY-safe setter after hardware discovery and
> use the shared DLF helper to program the fractional field only after DLAB
> has been confirmed, alongside DLL and DLH. Keep fractional-divisor
> detection and calculator selection in the library, preserving the core
> calculation for integer-only ports. Let the shared DLF setter check for
> fractional-divisor support so callers can use it for either kind of port.
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-ser=
ial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com?part=3D1

