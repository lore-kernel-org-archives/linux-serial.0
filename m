Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D54A4986
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331549; cv=none; b=oGtbLy/8B4DF1S0x05NSAMZ/89kpXvNNxmuLCyZIvPzJHCzdLv20oY1fX55QFOu9qRTVuNOPQXYYqrIk+SfubXws0hACSBiMJi6e5cTOKxYN762GaD02vd9XF0DW//tge+A+janDSOuC7+zVvzO+MrVzO1CkYr7vs57wpWikMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331549; c=relaxed/simple;
	bh=uyuq4BsVQogxeWfc0ngeEklsETNJhQHXcSm0qtu2RY4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hbSsUzquOg7auQZr+4ABWcavaCHEKaHW9vj+ShpnBslHgoDWKhU0Ve/ddW5qDd0x8b61m7JudTz4KgMYNRY4vDPv+f+1BVmPYPp97DPRP0XuVszVv96z7ZofZTaM7WNCcAJh2X6xvFXh2WmQtYVnjhrBbwDPECaqAMXDeOcM5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbPokVjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbPokVjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61591F000C4;
	Sun, 18 Oct 2026 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331547;
	bh=uyuq4BsVQogxeWfc0ngeEklsETNJhQHXcSm0qtu2RY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbPokVjptpvxXDkMRFKHgnJk3XG38YMKctXVYgZFGh93tXB/HxuImchPikiTLgob6
	 uXz/F4c0+cn5nwaJHkgyvKwKpgvMLQJkHGEsfDpfeTh9HYWSpUKfLEN5mietg8eKyP
	 VUbA6giBM0RUTDIRVBzkIL0H4K9VLFfjydHnDXrJn1PnN/PINLsuDyX7LZte9Xda+B
	 OxzWMGkhccyqCZH9RxneZYUIvmlKFrsRacjm1fQmdIRixE8mfPduywg9uhXO2dNPje
	 wEZ7zbpMSlSuDoU/2VAZXD40lrj2FRgPfgHcUysyNVaJnQ192SFm7qTIbofelTvDoU
	 Co4HMUBMTHmtw==
Message-ID: <sashiko-outbox-176162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] sparc64: stop IRQ setup when descriptor
 allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-5-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-5-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:52:27 +0000
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
> Fixes: 8047e247c899 ("[SPARC64]: Virtualize IRQ numbers.")
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D4

