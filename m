Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595367;
	b=kI7zcUY0e8zg0nB4eYOBb6gqfrVjGX/ryJN6hquxWk51fxY4Vxx5rH+mvZUScWHBiM9P
	 exF2DTJayy+QuaN/STlKYkCLojEhLT8PtRnUSP0VPdUDKPmt/fK/J98274r9U7pOAtwjc
	 qgaMpQ8kJUMwRSJqlNEhcpP7QiMkvkelfkltKCqYNuQktQdXDnzZzCMHpGdDEnIOMu7rq
	 uF03einEKPd/MplxHHb/05TC3rR8sUVoNk3Y3OuNuf3afQNVl2EDKqBzRU8c6+2P4LFj8
	 CV5hSuejeT/tKW3Qh/PwTLo3drQ0cB1ZiPXmdMQF1kNRYO9YTVl0ICx1D7h/5VPV9mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8kkfm5eTjy3PB7PfIQ4ooV8N4pbAc5HFFTOFehV96D0=;
	b=x6Buj7rm59n1hkVu9pZCzTrkLbXww4DqUQTzJuHDueqtZZFvcVOm29ha7JgsFAoi/FDZ
	 kJKT5AVatm/ntLBLh2hUX2WFtYumIf/DB++52SjdgMMqIxjYOxdRy4hTa5sfChYgnXa31
	 0a38zjPa3pFpPasesBTQWjJyK4JLS08CDdk0ZU4utbzda6ATXolh06iXyquJ5Fs/DXjXQ
	 BjQ5rD7GAz4IAs17lrf+XpkniIrtdFvBSi3eEEJ0EES8w0yTPjZXYfI42Ow/AkYb3deg+
	 WC0VKvTtzquxzvqCCX3sIfMcj1wpKO58/iswz/gcaniwrjfGlTz96ETpwUyHI9iO5qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xl3lU/7i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CD606A65F
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xl3lU/7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C13B1F000C4;
	Fri, 13 Nov 2026 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595366;
	bh=8kkfm5eTjy3PB7PfIQ4ooV8N4pbAc5HFFTOFehV96D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xl3lU/7iI9NnBiwThxxc/RcTI2LiPUHOCiCp4xM8jtlHmcyh+qNM9VOMLOl9IOc63
	 vBEPjcpaT/l/zlfnHHu6McurFgEViiYD8h5Jb8YwXXrM/zv6mhSrPruT9v71A8PgsN
	 U4SWemfpY/L4/h1O2YQGwVezEuRGu/x6uwZDvVCfs93T3FlAofcotXZcEceSanme5p
	 euKFpzJALDi58uZiZycmiLHCWnPbwuaLjjVD4GZaGtNQxxV8v/IvXMEFbtszr7YE5X
	 0aDtXWXe39dg3NfwRvvsXvMeOTYs73nWQjkwbzXpqd3/IzhG7oy93vGhYEWMGqsBhf
	 Bf1hRUgEnDjMA==
Message-ID: <sashiko-outbox-213428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-g2ul_sci-v4-1-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-1-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 18:42:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
> SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
> PORT_SCI once the transmit FIFO is empty.
>=20
> The hardware manual does not describe disabling the transmitter to end
> a transmission, so this special case has no basis in the documented
> programming sequence. Remove it and let SCI follow the same path as the
> other port types. A plain revert no longer applies because the driver
> now uses a kfifo, so the code is removed by hand.
>=20
> Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D1

