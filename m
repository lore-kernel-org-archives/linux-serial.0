Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA52E2852
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370558; cv=none; b=WRJFa+LEzd4E7kDRXvyo/zydAji+H2tJrZgY6Dw2zDYBwEyoysImOAYQn597aFGGp3j5twq8UpVo9IDDLuJwIAvp4kqXrJi3FOyR07iMlWluuM1NkzvMElB140Kwc2QVdG/FO1en9yuDExCgcW5SG/AXd5TNhVhe5NeS12FpjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370558; c=relaxed/simple;
	bh=dJO8iUgFoYgxoq8AZd9YzDvqJSvkwzUTRicvVkhlWM8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LBdgdirHmINHbHnfXWB4jcVG3E8tFAXc8w8D07MzDebejKBWIj6+yRwpYLMfiEnJi/xzypK4OJSfLKFxzCbp7V+GAsXe/kIPuVl+irDEHSunZOuo/YmfxYLaqYPaCuthW6349Tm0W8zXJUpfr1b44dJtQJEydtC2mhLXiDj132M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTp0SCfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTp0SCfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93901F000C4;
	Mon, 19 Oct 2026 00:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370556;
	bh=dJO8iUgFoYgxoq8AZd9YzDvqJSvkwzUTRicvVkhlWM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTp0SCfWM8RczEFTbIxXtm15AGpHVZbMUnMFxB5LFsmfDgqvSFL4G5WZJl1SnGOis
	 P/dPfktBZhe4JROxWDW8BFUgJLiQz6hKynOkbAoYSwJhPE76inbhzAyjYGYA123uE0
	 TqOs4GAPmL9whlPmK3cDl2c+97pfN70hcAtUO6kbo3i2cLXVbL9b0ueWlpcRvihi9f
	 4r6kRIL/Y4su4cuyP41qU24i1gBdn37szhFFf0ELENARi8Ht7CxK1IbQPJRV8hJvst
	 vEIIvI/iZEbJQEY3Cp8d35rutIwd4Qcebtyd0/KwXpq5odwC0WiRrXmwtGFT+NXnEj
	 kk12qK0S92rVg==
Message-ID: <sashiko-outbox-176470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] watchdog: mediatek: Add support for MT8163
 TOPRGU/WDT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:42:36 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add support for the Top Reset Generation Unit (TOPRGU) and watchdog
> timer on the MediaTek MT8163 SoC, which provides 15 software resets.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D6

