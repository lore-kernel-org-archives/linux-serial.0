Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054620;
	b=Y8xrwwkGvD+0bxdh9BFOvcqdlvraQ8TtMYHFJAG/z36FSKweBe1a9nrYjWuVwzam/mYU
	 q4NydjPAt6l+D1FTShnZK62obA07zvRPh4/vNgU+MqkGDu6u6rrIe6uLjz02KrtoxdBhv
	 r3Tg1FnL99b7FzxRDKYOnduDA73guAdEbyi5obfU2k/W/gr7OJjYEjA3N9rvLk2wh1bEg
	 KXvM2HBrzBzNng1c8PsFhyGiO8AIkGSoSiTeEZjAiKjHM7zOhj1osgD3k3iDZtvERtxKx
	 TgAcRevoOQZdjKPAEb8gsxl0n1ECugzr1A9TONXWuRvbm5cF78yo9bq1KXSRfiCqkqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054620;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OM0vEBwNzvxEL9aCygy9x8S2V/mZ31w2AGmr2+wyIqw=;
	b=GmgC0MbOD+f7duKnhzuQp2A3LH0mLFjNhPHenO/EV4XZDRE3qODMrNt47maprTVEkXh6
	 L9xN5lqILUar9QR7pZWT4LluEDA9/dUR3i+ktbDAvdQPqub3EKga+Am9hM5HU/nT48eJ/
	 3KCHyD0iUqx6aTEj7N8ewD11JPtqB/WP9/mgeJZEkHoDr8xzfNC5kOE+rikc0kN1Qa6VJ
	 fipLFdM+eiBX9LRsofcIA7shnQUT/nVYZD5HzKevUKV1KRfgCsahikhqjVHp9dtu4gkVf
	 FZq1Lxjj/80doN/aevPAbGxE0HyqMNH9LwwOxSybvXK7pV1xGx1B+UrhaHVOmU/OjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJ5kNlGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57A606A330
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJ5kNlGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508481F008A1;
	Sat,  7 Nov 2026 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054619;
	bh=OM0vEBwNzvxEL9aCygy9x8S2V/mZ31w2AGmr2+wyIqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJ5kNlGRhAHYdHt99d9jQqAcQCtND3/IImNth/zlgDe1zea5fTpRtdzId/okvcszB
	 eA5IyFNZKfktXYW7naGZ0lEfn6EegJmhGUZv3MuVh7vAhjN+es0Ib3m0kyQvN6NJ/O
	 G4kWCIT8Ad7OH+ar8/6Or9HdctkeykMa7FbDkisMUD8IVhNIBdZDMb8t76ifv4lBgz
	 FmHDFrG/7uR6vLT6lL1wlntsAZtJcy4JX8HUVURi0rquySnTwFxCid0jquKdBgliSm
	 piiqMWprDmtI5hP2gM3gKsbBM1L4X2yK6WxdzPGkQr744DyInQQzHiRGDLT0hR2OGk
	 kENTS8QwcggqA==
Message-ID: <sashiko-outbox-202898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: Add MT6833 and the Xiaomi
 Redmi Note 13 5G
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261107-mt6833-base-v1-4-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-4-bda21083e9f3@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:30:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Add a device tree for MediaTek's MT6833 (Dimensity 700): its eight
> cores, six Cortex-A55 and two Cortex-A76 in one DynamIQ cluster, with
> their caches and PMUs, PSCI, the architected timer, the GICv3, the
> watchdog and the first UART.
>=20
> Add the Xiaomi Redmi Note 13 5G (gold) on it, with its memory, the
> regions its bootloader reserves for the firmware it starts, and the
> framebuffer the bootloader leaves the panel scanning out.
>=20
> The cache sizes are the ones the cores report in CCSIDR_EL1. The
> bootloader programs CNTFRQ_EL0 (13 MHz), so the timer has no
> clock-frequency.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-mt6833-bas=
e-v1-0-bda21083e9f3@udp0.com?part=3D4

