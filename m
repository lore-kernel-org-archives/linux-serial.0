Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647E2BFC60
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370505; cv=none; b=l7UKZzY8c0WppxkkoQk+0bph96aeK4pX2RaYdfZH2sVXt0rSrU8RbXQG1JwaVQUiK4IWgqM4KaAvbj+RmoWQunP+4gNQfzOeINt8Iub9joqi8jf3zgGgv5zU/DMur2EvUvFsP5fXrqAlXhleteqd0b0BF+S2derfz7YaLiedQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370505; c=relaxed/simple;
	bh=rUfxFpxMaGd7LxPY7+1bE1/6j8HNz+DFlhYLpNs9euQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iF6DdrHWXVqCTeH8anxcV4uCq8+RotlxGtEwDP1MBz8+lGwKoJxE1FSoZvP7e1xMdYzJ7pdP6H976JhLfui4+2Gx59+9Klht/ysjKbHlw3RQRC1ZXpkAH3N+IMr1l8ZMy+LPFgBZyJadjd/ooPSq3xAQoIYeIxSkZV1LWJoVIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CItVRJL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CItVRJL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77CE1F000C5;
	Mon, 19 Oct 2026 00:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370504;
	bh=rUfxFpxMaGd7LxPY7+1bE1/6j8HNz+DFlhYLpNs9euQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CItVRJL4hoUqNGS1ANa7x4X1n4r4A7kami72bXkA7iGx85Inqy08iJX59jq6utxaf
	 Uoavf/0ksJzGDiJZWU1bSwsAM92Lkj1k5ZnLtiZoXBndjyU4IohDD9E1AFIL0DDJNl
	 n7mrozI+OMGgZV1y/wmgKXHEkHsHr18rYcHuz0rub+1f1AkO4b1oeCRyDEKelSyGFM
	 /RP9oBKp1JPGUg8+zSHsus9Zb0rp5cBOBEhj1k7iOBZObYrLu67zUGeZYG0vRZq9A3
	 bnajlrr5Tv+B9q9RlsrDUPjVF5bnfoLs9lTOHrKoTve95KyOF+qq7DqzJ5kpzL+axa
	 9CQ6Y67ZVLO1A==
Message-ID: <sashiko-outbox-176466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: timer: mediatek,timer: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-3-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-3-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:41:43 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a compatible string for the general purpose timer (GPT) on the
> MediaTek MT8163 SoC, which is compatible with the MT6577 timer.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D3

