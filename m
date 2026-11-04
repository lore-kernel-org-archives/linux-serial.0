Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778642;
	b=Up+9WFacw7DJvzCg2SRAKL8/EU9OXuIJ524t5o1nn/N5nMqm2jr86KjQqrdEfFwEBiic
	 8bo2zC7pUrFsIjWNP5s3r9sVNCQB/yvS6QWiuhh57iGXFku1WJvYnGzGprRzFmORyAzDN
	 zRtCCwT5IAQN2jtx+Qdji/1/yLpAy50eH7MX0nIHxlZlNusC71NFmdA0BZyGPSjkICVgB
	 RmtHBXhcWyIbcUq40J0kKAD2704sZ0cGcWYQbUZkcJXMpCG0kcxNSd9AsMgEkve3e9lRm
	 /TrpEU8dgiP5V45o5dE4m7cO2A7LKDkM9ZhT2/bY1g4Hjw4FMJ5sF7nDhwxXuykBbBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wJSm27/chnvRcoF2XLH/LNcqPL0SKU8M0rb7auOq+1I=;
	b=rDoC+pHu4iLjTjhayOJZxClskXu47I6TSgfXE4/r4/FHjUGjiYmici7k+an6Zi3dSHl4
	 I3/i5hjbkNd+5X7jrANdSl+85bq+QlRp0JO7TaZY26BV0JWPd8JcQO5WcEe8xuMfK95co
	 Kaw4NqCzHEIqjeKjtBcA4eSPt0Qdf0ZckWhN7MKNM9YoLAknKM7S3nG9TyReUCt5SPbpD
	 2oy/dxJwWsQm0SqYGUHJDHOiyiXlH5GvKK7qNQcsOWGxE/ukece/afFBawYdHhd1nTIrx
	 0zy+dBpyTKTgBxHrcuKeVrWTNrhplh7e6nKrWT4I5tYCAGRcKIA0hA7v7id18bC2eAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuXje9lc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B240606A326
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuXje9lc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36841F000C1;
	Wed,  4 Nov 2026 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778642;
	bh=wJSm27/chnvRcoF2XLH/LNcqPL0SKU8M0rb7auOq+1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TuXje9lcL/3cg1pC6d7B0nn4gInuBJlflqL4RUC66pSeI3EBebEzFFIhduF3V0SND
	 45IFC8qidBSez/kboYpBYmIOBQoFyh45bYwGxWj+a75ZVNwxRFTwFGVtw41WcVWpzX
	 cghcdc26V80GC6Xn+la8hx/B0vYOwSpGlIwjEzv+mHg3gf08qf75pTpcqyJpk25i2n
	 D8q2smE+n6qLQRITQUDBe45KhK0rV/4LHN7tx1eQp2VT2GNd9o/n/FN8rdxXgJlAkx
	 1G/cDNYNb18XVsHAbXqcwhwC8Snbi5XDjj1u+yPLcRdRZ8T3M7jERCE+x6c8wyuI/6
	 w5coQ4RTmpT1w==
Message-ID: <sashiko-outbox-196832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_loongson: Add Loongson-2K3000 UART
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <de8a92980b5140896ef8bdade1df4d851da9ec0f.1793776192.git.zhoubinbin@loongson.cn>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <de8a92980b5140896ef8bdade1df4d851da9ec0f.1793776192.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:50:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The Loongson-2K3000 UART differs from earlier Loongson UARTs in that it
> does not require MCR/MSR signal inversion. It also supports a fractional
> baud rate divisor.
>=20
> Add the corresponding OF match entry for `loongson,ls2k3000-uart` so the
> driver can probe with the new driver data.
>=20
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793776192.gi=
t.zhoubinbin@loongson.cn?part=3D3

