Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444759;
	b=ncKcsrDysacdwrZLJe2vwsIQX9/qQW8RB+DeNWg40JGjLLnUgQPVt/s9R2TbuGRj52o5
	 24VDSrTjCdKv76gNrvByZxQU3RGh2oqPcAqxSxp2qPW9ozbkZjTiv+zG9FhABAjSENKJq
	 8DUjL4Qx5DUAR8LXa9CY2R69u6dKTY7qreRnjg7Ox0r7rsp+Ps5SNblWDffyQoVw1P+gA
	 /DdIaYmPRJHLq3ydS7YB54WSe59n+4YjFN1JGPpm6K6IncacY0SXAEfNqrzzD3NtZ3tKT
	 hFUi+nN+/ZDEaNYvki7M+WEMyIBpu3y3hVR7XGsKlWhMf8UUjPl9fliUeiKEJGuW2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4hKM6W1m01jdk0su8ZWp+N/ZbswSWK+mOLeZkYmR01g=;
	b=RV4e4FRYKox94Nt+PGQYzPOpoJHqx8cRTKEMxxoZojq5pc4N+W6IjnHCdZmIbvaY+eIY
	 9Rna0A7ukOr92Nx7VzoxiMdDKG+lvIRX1p7/HS69Pxq3LDq5LAzk2Zg7lNq/MGi4wjdm3
	 hjX5mTYTP8UBjy6HPdUDDP82EQc0nsWR/MwWAtjsvfqePqc/X96Cm9pTSMDk3fjzcuQra
	 ErfGIN0dvFqrP+3xgyoFS7HOXtoQucPyUzjZ6zwUCRkWruiDHacYHhUwhBbb6LV2szSsq
	 mfCHhw9L5YYhlVpQGnkqqvKHAwByG5FO7iNMqImxHEI8KQGlxpZrvyBw9LlAmZnb4Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ1Cnbde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFA606A327
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ1Cnbde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E5E1F000C5;
	Mon, 19 Oct 2026 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444759;
	bh=4hKM6W1m01jdk0su8ZWp+N/ZbswSWK+mOLeZkYmR01g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJ1CnbdeS88DmjNS93UVVm9kvcFcyNc5BgJ5/SXp/02ckkUo1fo7cmJ4u3KJ9Gp2w
	 JNZrs+/kN4Ux6dErY0nQ2a2+lkgOsWlGsIRNqJVT3RZMB6F+vEAaWHEQf9m1yFoVna
	 eEFbyRly+oD+I2ZNjUpwXtWJBAVR87eVfMajDbLB9VvwyyqBFKyErgOmJXEf05XeSS
	 TF5P3vNBrA4qJGSb9OclUeFq7iQSS9ReafqC7rqj8SKvv5D5tcWFmiGwFlG4ORu9Kn
	 ka+tlx9UoGyT4OY/OwFtoCdBd68M+xVTn2MzHqLfPxUXFmi7GKtYaxz9xU+bfbqKVc
	 ztBtvflGFeIVA==
Message-ID: <sashiko-outbox-178231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] vt: add DEC private mode 2027 to control VS16
 widening
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolas Pitre" <nico@fluxnic.net>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <76b7fb6634652a8670a4f03aa397f21ea57aa367.1792443833.git.npitre@baylibre.com>
References: <cover.1792443833.git.npitre@baylibre.com>
 <76b7fb6634652a8670a4f03aa397f21ea57aa367.1792443833.git.npitre@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:19:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Nicolas Pitre <npitre@baylibre.com>
>=20
> VS16 (U+FE0F) after a single-width character currently turns it into a
> double-width one, giving emoji presentation sequences such as U+203C
> U+FE0F (=E2=80=BC=EF=B8=8F) a square aspect.
>=20
> There is no consensus on this among terminals. According to the
> ucs-detect survey [1], these widen such sequences to 2 cells, as the
> Linux console does:
>=20
>   kitty, foot, Ghostty, Contour, Konsole, iTerm2, Windows Terminal,
>   mintty, Rio, tmux (3.4)
>=20
> while these keep them at 1 cell:
>=20
> [ ... ]
> [1] https://ucs-detect.readthedocs.io/results.html
> [2] https://github.com/contour-terminal/terminal-unicode-core
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792443833.gi=
t.npitre@baylibre.com?part=3D2

