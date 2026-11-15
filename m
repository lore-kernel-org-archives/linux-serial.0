Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727988;
	b=A192YyzGwDqczzLCgzQFpP8tp7BBZDuaE8fdictM8iqz1knHpZzOa78ug2uliBC13EVo
	 tSVMnuBlKPMimdLSAHFYNWGwoqWB+fSzhwRaKttxixq/dY8Npq7bvm2cOph7Y0mqmmMds
	 oILfQC8j/FO5/PoyqACoEmiSL168BM67W2o0JoDXYKMOQ6xegPzdz2EvRYa3x8kkmz9L6
	 mGFLtLpmtd1ATJFbHDznctfYzSkqiEMg+yg9wzIBcubJokO1l1rmPDNlgB+AwRxiYxGAZ
	 aVrimpfCz4WscUqp+p9LhQGFiIzFZZHPjYofQsF3ZGN10YwAFgKYTPO9pQ25E1eHQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zhf2P5CNF4YkaGTcIc3bOKSn8weAGQ9R/jZBZpXazyw=;
	b=SrY6kBW9MMvyn5DV+k/gZwtvvugtLqShCbu+PF58+/9g1oX3HLPziaA4AfF2Kdury9s4
	 9NHYiyiyNM+AVJ0b7xDENS3MUUjw/zv3rLCfPUF/CEwF2PLxA+pi7qL1NfXarWX6iuncz
	 R2FiE3fJkDsrEpfqCoUA5pp372qbhwrpMZt0F5fLBPLfU/9SD7ANwVUaDVhSIIYiH2cD6
	 rJCEBGCujYnm707hOmBx7dPS01BoQDPyVd8LAaaS4fM64uc1seTWk5DHuD6tlceWGdFJL
	 I8kkjfA8hkdVENvlPs2qnN/18l7b2FkvZIzXtoGkfLh2usbsa2+KX2WWT2qxKcJoxOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMEO6K6f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F89606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMEO6K6f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6895B1F000C4;
	Sun, 15 Nov 2026 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727987;
	bh=Zhf2P5CNF4YkaGTcIc3bOKSn8weAGQ9R/jZBZpXazyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMEO6K6fod5LRu7Cw+CBSXD7J0Fv+1qcTmex/GYll+tFYgK2d22AZjsCbPfsVtxJC
	 nCBmmARfa5GaCFd5RGUH+wcN69r9a2Fx/zToato1W6GLLvcvqVgFhtHjxX00b5bTdF
	 StnFpAfBdkhz5LsLJ2q2yYOeI4Rgd2OB06BTvQE+lCkhdh1ukaHulDjEPVWx7GdQgS
	 P5GRRKIAFBlwiWITaPcuyR85Yts4oDb6KvFn3pI/VjB9U5rsucYI1kPaprpUIO3JS1
	 PfJJbkq7pKC6a6P+R2/Cqb+TA9Gb6SaYDzkiu7Xcp0as8DV+skhMLwC/vKcbvbPRNx
	 tfmJWsRH1Gn9g==
Message-ID: <sashiko-outbox-215263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] dmaengine: dw: Fix XFER bit set, but channel
 not idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-1-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-1-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:33:06 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D1

