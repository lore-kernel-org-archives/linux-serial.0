Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905019;
	b=eg8Fle1xxGcPd15BcgaOaj246Fbf6hqFsdj0g9LidiQHcxOUr+bpneSUlvyELl4kQiaH
	 LwONM8dRA8UaPGWYQvLd+OA6iw39EN7rOMwhVPUyFLzPb81Ug/MGPlIbQkLl5va1/6fvp
	 VxkljOvOoJpkzCvnL5yAxrFsG9eNUjTTVhRwa2HYzJAdRjbKGvRjm7WzJiNMx9sRfDem+
	 6NVarcW2yw2hpDrqJ+dp+OnKhAJ8ySeEfp7U2XWXjlZU+Hxpdo3bU1VaNwlr1YoD4/l/D
	 7JTE3/SYkTleL1NU4HcTQi4O9ew9QuTuuigvJ3f7TDZsfbsSMs+afOexmCbFUF7+oaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rNyDlciBbVYiQrJ7+3xXjfw7ZrcwbbDcGGGXK5ibkH4=;
	b=snbpwchvhqq7I1SgKi5uCX5GUkiIY6+iF8wVxHnXX/prG1uE5cpLnRu2WHi/MtBaEQ8Z
	 rVjxz7XRz/boUO6m0HEzCN9lQeXV4N+8pqlmO4dXZT8OV1yfpggHrhhLwn42/PgXH379A
	 cNjV/LIwtLfAvi0DXPK6N6sDXwVvwcPfG01QGk7aluU4JBDzcziAAlMwdY+ny0TLotyd9
	 vpFzZJsMsnpUXV6fkUzzvEu3nKfTWQQ+8xZOJEQUvhzNS7xJeXetv7p63HA0pWByF/8pl
	 qVGg3PADwtOG13uRgiXUQfdQ6UW9ush6jJPJ6enQLyM0/o+Zg1LerzWN28JKuA1FtmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/deROwN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A6606A33E
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/deROwN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4571F000C5;
	Tue, 17 Nov 2026 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794905018;
	bh=rNyDlciBbVYiQrJ7+3xXjfw7ZrcwbbDcGGGXK5ibkH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/deROwNRJ1A4INBFV/pI/oq/uwKavRHS7U40VvvTUQ9tIh8rEapptyvt4IDt/wr4
	 J07eQf5Px67JZw+DP4fNtmXGvnvvZOgSGfGNzQEra6rwqFEDevQrKuWG+LJibFnLtD
	 5IB3mEyWy3DONGTALCUa6qal/kPY3z+6NyWUljLHqL2TtrKGscWBov2Ec+p1avrmCh
	 iJgmg3k9413GyrP4aw64GAgdCOd3IrR3Pn8JeuSiXh7vzqWsheEQMwhnAHclrwspk/
	 vQVLi6JgAAZ5wwMGcE82DSrrrUzgUw5pWkNCmzQKgPYqxTBbrvKkPjZdJp1hwkJA+N
	 XczLQGy8qF96w==
Message-ID: <sashiko-outbox-218424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix the RTSWATER field mask
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-lpuart_rtswater-v1-1-c2a95ae804f5@nxp.com>
References: <20261117-lpuart_rtswater-v1-1-c2a95ae804f5@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 08:43:38 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> UARTMODIR_RTSWATER is currently defined as GENMASK(10, 8), which
> matches older i.MX implementations where the RTSWATER field occupies
> MODIR[10:8].
>=20
> However, newer i.MX SoCs extend the RTSWATER field width, for example:
>   i.MX8ULP       MODIR[10:8]
>   i.MX93/95      MODIR[11:8]
>   i.MX8QM/8DXL   MODIR[12:8]
>   i.MX8QXP       MODIR[13:8]
>=20
> The driver programs the RTS watermark using:
>   FIELD_PREP(UARTMODIR_RTSWATER, sport->rxfifo_size >> 1)
>=20
> [ ... ]
> Also clear the existing watermark field before inserting the intended
> value.
>=20
> Fixes: ecba98f9ddf4 ("tty: serial: fsl_lpuart: set RTS watermark for lpua=
rt")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-lpuart_rts=
water-v1-1-c2a95ae804f5@nxp.com?part=3D1

