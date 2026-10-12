Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A436494F;
	Mon, 12 Oct 2026 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788862; cv=none; b=RF9PQRJiE3fPorl8+d/dTGP4Dw6y9f3zvU7lfJK/uGzKHvn4/L0vPx5EAqYKSSMPUY+Zr0STIiIQ6px4BZxPZlytRYrBQ/54JqmV3jdul3tjNDLaBHdTzQ78iDBc+HUyA+bOh+GLxlh9GRr8C/qCZvmWYe+r6OgDXV6IFKRc+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788862; c=relaxed/simple;
	bh=Suroo8zAkdvMYOtYUUlUuUwEf+e3m49+zIRyTS5Fpq0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Lyi+LvutkLawck1+2MFH4Cdpqi+44lRIQUv/j+SpXCY7QVs4FFG7BH7JoN5441f2y/Ju+URy35Zx3LM2+C2cR1SR2CoGqzwty2M38llgdnEoOkEbFK5wG0wEpcaUhzAd9wyF9R339R5TYEOsVMsE2vtVq+uxyHw5wzpQA7xBFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g75m8CZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g75m8CZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928EC1F0089B;
	Mon, 12 Oct 2026 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788860;
	bh=Suroo8zAkdvMYOtYUUlUuUwEf+e3m49+zIRyTS5Fpq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g75m8CZQiWdpCUqQAixcTSDXiTkDyZwDR0jznUtTHCuF0PUg6XPEsEr1hszf0j092
	 6dYHA9fjlCWx9YLOkH0qamI5huOrA6XZZIGWqXxi6KxLQfovDrcbtv0N3C12rC8Cs4
	 nmYdduhgyINjBCqOeCN1mtub8gy2O02p9Hm+N1WfDaacSuXiSIJKr/gdIUdOWPcMMw
	 a69Rb24kQoNDdvhpf/C/qHGvPt0PgakhuQkZQZgodtPwGeo6buA7MrhQ0MbYCc2Aew
	 28rR/KfQg4ha09g0rOi3Sl6lra2hpg0R+TRNZlNmjbhDNO/pyCc9p7PlD2sqX4UQgQ
	 o53+262ocZ2jw==
Message-ID: <sashiko-outbox-167775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 04/10] ARM: goldengate: Add support for the
 CS75xx SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-4-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-4-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:07:40 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> The Cortina Systems CS75xx ("Goldengate G2") are network processors
> with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
> timers and a PL310 L2 cache controller. The family includes at least
> the CS7522 and the CS7542; the CS7542 is used, among others, in the
> Securifi Almond+ router.
>=20
> Apart from the vendor this has little in common with the Cortina
> Systems Gemini (SL3516/CS3516) supported by mach-gemini: Gemini is a
> single ARMv4 FA526 with Faraday peripherals (FTINTC010, FTTMR010,
> FTGPIO010, a 16550 UART) built for ARCH_MULTI_V4, while the CS75xx is
> an ARMv7 MPCore whose UART, GPIO, interrupt controller and NAND
> controller are different blocks. It therefore gets its own directory,
> named after the Goldengate codename like in the vendor kernel. The
> [ ... ]
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p2 and needs none of the PL310 workarounds.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D4

