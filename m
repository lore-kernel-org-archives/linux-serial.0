Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906966;
	b=w8uOAVZ8MnV3KK6NVaZ2NUzy1z5t/JCVhCnwD9sQBEOHheJh8gKsnp+HOenb/ice0fgd
	 eMXOgOkAgOBTEGNTbwF0aO96tvMbznof4lm/4It8g/UeS6R3bWlyF3QhWcnm2bBijmCuZ
	 p5ZX6YX9hDw16GCLhXFCbDeS0d1sGTNUKmJSRqg8yzlyCB7Ft3cdlrrCq28he5ef27eXR
	 /8NtTLfzM0qVnIcg/PsW/UzNcOWwyTkFLoqCFa5UdXtnzzUPovYgPTGJedltGFZzsXlxU
	 66lxybQ7aNj68YXspsO+6pS20MnCvXlaTYyk5txWyGZcHhWfnjMbaALYUUekGOPD/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EQxug5Gzwq7gHqnCeAKtEicyJyHB8cAjLNRoFKSwxKE=;
	b=dnHchhrxVualv5WZQ5j2IvxvekzmvoHewdtkhWYhZFLJWCR3vwHhVZKagWPYi1vxfcf5
	 qd0Exb4Z9GkXppHPmcmOrEIhJOoI5mhI8poVuDBr0rsBBKHzEsXwnaSnLkrECoD39+nvO
	 naoF4Eblfw4RgDYgilLe1Pj6Sv3eCXk6gA66+b3mn9Srdf0mWeteWS1dPh/HuW/l+ZMll
	 Ok6n7UlI+ndVowRkz58vAGL8Fqx/ZyILVQaHPfOP6vPvbnwci3+rVT1g/omeWNVOCoSF8
	 /Nz3zxvbukdJnFCsXCvG/w8ic/oGt/6DXyscaSAx/kKtDTlG3jeENsGExRnaV3JPM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IR9cUdtc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3431606A334
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IR9cUdtc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774F51F000C9;
	Tue, 17 Nov 2026 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906966;
	bh=EQxug5Gzwq7gHqnCeAKtEicyJyHB8cAjLNRoFKSwxKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IR9cUdtc8HlJ19F4ynT0lWPmWU0qWFGLLuxi8/yMxqmlkA7GIDVomwF6e5iWMEd+8
	 bPaTDfuDk5uok0m8RDo75pDrnf2JjKF8LKYxaG2YKrJWTKy0l0IEka6mb6tLu0f0Ny
	 k20O92QP+m1UXATKTFbzgIEsxrRX/jGgaJsWt0xBu8DBeWifNpdy0d1CWrgJXxqRNQ
	 7kqsN18DWsySz8/sPQhY/HMZuH+ldzOS9fJMmle4HV2szJDCGmSqG9K0SR/Xc9VT/H
	 QAZztYzxWgCLygo1Pih2sDRE9wm8KMcfgb+nB4VerKpuxIpp7vparGYg7Q3sYDtHas
	 XbqXGpYopXosw==
Message-ID: <sashiko-outbox-218468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 MT6833
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:16:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Add MediaTek's MT6833 (Dimensity 700) as a compatible of its own.
>=20
> It can't fall back to mediatek,mt6589-wdt, which also describes
> MT6589's twelve TOPRGU reset lines: MediaTek's kernel for MT6833 resets
> the connectivity CPU through bit 12 of WDT_SWSYSRST, past them, and has
> no full reset table for the SoC to take one from.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-mt6833-bas=
e-v2-0-058a0685c40c@udp0.com?part=3D2

