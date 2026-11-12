Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505129;
	b=ixbXFAWx7ymhPcBzjugOTmaulmF85jdCbryWP0WGV6MhnbR1pJ4+duUEPCuv2zk9AwiS
	 aKPrmVcVPj8SpOvtCIuiztqZGYp0QjzYT9ZoFGn6eI3KbxDlIdKA6ibqggDkWUXbE6a86
	 rmNKmu8UxLnAOIzgQEbYs3ht3axPOcpliXQneproqIcydP+xr/t+ZX3oFuQJvEgixZJbb
	 HqI3guPky1WA5XVjdj1yj+s0H7tZeXH2KO8Lyp1Zctpg5te7sDxlFW1QSnXKbMtmYLERp
	 UiVCI/wYc1xxvoJ2sC2ZhafWmSv1ScUnTinJyiBajhM/V+a6zxX/sN12pxhh49FJ4RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rTR9IMos/liWc6QBrfz6GCCp9y/5QZHjWK6M9PJoBCk=;
	b=wI0eD4xRJJj2K8ivMo/wJn1ww3Bn1PbFAFJMD+d4mpdTy+uSbb4iPJQDNyf8xR4Sj2X7
	 yROVMu8I7IoTMlq/DzVWDPfPz1fj7dmNHyxXXO9EZZdc4drHZ4K3aUu/zM3/E6yumhQ24
	 nG5X5pgdJ9tB1IxSwcKhBotfzcIP8I3zKzVYBzTqxr+J4dvyZ6WvMYDbE4k2KmcjxI+y5
	 nm5KZI6YXhh64SVeBXAruW5quybpxDwmisDmytr1rsud1MGFdDMWBAB0rgCo030xOktKX
	 gYWL5TciYm7R9fLvA+NoqS7udyHvXPU0Li2A9tc5IchHuh9KBjg/LSJEx4mnbcv7w/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLr54ouy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1E606E95B
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLr54ouy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD561F000C4;
	Thu, 12 Nov 2026 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505129;
	bh=rTR9IMos/liWc6QBrfz6GCCp9y/5QZHjWK6M9PJoBCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLr54ouyguiGewgWSrkOFm70Ec2qbAkBRW2dDVcbJD0lBGtRYgkF+efYKY+CpL48Q
	 O3c0iNIAKJi3o3RhXsuURK0AW33aRK9g1AC0Z3qvcvznhzAulzowOsGdaxPGAr8JXj
	 mr/rLEPPS8ETqRNze9pP5IJ8PBQ2NprYpKFC8XJgjd+70ag1gDZnTYkC8gp6+r1UuR
	 6qoipvcK/b871Q04X5EY/oelv0iqWmKoRb55pFOIzpcOC8WEuJBMLfA03RASQVZhMf
	 nkTyuyAXqpZzj918r4H2DyG3cxvGfc0TWL1OFh5i2oeCcy6wyCo5ORq8cpWCCYDGiO
	 R+P8JZ85FCXGw==
Message-ID: <sashiko-outbox-211608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] rust: serdev: Simplify callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-rust_serdev_probe_refactor-v6-4-3568ed56264c@posteo.de>
References: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
 <20261112-rust_serdev_probe_refactor-v6-4-3568ed56264c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:38:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Initialize the driver's private data directly on `PrivateData`.
>=20
> Introduce `OpenGuard` for resource cleanup.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-rust_serde=
v_probe_refactor-v6-0-3568ed56264c@posteo.de?part=3D4

