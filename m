Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313511;
	b=dT7Zi3ComHWdUTdXBFVhM8dOYZbgKo2Oew3Mg5qk+JI79AG3L1diQlVRDtT6yepUeZ+s
	 Tl4wwB/T1AdBDes/TcUYYXVntsYMkmrpn6z4NGxCPDMIIwV2U90oY7MTxu2wP4BKUmRv8
	 bgmRMcg8mo+80v+V73tAdvWsECCQIYjsrVKgHSVAfJzW4Muj4yEplFpkXIQT9ZYSrwDpR
	 xztCa/LUNQTTA3VcvVoALjeTP/WSj0Fd0OwPA0i+lkaKdUb36LY1ElcO7GmjvLkfZq12w
	 U33xCUXqXVKkbYcbkbT/wyzo1T4/EwiAxNS1wmDZlFgHrgGeB9bSjSf7svHL1gRfPQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9+0aq2gNPsGNHUy7t5mO/QXkuZ5QdDD7gcSA0EFYoYo=;
	b=UcimYu6sXV3wnsPERdJjNDvY1/4gsHrMv6xxohwTrs1qUbQefA9QDOz3defWzUozuS1q
	 RoSgCnYd2csvlrBjF6FGTTHPSaQh8Kdc2vGz16tM5ikjmxewMyGZ0lnY6YtbPVAVbRld0
	 t/JCBpePPTZmj4jIIbCg0b5vz9iuaSYYEDEBgn+akhueN7XzvE8lovdreDWo0IWRhijET
	 TH5ARpc9TX1EChyhWiSERoOCstgdoS2rPC1kpwmuMbJ1F6j7Z+2ZjKNMKZSVtA6HfcyqS
	 BS0eomsOgKk9zEGAKFsrXjzk7yI3BT1b/JsMj6GQ64H7wguA4wUWWdY8qd6hXUfjPkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0wvDMCN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E48606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0wvDMCN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3320F1F01816;
	Thu, 29 Oct 2026 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313510;
	bh=9+0aq2gNPsGNHUy7t5mO/QXkuZ5QdDD7gcSA0EFYoYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T0wvDMCNIfbbBSGkTlEjc/yXcumaFVN9QqrB87ecnMgqTQb4LoT9MrlGpY/hbz7/C
	 cmCVMaunRUVCr2e6ziY9G9IB1Mu9m0EqTJNZbVGwAfhpAIBnvwL9kxXMpyZglOXwwZ
	 X57jb5M8DlPv8YhQYTQEa9VvDc0dQXinT64DFQOtCLCIiL9sHLQY9Fv97iHFIXaOdd
	 RWlOYqwtSu22HjDRXQg3X9FqQ7cS8OP4/a8/2Nvzu2EEtYkVPCqm97OWW3iOamNX4O
	 0144FmnqO6uqE29/i9MficWq4WFs+/mFT49uEp2nNXrQO2LX7DVs2xR7EE6/U9/8Wr
	 q2PluoQUY+Kyg==
Message-ID: <sashiko-outbox-190089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-7-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-7-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:38:29 +0000
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
> The DMA transfer status getter can invoke a completion callback from
> dwc_scan_descriptors(). An 8250 RX timeout queries that status while
> holding the UART port lock, and its DMA callback takes the same lock:
>=20
>   serial8250_handle_irq()
>     uart_port_lock_irqsave(port)
>     serial8250_rx_dma_flush()
>       dmaengine_tx_status()
>         dwc_scan_descriptors()
>           dwc_descriptor_free()
>             dma_rx_complete()
>               uart_port_lock_irqsave(port)
>=20
> [ ... ]
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: defer notifications while preserving polled completion and cleanu=
p]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D7

