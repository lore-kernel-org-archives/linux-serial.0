Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795324514;
	b=Fk21nR2jnTvsnZPhr+cgOLZo0b5qVDtTFy/5fgPIHy61syWAiWxkIOpPeE1K5ubpx5CP
	 RKEFCpDkmhQ8JsMpe9aB4gm4gkT6iOLqKXsJPB5r35ct0XOgvR1lOJfmDQoAEnm7g9aN/
	 2gj/sB2699fKaZj/h4Bb0LDJyFZucsV0yBGWOr5y4wMiab4XqVo8x1sPtuRp8ppZlLnIZ
	 iRAROSGgo7T95VO2y4tBKmvVaZmJ6Yh3eXS77ia6e7dFv1bN/pbrqJ3nWjQAOFYSad5mh
	 C4gJnxpcDis/KOi3i3KRkVmFYrID+3g7r0XC4aXVVQc6iwA9o015ffjenfltbWUftKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q7awdg8c9bBJMBQ46vZh2GqgZSkgUhzNREgS4qQ2JGM=;
	b=Vi2gy70CENb9B8UvHOxMP+N+YsGyjoqllH78T7p0yrWtymD1DQJOOfiaFQwdWEp2WGD+
	 xsgSgbW5MG/hZLPD6U/NbZX8tqtHpG/CGVJNoxCZckGJ3/MoKFIiDLezhRbGfMxNxjAfl
	 c2fWG/mm/uuHOT4x97bzJjvHr+CexoYKds8t2sirWa5Z5uR0nZ2GS/IehGhOKEFfayO9L
	 ZQxYacWGYJp2uReZYtiEHJg9Mbf1WMmbMuQcRl5cFr0MMFUJhUTs26IOw7kxtXVltrKtg
	 3wEsKKuGCDPjGWtsiU5WgHmoHv8TqakxQMKvtsTPU1ZqyAVTMQ4aW7K+rM1aLjLdXeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+MVmjHm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F138606A320
	for <linux-serial@vger.kernel.org>; Sun, 22 Nov 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+MVmjHm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C131F000C0;
	Sun, 22 Nov 2026 05:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324514;
	bh=Q7awdg8c9bBJMBQ46vZh2GqgZSkgUhzNREgS4qQ2JGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+MVmjHmfIAzce2NI7YjfqLUKOB7V002lJQASHkRh7W9tZJREysON53IHbuUvHPHk
	 RXANTiv0KJmRLj82KZWavOehhZrL2Fu5DVbrMCe9P6V0rDt+OZWQU9VAvetzCq0hJ7
	 f0TQYiLO27TrT5p3QfSUBsEyczPEe+SeR8nEEgEWrCykRzt0vtSxOGZltk3XQndOwH
	 iYMLsu9iT9596HNKbReihNlly+SBdPKDxfM4JYOBZJGuyBv044a4GJBju5Dso6Ls86
	 XlZk02H8jzL7EtpFtXLJF1OGiofnkHmu4vkG5bl31hwnTIVtcYfvFrubkT1ZH7jW2O
	 qx6I0xRth1Dkg==
Message-ID: <sashiko-outbox-227721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: tegra: do the baud tolerance math in 64 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: EMCP333 <emcp@enser.io>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261122-b4-serial-tegra-baud-tolerance-v1-1-39907382281f@enser.io>
References: <20261122-b4-serial-tegra-baud-tolerance-v1-1-39907382281f@enser.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 05:15:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: EMCP333 <emcp@enser.io>
>=20
> On a 32-bit kernel both halves of the baud tolerance logic overflow
> `long`, so a Tegra20/30/114/124 board whose DT has an
> nvidia,adjust-baud-rates entry runs its fast UART rates at the wrong
> speed, and the range check then reports the wrong speed as fine.
>=20
> tegra_get_tolerance_rate() returns rate + rate * tolerance / 10000, with
> rate =3D 16 x baud. For any baud above ~986 kbaud, rate * tolerance
> exceeds 2^31 and wraps, so the adjustment comes out negative and the
> clock divider rounds the request down a further half step. On a Tegra
> Note 7 (pll_p 408 MHz, nvidia,adjust-baud-rates =3D <1000000 4000000 136>=
),
> read back from clk_summary:
>=20
>     baud      wanted uartc   got uartc     actual baud   error
> [ ... ]
> them.
>=20
> Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Signed-off-by: EMCP333 <emcp@enser.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-serial-=
tegra-baud-tolerance-v1-1-39907382281f@enser.io?part=3D1
