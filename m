Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5F2F363F
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370670; cv=none; b=shIEiw2czzLRiED21Xnsp/QV1rOID3CYPlVJc0Cwods70nFNkx/VSB4LWXYguMHhGeRt0IzJWPAfDyADmJfY/h6VZ3RR6fjXrz7Pj1ZJOAsGGjIhq8MW76jykmlv9snKWD+CpBu8uOx3YAk2oit57EMgnUqYV/gR75u079zPaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370670; c=relaxed/simple;
	bh=hbZ7DjWi4IfpCAlPVivGY0NtCp6XcnY9dlWSH0udeJ8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pvDUuKfrEnf1phdUDFN+DlEwU0afqVPy7C/t8id09jaqWTARMNBYmHuS0y3U6/81MXr8EzfAa92iY7E7kJNhr102bcBVDBCeirCTVRb25tzpO45bT+OnRXAqVftNwiZz2Cf+LUvSFZR49Q08JpqTDK2OtI1SA1ll3Pwr+H8QRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3brZF9w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3brZF9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DADE1F000C4;
	Mon, 19 Oct 2026 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370668;
	bh=hbZ7DjWi4IfpCAlPVivGY0NtCp6XcnY9dlWSH0udeJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3brZF9wbLmT8S8Jn2sfrxgr1EZv0ZaMNKKJEJYkXui8+4jnm/Wj2RHmRYgfIJu9f
	 vGG4/gKIAQj92sjx9wi9P+xoZvuLK2rUR8dkL9RZxUbWOYecixNj0b1Qul1Iuv6YZ1
	 R6XaPjqpPwUa5tZBYEde3on3psii265rkKA7cyTs9+mPjhB43MMku1mxcZL9Xp5lUW
	 gFXPYzmPmuNmdoLVyXTFqDCroq8D88tvz7brjgv5dhOth78QZG5+IBRF2QigvaBT0X
	 C6Mxh5urcoyb3kgXbHkixOFJlTCKtmwqhL6Aat3fZoRzA4afKg402esfAxUN6ufrMV
	 sem1Vv6A737yg==
Message-ID: <sashiko-outbox-176473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] arm64: dts: mediatek: Add basic support for MT8163
 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-7-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-7-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:44:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a basic dtsi for the MediaTek MT8163 SoC, describing the CPUs and
> caches, PSCI, interrupt controllers, timers, PMU, watchdog and UARTs.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D7

