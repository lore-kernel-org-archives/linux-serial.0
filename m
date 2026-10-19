Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1B2BE02C
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370504; cv=none; b=UsoraD7MZfO/imSPAdtM9+i7pODhr9LF3UoGkzcU4Ft+67I6ueOf2paPh36w5CIUosTgJARnAhWayf+b9lCW6wzphgIYMvMSjSbQf2gmqvdQ48IZuZRbyzd9kpyTkgSmgdG7gbK3keO1Mj1wFpI0KwgeIGJyo+H+FPb8+xToCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370504; c=relaxed/simple;
	bh=tQjXfQI4rk9iFWM6R5Lgcmh7YlFSm7FTEek6twj6adA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i7Wodz6VWl+6yxfEssDZIBXr+P8Jkl9cLAg5HbwMm/3bjP5wkbkG+wkzX+f/CBXAmFwxH4oIASX2lMTBHFX9f4MyRERvSW97BdZD90u+mfE1wOsJnKHkQZUWeDyF/coyo0Q2FYr7LDuAUppm2gwi7U3cNhW+C2bz50Woa4wQZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha2FGLtW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha2FGLtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3A01F000C4;
	Mon, 19 Oct 2026 00:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370503;
	bh=tQjXfQI4rk9iFWM6R5Lgcmh7YlFSm7FTEek6twj6adA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ha2FGLtW0x4GSQtIqFn+nxHRnOlmz9YL5WWKxM82w3uCa4OCFGlD3yI2b38SkR57U
	 7Mo/FkQ5Kqk6N6JGS3HV4BGsQESLWuup0Yy4EzK2/6dI12k4Nb/ofkBqeCH23h5Zrt
	 4tW4WiNIj4VwppEwAOEkR/uwII0JDaC01Mx4QYhYTBm7Bp/qkhmM+HUWBKtvcf4X+n
	 zwWmO6tmiLTxd5xJvS4ymyRuvvsctKelVwU5/DQzRhHOR42RdeOFg9xQmcQyzCoGnD
	 kGQ73s81Ou5d9eEFqryayn5B+CdO9RkTEycL3p4LFbOxfz1H94mP78eY63vQuAgCoc
	 piPWKXO0GtGag==
Message-ID: <sashiko-outbox-176465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: serial: mediatek,uart: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-4-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-4-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:41:42 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a compatible string for the UART controllers on the MediaTek MT8163
> SoC, which are compatible with the MT6577 UART.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D4

