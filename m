Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597352;
	b=1bdHWu+sFUQTblyswc2uuWZ/BLHt/SW9bL24MNf9WuYIMav/UaZnK0IwqYLKBHdpM9b8
	 ljIqLS7dwCj2H30PWkcEKAs4dJ1IAH+xWtOHWqKOQWYKsvRa0YR+NPaTCrr3CSzhkdhWX
	 hrIgtYeCJJs4fUnHetFk319BRA68tfR7VwO5VNE7NpcfDATOZ9eqnI0DdBLgXe62fAjd4
	 HwmD82jHtwj+bIWu64WJw5zlt+SaAd0fExiIGNik5+EoOSy933gdSComVQxvbXg76+Rk2
	 5SNT1HC9brihnB5D28ocNUrhTpT/bu10dwr2dNrEhHKm0vUYtrarz7XVY5RFm6oCXAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h1CgG+rcALi5sEGhIWCVrvBv06YrqpP7Y02MgTQtfbk=;
	b=Tv2Nky9ZOGye1vO3duYEz35vYiPG4N/961q3qrUYU0sLTMt042Spx6ZBcNDWmPMAz+Lr
	 ICd+zO0L+TPBjKTrID4Dv8oH9bTA0x2FqRBw9o9jliFLlhOpDLdKAx/SgFvHSE3hnL5a0
	 h2NkF607bNEdvD0dMRJm4azAcy8Wl8j+j9r3c87+fJ0QABSOieegSNI3IGnMh2MZxXKo0
	 bxVqwK3l921O4RVK12M/cuvDWW3SNs8ieksBlWJGievyQsyzLhMTPFu7e+oveob+Mebkv
	 ibigAslVxNzOAieurn5ggkHnHvY3E+guf1pIdwrZDU2fw1snTkQxOgagEtcq/CtwV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hnfvw/UB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5157606A330
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnfvw/UB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A881F000C4;
	Fri, 13 Nov 2026 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597352;
	bh=h1CgG+rcALi5sEGhIWCVrvBv06YrqpP7Y02MgTQtfbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnfvw/UBwlfnFcFTKs29i5pmc59cxyh4ZyKvKhhceJdHa90sd4g23qyhFskl7abJ3
	 KE7TEAjZbgeysF9ufxySdMYLcoxGWEIowMVkAWsjtmZCXYpjQHyjQF7XxcPVfyMQWP
	 tbK64gCqmCw2IzMHpFDIEBe9OXJDmayGHFOxsMWIMDjTz/hJQUPKvIHpYUSOXTVdkx
	 vMaLU5KwsxRp3/CSXQxD+AyDDTL+gZxazGJxvnnRYFkdLAoeRCsqF8JY93YzJAwnjE
	 AZqOs0PNkfncBCcBgLSAecEzZq72riMGEhJU8UAHm9FUTtYBQHZ1PsSkWwOMMR6L8N
	 9Nlk5lcYQQ3AA==
Message-ID: <sashiko-outbox-213531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] arm64: dts: mediatek: Add MT6895 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-8-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-8-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:15:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add initial support for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
> which has four Cortex-A55 and four Cortex-A78 cores sharing a DynamIQ
> cluster with 4 MiB of L3 cache.
>=20
> Describe the CPUs with their caches, PSCI, the GICv3 interrupt
> controller, the CPU and DSU PMUs, the architected timer, the system
> timer, the pin controller, two UARTs, the watchdog and the keypad.
> There is no clock controller driver for this SoC yet, so the UARTs and
> the keypad use a fixed 26 MHz clock, and the system timer a fixed
> 13 MHz clock derived from it.
>=20
> Only the CPU and cluster power down idle states are described. The
> deeper states that also power down the MCUSYS or the whole system need
> the SPM and the vendor low power driver, which aren't supported yet.
> The system timer serves as the broadcast timer while the CPUs are in
> these states.
>=20
> The cache geometry was checked against the CCSIDR registers of each
> core.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D8

