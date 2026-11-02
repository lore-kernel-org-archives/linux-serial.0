Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648878;
	b=noXDnhYKxjGA+eZsdf2i0G8LGj+ywrrQx7wc0EvNwrfxl0VEDa9cuId/k/v4a+OVQPFv
	 wiG0XEEIZsNKSZyy47bofw8Bd+k08RwZhO/Pr71mMJAJxacHRYRW0E/2hGu9B0s80LhwB
	 wYa9MHrZvROCT0OkjzdHRvjL4ZMcmBugkSCnTOofXSHGZZpq9ioJCndsinymf11EkyAAA
	 rOLk1TtYSCeB3/bu28on33hyHXLUCRIuR56HjjYVITv/9fo+560aYcNX0PGEg3KKoy0xI
	 2h7mk+nqRz0rtQzIYVpAtX6xq/PICGUcvFdXu7ZbsoT3hWENx4SRL17SV5MMfpdhVtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QI396C4eeXHh6LirLK2qIWr6JDN0fVQDZWqdrgqF4J4=;
	b=ol92Vx0KSJ7Q5iPioeNfUScDq2N1idrIIK3LL1faigb2A9myG3dytyx49oXdID/aRtsQ
	 9Z+xHpqeANnggF8v+Kma+6DOuqlxLs0mGLoCfq+e2kQKPHdL2ifWp3h0giZVed7yx6WDP
	 81+BYOSB3GHk5pGHytV0LqL8Qq6KCB2cfXiwbxPwAYgfxBdchC1988VKNFkyafu7O1M0O
	 FXndYNZ7JV+03e2SrpsIqOi3EixgL1hJoR9F9JhRfi78IYhMOIEcDMChSyGGltFGuN2EX
	 ls85Zr45bW4GmrAcs8x5t7Ux67pq3De5aI4lnzFSBlnNwC2rzohHPvmGqXXzGdxBNQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyMHUrIv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA409606A32E
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyMHUrIv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7001F00A1C;
	Mon,  2 Nov 2026 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648877;
	bh=QI396C4eeXHh6LirLK2qIWr6JDN0fVQDZWqdrgqF4J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyMHUrIvgcPS7r2xSLeOOzvQzM9OFxxEwG7w+bVumwS8YOYeTnj69IkBtR5Mc0yfc
	 Yk+K9Y3U9WfEf0JBb8QVxMCBzn+3/2Q3hCzMxVD0EgZs6QMOcQrDG6Ny4SGEBoxayq
	 p3wjV7IxsMZ/tBPFXUvYv1m7Rci8fcIUb4q4qypOjc50Zdfa3BcTQoAiLU+vgfNAtA
	 DUbFHbAWmB7xjMla0Zw0/nXD4/5xl1panUzcobMW8EygLJFDpmuPSl1UvetYhdEHqB
	 bFkUFWBAE9xvK+eQ+k36SbdmGH1Rpv+ntEwqHFyVO9D3tb7CCk1yVyzSrl4GDFGd+h
	 Hx0RPX2g7CE3Q==
Message-ID: <sashiko-outbox-194021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-10-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-10-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:47:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D10

