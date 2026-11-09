Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197320;
	b=frdSiOww09jjqyCLvsoGLCATFyBdaUAYFwnkKrqsmVh2bu8VxBx7M1nBmZHnkftE60ra
	 KCOXgqRlKplIyLJVn9fZBjOZCJZlV2TMaXYdcPhzRbXsEwXt475CRhvAkTRHL85IH+eP4
	 FqG5SsFSFg+YQxtatjHK0R1DYetPq4J4rTuwJ/P063KMdEOBdul9PiLfYGx8wsm4pOdwq
	 lk3zTZKpkfmbzALJ5RqwK8nl8YZun/As6RBRY+sHiVun2dvDSzJxLFWuqZtrBswaVi2LV
	 AaiL0wEAKjiHJzdsrIkZF8wtR8stjgeulgYFpSUF5eDOWkVH493CueM8KAmopx6r4Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+ioaEFOagDxPyPLTfnqkjCFFliqEpm6SMVeuhejRcbM=;
	b=Ihjh5Sjd3DarUBbWUHURHsdarhs/okNSoFqZyocreyeFGrSawYdpLnQuj9ihp24QVJpk
	 7zKtGHF8QE1E2cuU4HyEYVNXcv9IqBcBtp+YcXAadSCYnuWH23RLBgbDzibo5DWna6IUL
	 vJjswHab3izZOn4Vx0XB1oyNdTRe4/nmvonX8mx73Xw42YEhqyhyG1Qls7B+R5sF4iDQ0
	 YMnbrR7AR0z7KWE+p3i1CgXODHV0vbeoES2b5nPzXe5AifkKb5LYb00zxsPgTF96T3Im9
	 c0R+9goJZO24u6iTm5xxdc/0XR2AfgQSyjl3KahxYjGoebR8iPmlXYGrxVtl0brA2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqjSd1hv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8A606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqjSd1hv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2420C1F0089F;
	Mon,  9 Nov 2026 04:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197320;
	bh=+ioaEFOagDxPyPLTfnqkjCFFliqEpm6SMVeuhejRcbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqjSd1hv+aFLjV8hoxARbEj0gnwWR1ZIFD4uBS1kmoAHrCloq5zWFSSjRsyK/m5Bb
	 CE1ShqVqIyYsJrsGO89G3ckf1qZ+a7auCqc7HRB9Sn0MQNUzkREHpoEf4Toi+GXIz9
	 DFE2RJGsAigYlD8R6lXtJ3Z3PQp+RXKEsNkbkMJjdtF8R4K1KFTBunek3cfwyT/G2J
	 BNFhShdtmQdOL88fImVVYXpgj9UdXJOVof9ddS9p6APGSlSGlx+veddR0B/m2Rdjxq
	 vbU66SnzxhW9Op0p/P0xZLjyIehpmiQf7iQ07NiQGFwWhcXOUVBqVnt0b2kpDmlsO6
	 oWzXlQVXRi/NQ==
Message-ID: <sashiko-outbox-204396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-3-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-3-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:08:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
> completion callback calling it without rx_dma_lock. Shutdown and runtime
> suspend flush RX under rx_dma_lock but without the port lock, allowing
> these paths to overlap the callback's buffer accounting and flip-buffer
> insertion. RX submission and UART interrupt handling also require the
> port lock.
>=20
> Take rx_dma_lock inside the port lock in the completion callback. Hold
> the port lock around the shutdown and runtime-suspend flushes, matching
> the existing interrupt-path lock order. Assert both locks in the common
> completion helper and the port lock at the flush entry point.
>=20
> Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dm=
a_rx_do_complete()")
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D3

