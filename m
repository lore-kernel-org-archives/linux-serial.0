Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956607;
	b=axCtQ6pBrDt19v5p+EA2pd8m/KtCYM/wr7/WNcbTVHD2KkoqeBWeONH4cR1Om6Dt0FzY
	 5jAlWBVyDJPgE0cUqoO/cdALhnVIwAPD6rcvHkJWRHzI/l9cxSh9l6jwBhn62daKAiGE6
	 J2JBqXublD1p9Q/sCb2oaCQZpmUH/riP4+10fHAg29H52a/wRYQX6w4sIhwzWF50/dnhT
	 PbAaPILlGVrH15x40tVToO+2ie48U8phK9IAGPN69EqGfLhvBWN5as3cZCIW8yjwdWVRv
	 IPKCUh11z5tTBxas7RP4tdQPtSJMo6NIRo2tJ4mHp1WYsxUbt6aDC1RxAzyXLrvpKcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yTa8tr00Aya6LjONeOTwLFTfT6QwJT3MWJsxa7F9gFg=;
	b=0u60zej2DszjjPd7zHJg8ZGG7uHHRzkH3xT9Aa9HB9cl3TdIy+IqWFjeDM/fRZ9NJhp+
	 jDS/tCxAyEQz6UDO4D7Xi2Q1HQhlGkYePjE1P6fILlk5RUgxY/WFAAlSCpUpulwMQGSd0
	 HFzVL9g2HwwDgtXDV+P5cjKuVYIY8wHfFJ1vm1AbtteoYgy0+0enlUXfs8AhBmrYmlYyk
	 KHSmSVbWdRnY2xJLTTN35LBG3l2G3wLcyUB2xtOJ+K+N2d8eBWK1WeNcGLghLmeJyAMHO
	 mIL4XgCvm51c2g2zx7BElJP9uAG3p4W4jlion5VNWvYXLdcLjTj05hAmrFXAyiPV45A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V8VV79I/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB023606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8VV79I/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CE11F000C5;
	Tue, 17 Nov 2026 23:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956606;
	bh=yTa8tr00Aya6LjONeOTwLFTfT6QwJT3MWJsxa7F9gFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8VV79I/nRdEVUZv/vEe18HWOTaxCDYzXIxYGLZOggDw+aFi4D1JsvdPW6AF+uKXM
	 fObEsuwZQANCFwsZbK04//WGrErSh3ujVjXjCQTnP8cDLckVIIkT18cZy6wP2iIzgu
	 4fFyT4gd2PQrt6JnUwIs0gkjHIcApuqlqwUk5d+xWLZ/00qhGNGpIPlbvZFDAUx6FT
	 ipdlIuE+AEJJIBECRpB2s2VXDfGPixO39lgEPjPRpl+O1/NkUICjd2faZxg2QaT/Ci
	 aj2XqU8/WhuAzk3vqRMbkCUb0YN8T1ewtOklSOSuxWA9RrPXAyD9Z2QeugJuBjZBY/
	 xVk3t6pEqVaeA==
Message-ID: <sashiko-outbox-219773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/6] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-1-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-1-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:03:26 +0000
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-submit-dw-=
dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com?part=3D1

