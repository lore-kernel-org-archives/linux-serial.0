Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A253B71B3;
	Tue,  6 Oct 2026 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311511; cv=none; b=Sptzp8WqnDk3tIgRCbawOtRo7J+1DHGC9N/nhsWKdJ64FzcImQM9tBFgJXOjLwG3IsOGrerxUpa6QN5Hb+tq4+NU+FMqjTWW1X0rMpg0qTJbIvkfGyE345QvfmKmdf56n/TPR99fm6B5+fvJOHDeLjESh9fqyZZmsQXsq6QOwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311511; c=relaxed/simple;
	bh=A7azKmerCt8GcJtRiXfBbb8azalt5qUya8Ts7OMbXfM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nMJfdcJInIbj5Kj0quA0mXQrDevhtAklK9mNhmo7px7hbdYCP894XD7iAvWQX57qT/zTKejRhu+f9TMcyeLYC0Qe8gn0w1mp3J8knz05NyxgvHV0WlGdxi2XwOBkeBTksNzQoVuJxKsd+FrnEz5bao1IMOF5pv+NB1sj9zigDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMpbRZhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMpbRZhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A90B1F0089B;
	Tue,  6 Oct 2026 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311510;
	bh=A7azKmerCt8GcJtRiXfBbb8azalt5qUya8Ts7OMbXfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bMpbRZhAe31X0cY3RT4YjF03gkQCbZ9LTQZbmV1Vp7VslFkTPMKn1GaBO6bAbN7rv
	 WG9XPX4ra1GmlMSDJoGBljCS1CF6HgMzV/df7HACg7+F+7jG5ZKfJRbDlD1a3mrzIS
	 c7+ZsAQrGDWuJzP8ZVwlfKcqWZuQ+ldB9YwHX7PqadvRPQOHrJWsih42E5L7nR8Gtf
	 UAga8J1Dk/JT2dP1EMY8stOikq0z3TN95cu4erGC8HA6CS9PqY6UhIpwwNCoFCKd22
	 MPykE4FMUqK8K1VWVkUgRbMqaMhrUDYhH9tDG9NzHwN5BMHZrF7HUzQxKhhc4yiEJM
	 r5tT9T5eDqqxQ==
Message-ID: <sashiko-outbox-162346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 04/10] ARM: goldengate: Add support for the
 CS75xx SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-4-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-4-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:31:49 +0000
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
> Kconfig symbol, ARCH_CORTINA_ACCESS, covers the whole family and is
> named after Cortina Access, which last sold these chips and also makes
> the newer 64-bit parts.
>=20
> The generic DT machine is sufficient for the platform, so only the SMP
> bring-up needs code: the bootloader parks the secondary core in a WFE
> loop that polls a global software register, so boot it by writing the
> physical address of secondary_startup to the register named by the
> cpu-release-addr property and issuing SEV.
>=20
> The CPU is a Cortex-A9 r2p1, so select the errata workarounds that apply
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p2 and needs none of the PL310 workarounds.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D4

