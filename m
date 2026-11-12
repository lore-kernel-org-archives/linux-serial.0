Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505329;
	b=D9a2VX8FOx/9eOnIa81aoRU0/0Kfnk7Qkv6uK6VI+HVmTHzWxMPVulsZsctPSAEJNhRx
	 5Tc8U4nrSyuvzVhJmwahIpd4FbnIy17NFz06XOvFN1ocLE7eLQ0DD7fs7hZt0Kqn8QFoC
	 63fV8UodUp8TGf4qt5B98osW1Vu5SZbn+acEjwqFGJQ3NULRS6s/2PO2yuNUilUz1EJQU
	 ejSZvFi5nSiTWYiJVFmOvSVThkhgfWyhpR6D8gszb7IlIwJtEvZn9M0aqW5iJOi+x8L2Y
	 9vlZGqyehbKxzh+2G1kxXcO+8rdy8wyQYbBDLJKlQpXQdnhshziGzfI8ZYDxst99aEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MMIKjZRHNCuh7OORaszpodw3Zz5n8NJqRwlPoVy/tKQ=;
	b=iDpC7lraN8rwpxTrVaqihlN8qXngQ2dRHg0/mvUr4ZU6Ul+8nkJzNirN16+H6v2auI2q
	 BZYJqCMxHU/sxi9QcdH3I31+mEuu6NieZ5ySVsVVHldJzX/5mFRRZXPuYpBaegbVhPfCI
	 9rBT6wu95ezWKcXD+PXjMAXlC5kq+DzxxlvN/eGOTLl716F2jFjOcHHRKkaOEjwz7rXrH
	 +nWChkv74XJ8GNupiDBvwfSvWgZNh53HjyCo3+3jD8RmwM5HyoG8vGI3cv+BeSsQ0x3+B
	 3/NCKV7tspDOQYQUKmPQxgXrw0pumGx0dl+3kT4EnUXlbYWvdCrBOMqZPvf7R8QLOCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gfw5iQy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9912606CFE6
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gfw5iQy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497C11F000C4;
	Thu, 12 Nov 2026 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505329;
	bh=MMIKjZRHNCuh7OORaszpodw3Zz5n8NJqRwlPoVy/tKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gfw5iQy+QOAmOMrJzP8bwIsW5x86pPmqPJoV60VkrdnNkFdXTzu5f7aZWIN9mZhcU
	 l8ZECmok4/2TQbbEASC18r3H8j94jCVy0MMLW+E+PHHL6WrBiLVnprjIJm7T4Ht8H3
	 WTEGFCnuPFIl4CWDI3OerV/a/d0vIiaKWJ2bCX7ZpjEnpFy9ISsZm6GbDI6SLPRLGn
	 u9P133tiSLTJhJmajC6ypbAOH/QJwu0o+fYsGWuipfjn85uYXUVz85+SHIAbCDm9Vv
	 GNZz6lZ6c3ARxIJogyyujc6o8FRIbnrgI0JWBz+c0syb8gM9PgH7+mi+mAQc8go97R
	 SG7I565fJE6OA==
Message-ID: <sashiko-outbox-211620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] rust: serdev: Replace `active` mutex with
 receive pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-rust_serdev_probe_refactor-v6-3-3568ed56264c@posteo.de>
References: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
 <20261112-rust_serdev_probe_refactor-v6-3-3568ed56264c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:42:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> There are currently 2 race conditions:
> - in probe if `Driver::probe` returns Err
> - in unbind
> . In those cases the driver data will be set to NULL before the serdev
> device was closed. If data is received while the driver data is dropped,
> the `receive_buf_callback` might try to access the `active` mutex on a
> null pointer.
>=20
> Removing the need for `receive_buf_callback` to lock the `active` mutex
> fixes these.
>=20
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-rust_serde=
v_probe_refactor-v6-0-3568ed56264c@posteo.de?part=3D3

