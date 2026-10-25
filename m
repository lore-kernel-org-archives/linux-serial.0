Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792969719;
	b=l837iyKns9NZCxMGU3lUBndIynYdiGjPA3KzAi1FZcLpgqhrpILIy/w6LAJgE/M3UxOR
	 as2GSBTDsg2WJYMSkc71TLFKVlA1mpwmW2Wt18s9GHXsQDweff+KSbZsxq5Tv3koz97Xs
	 L+FbfKOQpMv9kyA0mYNcZkhVTbiCaM5Ze1a0ZDu/mi1/RUJuc7saftOARIjOl4nadLJGg
	 vMqcdrpNXrbFJ2ZkWAdTRhIKmJIxp9SUYPAIMeaNbNtv/bZpiIjBxQDpIdNKFqtLUaBS0
	 3VxOaLUuyvA+s3BEMuqRL0UnlixtASpld9mYv0kya44veW8txXW9S5nzTAqo9GLbRKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969719;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lMrYniHNrKwNoV/oXJT/U47m0VG07J3Oza8E+HQOjGY=;
	b=UddgafJ01c/CpU3E4tiNPH4tO54GPBHLWo3pvBKHI4HdG8YwOIMuq0p2B0mdmey1F0lv
	 W38cTUl81f3B5YbzTkZGZ912TKeW7TUCoiym5WBKTJDYN6HqwHHHLN2i29oXdPEHrPINy
	 9xkcfrmixrNcTa0Nzw3b3IYc0GPB567yhBP2FGLXYwCVYHzQ8L0K1sVmiPyGA88cw1hBY
	 z0YxBsLGDWkbIpO79ocl1VyWoT5OdWZsGwMhy7dLZNehfW5ekScDkqZOhpN2gXcqbeIsI
	 CyyC533/aSUllxeN646oXx7IczcMDZfvbhatOtxSz3JYQmtH1SnsJUOL3Ddv5r5AzLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hW6HuwP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6425606A31B
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hW6HuwP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471D51F01825;
	Sun, 25 Oct 2026 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792969718;
	bh=lMrYniHNrKwNoV/oXJT/U47m0VG07J3Oza8E+HQOjGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hW6HuwP5wGrRNVjFFhUBQSyrKzTjpem1ArDvUftgGVeo5ZXeMNRMOs5egAzJzTkh8
	 4vgvote63p/gHMmSCsUB1LJww3P+AYk6DgoFyo82PlQiOLo7wsLX1DfwA8pxFYdpF4
	 gEXVGLnY7ma6X2cRF7m+1cHTy12mmzocW+LK+lcohSU3REY185pxSYgHZXN+cdWNhi
	 vgj2s8gSjxx+uPNqaygEXIV18uIv/lK7xHRW+bqvxdmeXnQPfBA9OVzsD45gRJNTWV
	 j0RTxiVrcJhU5CoVN7O0kADVO/pnNAWwOgrVtccX7CXoJq2YTYvQb+YDRyhxBfGrRb
	 vKefty5HF7o7w==
Message-ID: <sashiko-outbox-184519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: tegra: Fix overflow in
 tegra_check_rate_in_range()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Patrick Fischer" <admin@tsv-stahl-riesa.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 23:08:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra_check_rate_in_range() calculates the deviation of the configured
> from the required clock rate as (configured_rate - required_rate) *
> 10000 in a long, which is only 32 bits wide on 32-bit ARM. This
> overflows as soon as the two rates differ by more than about 214.7 kHz,
> so the check lets through exactly the large deviations it is meant to
> catch.
>=20
> On the Tegra Note 7 (Tegra114) the Bluetooth UART ran at 45.33 MHz
> instead of 48 MHz at 3 Mbaud (-5.6 %, see the previous patch). The
> check calculated -0.18 % and let it pass, although the limit is 4 %.
>=20
> Do the multiplication in 64 bits.
>=20
> Tested on the Tegra Note 7 with a tolerance of -500 for 1 to 4 Mbaud,
> which gives 45.33 MHz at 3 Mbaud: the driver now logs
> "configured baud rate is out of range by -555" and does not apply the
> rate. With the tolerance of 136 (48.00 MHz) it logs nothing.
>=20
> 64-bit platforms are not affected.
>=20
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-upstream-s=
erial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de?part=3D2

