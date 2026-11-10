Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280991;
	b=J+4Y3nDyaLHz9OUaKXAvI/on1f5hNQTmjeARJX0K3POKKNW+yBRbxFTXYKwbKKlOfwke
	 Fg7Qu8DdYrVLnmV3qMoCzuU13V3VdieciNDJDmwxKkkRBNzQLsa+ANtVH9DaHIgEVOmAS
	 ZY3YC97JaRjakltds1/KYl1zsYvk0iaQHD7XpnJe5Ba4Zz7dCKtx6NopxjFePrSpZg4Ey
	 kli5blTxGlKHtbGoKUYZbshUXklqkM7G7LcwBe8akVIuZU1kQG5kUKT7NLFVR10542nXy
	 dtchnsfgxgekjgnzmQdST5Zb4QBd8FjiVliLb7ecCqUG4Axi5JoVWh+qgoUFVh9n5uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h3/A0h4HpXdEE8X5vekZlzACgSShfsNYieIV/YjUn6g=;
	b=rrjdkswTMGeudibWoUHGHzzdmf2qT7dZd162Y0UyTsMbas5BCB5EgPo9o6dFPtGiacnN
	 BPN0f6w3FxI8QGaFL2g2GEMt5VZRWaXgWqW3zbVCbBoNSHDdy4KNaoNJsh2GK10aNzlUA
	 ajJ3ahP2TrV4u9bBlBZjawFJD3CFkGGXDTf1c1Z1Q7NNmco4QpzirOFVTpE2xwBh5FRu6
	 sKeRpLAI/nZ48kTSBk+Vb3WAemuBdvpjxbCUF/GMogOqDSM0yhRqT8q5dK+FozCVx1I+Q
	 JRo76Qh1m/FCpGeTG10SLEI05hgHEeU6aHMG9uX8ADUue7h7fiAXZbwAS+NGvFEjjZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUvUQzNG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242260A262C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUvUQzNG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EE31F008BD;
	Tue, 10 Nov 2026 03:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280991;
	bh=h3/A0h4HpXdEE8X5vekZlzACgSShfsNYieIV/YjUn6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUvUQzNGceVUQsc8iinFkkWfpnP7Q1IQ1YiOXOE/AmEW98YUISdk0JkLWvVF6fnb1
	 SLv+bEfNnh5CILRlMLTJo/I6ovvhHqaj/jhV1JheVf+OzktqabRvQzvt5RsjyZ6AcE
	 Pwy76TZs7PdYhXr5nepAc7SxdyuGUyJX5JHM5M6/Ynasic2iNFGMmTYdVH4/n5ji0m
	 sECgyYnmVVuUSQsEblyh+otbmYS3x1iX3SnlYCGYL24piKT9InPBw7AySNAaM+q/dX
	 oVET/+PvCG2G8XlHr8QEJi3U0NSBrm+qEosG9nMBrf6tVGpPbYHy3SIF702HiGDgQc
	 ukhgBQ1KK2dTA==
Message-ID: <sashiko-outbox-206112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/11] serial: 8250: expose RX trigger controls for
 custom callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-5-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-5-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:23:10 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The rx_trig_bytes attribute dispatches to a port's get_rxtrig and
> set_rxtrig callbacks when present, but the attribute group is registered
> only when the port type has a static receive-trigger table.
>=20
> Allow a port that supplies both callbacks to expose the attribute without
> a static table. This lets integrations such as Octeon provide their
> FIFO-relative thresholds through callbacks while retaining their existing
> port type. Require both callbacks because the attribute is read/write;
> ports with a static table continue to use the existing fallback handlers.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D5

