Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EF47254B
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904536; cv=none; b=FXIIA12dGkFCPlg7ctMGCdhD9ZZlPZIT6LAhtg5ECamyNgKCs3nrEGJpZpcciIXQWr0t2sCTgx8k6WZcSnGBIwklf69Za3xRkNktclj32qK9M5HAMdiEnVVyyxsOZLLgEIpcEovDFauk78N37IsqXrTZ9uzmyyKiLuahxT6gI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904536; c=relaxed/simple;
	bh=qqxNL9bW3dq24QL5Hp4u0oc/lVnEn98jD9Jmi8/tIlM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WZ/beGiN70AQF7Sz3MCyv9blEDCtWkKNn4+u5jJi1E8pUuXEupd8Bxzmh+zC2ZsdvV0t9LFD1ZFs2IoVUXtpNESEqgDi7BYNyu9+VXf2YMLsgIKYb5T82jGfEZKQxI9YB6L9SIRhY2CQPVxelVL56M2IMqGs/nyHkBkwoWjrMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os8eVX+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os8eVX+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434741F00898;
	Tue, 13 Oct 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904535;
	bh=4TTsadsNexv2Nlo6Uml5YPWilgmFYuwZCRJ+VhprFqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=os8eVX+KTw0Rlm7MCXISlYlw2pSziV8m2VWQyWfEeW+9XiTU1lwqedaVLWY0yCS9f
	 9y+oOg9e6j/bgfrs4d7PLI0D/JijR4eda4jwd5XNI4cKnlksZuGu0bHgQ2oB/T94N3
	 WLc7HqgXO4rZtDGlR9oHYciAmcmG9vZ+r5IzzC9nc4LtmIXUVqXsqNOWS0vbO0fJSt
	 CWQjP0Q930EDVzjypr5Obo6kxQy8HdpuD+F2zFCGSHaLCIICYGQB/yFlOoOpV/fOAd
	 FaFLVIGb3EAm3pf3sc35Hk83IgH3So4x+rAlaVlLi70Pu5nphlUtT5s2OAu+8/Qr0j
	 kwaqxwQfsSRbA==
Message-ID: <sashiko-outbox-169978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: hvc: dcc: Detect JTAG connection only on CPU
 core 0
Reply-To: sashiko-reviews@lists.linux.dev
To: shatyuka@qq.com
Cc: linux-serial@vger.kernel.org
In-Reply-To: <tencent_A0A4CA13FA8B0F7ABF62EE438764D032F205@qq.com>
References: <tencent_A0A4CA13FA8B0F7ABF62EE438764D032F205@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:15:34 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: hvc_dcc: commit message contradicts caching sequence implem=
entation
--

commit 5ac910cf6c31d8b744bac3d1aa1c60fcaa2dafb2
Author: Jiannan Du <shatyuka@qq.com>

tty: hvc: dcc: Detect JTAG connection only on CPU core 0

This commit attempts to fix a potential SMP issue where the JTAG connection
check could occur on a different CPU than core 0. It simplifies the check by
caching the result from one initcall and reusing it in a later initcall.

> Multiple checks are unnecessary: nobody is going to plug/unplug JTAG
> during kernel boot and expect it to work. Cache the return value of
> hvc_dcc_check() from device_initcall and reuse the cached value during
> console_initcall. This avoids complex SMP-related code and ensures the
> result is always from core 0.

[Severity: Medium]
Does the commit message have the sequence reversed?

The commit message explicitly claims to cache the return value from
device_initcall and reuse it during console_initcall. However, the
implementation does the exact opposite.

In drivers/tty/hvc/hvc_dcc.c, hvc_dcc_console_init() (a console_initcall) c=
alls
hvc_dcc_check() and stores the result in dcc_core0_available:

	dcc_core0_available =3D hvc_dcc_check();
	if (!dcc_core0_available)
		return -ENODEV;

Then, hvc_dcc_init() (a device_initcall, which runs later) reuses this cach=
ed
value without calling hvc_dcc_check() again:

	if (!dcc_core0_available)
		return -ENODEV;

The code appears correct since console_initcall runs before device_initcall,
but the commit message misrepresents the boot sequence ordering, which makes
verifying the SMP safety claims confusing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A0A4CA13FA8=
B0F7ABF62EE438764D032F205@qq.com?part=3D1
