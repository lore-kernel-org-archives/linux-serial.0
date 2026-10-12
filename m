Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D334B4887
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831788; cv=none; b=ZwuNttrrGXeZxeJlBBfKWrSjcbSnf2t68m1e+pV8ZDbGl0VLeeURY/sTKC5/8gT2P3/3mG6Ho+bg3OUncSpIIuNV4tXT2Q6j9y/J+q9KGzIjS+Ad0xlgOAVS+aAxRsOWba/dLqUutbZPKeGlknrIMCVOu55ANPmowtJLeZgvIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831788; c=relaxed/simple;
	bh=qAM8gHYWZ8y0uHX1YglpXaZUWal5ZsXfGTfElQVcgEI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lMUYRI9RxRuFoWsVFz4KiuyhFXrEKyR/BgrUyn1O0+Yuk4rN9JBU0wbyLvYAhirsPOzI4twfGUgA4irMcbl9LWA9JSc/CQrAmuBMiJkykvp4syhm2E9o2h4E2lnIl9Ryzw50eOHUXa1j6gFLSNjXdALxo/WJe+polk8b1qN3xrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ+4Z0q4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ+4Z0q4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8881F0089B;
	Mon, 12 Oct 2026 19:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831783;
	bh=qAM8gHYWZ8y0uHX1YglpXaZUWal5ZsXfGTfElQVcgEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQ+4Z0q4+CUEa6+Hst60kQ+OWKZi7Dvy0GcQtkBTwvqW3gXV6HbuQaUOmmkqRdkmL
	 8YLgDR30S0zzgt7UrbTX8xWK/BE0X/4AEOOvQU7+AcrLtBmAYLyBQoerC3GF6u5soA
	 R5A0UJTdDdIYi56l1EC1lZUlAYo45JIlBRfLtyh9stwozdIX308wYFoVGD68OMqz8y
	 0o8y5uik+n8O+DVrDjM6079m/9HHCnjiGM4rsIlS3n0d3k06ubva7mL5dPh/AoN38F
	 4h/xtXAUHp1nDi4qmGVf7HuMWLWkprMWrFKln5SGVPpvyW8yDrbKJj3gIFWFcJMKfZ
	 pZMDvZC+Kragw==
Message-ID: <sashiko-outbox-168562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] sparc64: stop IRQ setup when descriptor
 allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-5-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-5-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 19:03:02 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> irq_alloc() returns zero on failure, but build_irq() then configures
> IRQ 0, which is reserved for the timer, as a device interrupt.
>=20
> Halt before publishing the IRQ or changing its descriptor, matching the
> existing fatal handler-data allocation path. Returning zero would let
> callers continue treating the timer IRQ as a valid device interrupt.
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D4

