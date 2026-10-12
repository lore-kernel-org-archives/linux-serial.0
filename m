Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780203859E9
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831302; cv=none; b=GizEumFpdBIIkslqgAqUQXmrkwSBdWm97AeNJC07KBHOu7rwG1Z/z09ci2R1n7r1SLBoGOM8OxvsAj0VBPcKaTTqsgjOa8nvCsG9u+HQkKZ+B8pSrIV4RNucGtU/XR+xo3xhYAQyJQ/26bCACzCn15VzQITYh/zNLre50IVr9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831302; c=relaxed/simple;
	bh=5OGIUE7cHbVH+OgZSPk8r3aN3CesTU+JQR3pxfyRC6Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YxYimor57BHxSl2abUjM+5qF5VWPINdlIJ3RXC2k0v/WLJB7IQtc+B473YYXVEYbPwvLUf+cSAlbF8tTmg691H8Og9siF5SFmsrqnSexvhKaZwj2+YFOVCfDD7gSyQeigPqzGdD0WEpGwafTHpV7OsrnkireDet8cpbON3aHnHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1F6SK5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1F6SK5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051811F0089B;
	Mon, 12 Oct 2026 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831301;
	bh=5OGIUE7cHbVH+OgZSPk8r3aN3CesTU+JQR3pxfyRC6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1F6SK5KHPSjxxe01YQxPOo44yUMtJ3d43NlesYse53dBhh3ydVIWfdyV+SMlWBya
	 BMVtcauhSgXOX3frKuK5zQT+3gTZnpyxRJf3DxYDd5jUawKv/F9TXJMYWpa5cQrDQ8
	 zmXm6LoA7+jQ7oBKGzIWjneodhkxGhsC5WC6wU6bFH+Q8j14BpMonUrHUz0uX/uIiL
	 a/HISbTUvPICGWE04fk8mBY3NTCeK40ooKZSjqJ0mgRWNBiHZKK2wRPlujI9CoP8TJ
	 yG5tGgwvYVaktGKv8qNQPCsjuxkMnO7BvXUuSJ88wQLpEGj+MN11DzHKvph3WRNj8x
	 fNKizGqHkzIlA==
Message-ID: <sashiko-outbox-168556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] sparc64: avoid huge kernel PUD mappings on sun4u
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-4-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-4-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:55:00 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The kernel PUD refill path merges virtual address bits 32:28 into a
> TTE, requiring a hardware page size of at least 256MB. On sun4u,
> kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
> Consequently address bits 27:22 are lost when refilling a huge PUD.
>=20
> Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
> path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
> mapping selection unchanged.
>=20
> Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions=
 with large max_phys_bits.")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D3

