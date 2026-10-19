Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444964;
	b=HbzYyF9Mr7K3S6eBIbNySa4PbbEIJDIZNsS12YvzPHOTBewwfwUGRKs1JVG6LWAbWMmT
	 nLBnjurJPgDXx9RQWU7MQ55BJtx+SFvF7QQ5EjWf4KZwgnyu7UJLjqUhN8i9fmHs/tDTP
	 29zyMJ2lvQUEwZ2uKdk6AoukSbIuiBnKJBaRmnod+W3UEyORm1CKKhO3alUHhppBlzhRl
	 I4I71QY9vbLF/3ShZxi0UqYf+TMu6Fx4BAGhesN9FthMXp+f+rGRpRR6A34nAqNfQLVqi
	 5IIkxtLExKKuvfr4C+eJBDNFV8z/vnx9KOhFpgPBKDwhhRt0ZxlmMW8LNqFJHPOmpLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444964;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7t0R1HxwAz8wduGTGorzAf7HFdJm+ZH7rXphRK9Z6OU=;
	b=Fs61yr2TC2idta0BN+Aa6kC20lPjbnBhLsipD6h024P3rGUjNBLm+ige/46SSJscA74I
	 zz3Cmj3HcafdNVIr9qk6mNBCrvLqsc7yxFj3Etm41N9vTWEOUcCXgVbX4YpjbQzuwwmRg
	 xibqNmXbiRlXYqA8IFikTJME64QcnrRCB+vLhgF4j1zLVxivgvlly3X1scCCl1+wwr8qp
	 +xP/RqaBgqNQwymdPGL/NBgHzP2ryVGqL7upZAJbha5KT70DxgD0mLEgHZ0keVrPko5EP
	 VGMFPwo0EfYxsRFMs+r0GcAkXc8Pu455B53/1JSctxjEqvGvhtKFlcyaokPS1AZstLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggovHqV3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0884606A323
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggovHqV3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883631F000C9;
	Mon, 19 Oct 2026 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444963;
	bh=7t0R1HxwAz8wduGTGorzAf7HFdJm+ZH7rXphRK9Z6OU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggovHqV3a08ejln6ROURJhtwSkDSaYYDKegsLUAPVi4sy07Nqtjmv0gdsvja0/TJY
	 5swozswmm0vSTjrxobJRi6fbUKa/9FLvbVRQEoxJ5GTS7fWr2VwVKmEfsJLTdIWMan
	 smOtdx4/lb7YyjDbO40XOngRGj5h2Sot6fn9gdvqihPquX2dD4sxbBWKCjWD79Bkdp
	 CqjH+uf73R5VfJeVhW2tAiLvot8JcZW1OoS9ls57jtGV+DS5GPYkCEzAfDi84A7Y10
	 7+xyz6aUeAIglevFjDCVATEthhPJxjlHz03ofpJuvd64/OsODpiZJXLtio1DLauJvC
	 qdvuraSUfAtlw==
Message-ID: <sashiko-outbox-178245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] vt: add DECRQM support to report mode states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolas Pitre" <nico@fluxnic.net>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <ec7608275b930b9c31c1e08881b9984bc982a6a8.1792443833.git.npitre@baylibre.com>
References: <cover.1792443833.git.npitre@baylibre.com>
 <ec7608275b930b9c31c1e08881b9984bc982a6a8.1792443833.git.npitre@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:43 +0000
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
> Applications currently have no way to find out whether the VT supports
> a given mode, nor what its current state is. DECRQM, "CSI Ps $ p" for
> ANSI modes and "CSI ? Ps $ p" for DEC private modes, is the standard
> query for this. But the '$' intermediate makes the parser ignore the
> whole sequence, leaving applications waiting for a reply that never
> comes.
>=20
> This matters especially for mode 2027, whose specification relies on
> DECRQM for applications to detect support before enabling it.
>=20
> Add an ESdollar parser state for "CSI parameters $", and answer a final
> 'p' with DECRPM, "CSI [?] Ps ; Pm $ y", where Pm is 1 (set), 2 (reset),
> 0 (not recognized) or 4 (permanently reset). All modes handled by
> csi_DEC_hl() and csi_hl() are reported, with 132-column mode reported
> as permanently reset since it isn't implemented. Other sequences using
> the '$' intermediate are still ignored.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792443833.gi=
t.npitre@baylibre.com?part=3D3

