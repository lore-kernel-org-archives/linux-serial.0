Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773741;
	b=jI+W9PUPoCuH+rAB479bauxdcSG6pxtvjYyWTg+N8ezU31TE9R/QJPjLtDo1k4mdpftv
	 H3MgNjweL0YiBOuAVmpV4sQBEtPI7khs3jkhmmbCH96r8OlxjeJk/nrX3nXzAo+SRxEJT
	 DGRvXQy2fGJA6lwrRf4v89KHDHpUQduzwKbznq13e3S04FRBDHj15NUjM3W5e0mLrfyCa
	 g4ow1OmNdqDMjVTuXyajV6Qv6dNX/5W/siNzVPwzMHa71tchgalhgIN4MJnaNwg1qOkfq
	 mJsUrw69WzYgPR3iYiNSO8SSQc42o0XIRGnIGthm69tEYsXdzTxe0EX5HRGe/86em/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773741;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qAfXxOG6/edrVZDI7/p7NU6pSaMJKb41wm48epIIO7k=;
	b=yoNcJaBOe9T2iHE7y72XTlUuGZokp4/qHb6d+EQ1VoLgMvAkvAfgZJFZhb3oMGekYscq
	 Ji8JTMKIdkO0qoozKA0qAA6/MHlwYJ3WEv0zz6fA8s0xWCQ9zbrPrB8u3xFQAJOI4shlr
	 WnS5TMdbEfaLhl8G1bjojDbGv5oS5kh/3n8tlf0KjyuaeCOr0t0pp8Kij35JbJevaA076
	 NTl+XlVbgqGqFsnR6G+9LCBzjqUvDRPwkYIpD6veVvi/3TCDvadX4kVXswzZxh+dQ/veA
	 beoIqpUpF4yzqRdAaP2Jc8vcHrThWufasv2IuaB3UpoC3NRtMXfIkmgsF1A/Gk0VTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuGX04R2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77334606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuGX04R2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366461F01825;
	Fri, 23 Oct 2026 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773741;
	bh=qAfXxOG6/edrVZDI7/p7NU6pSaMJKb41wm48epIIO7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KuGX04R27LaqPeklmmdj6x+cGoHSeJmfn51sA2i0qonISK2RF2GcRKvVbjKIt//h7
	 EwN/+6F8mjOJOk1MM1J96bVZrx11aK2CLjMUqA50YFVTbg+I3aYq6hqw2Wf3SRL5dn
	 iPEqvPXsT4OELsr6vqCBVSznHx2wk1xPlvZBLq9nvDro2EOv2BTHl+PQtRTu0OnT9h
	 MMvCnb+QUYTuZnT5C9Df2O/v8+jA0Rni94T86ntpPOq1+UOwXc2Zz3Ml3cSoDxirck
	 o6uTYBZ7uSCJ97qtmIymJ/EuE6NjrInf68Ybp1AKgFfTeUQGbDb8DUClIlPVN7O//1
	 MJ0iOFLkKOexw==
Message-ID: <sashiko-outbox-182962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:42:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>=20
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>=20
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>=20
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> [ ... ]
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-dw-=
dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com?part=3D1

