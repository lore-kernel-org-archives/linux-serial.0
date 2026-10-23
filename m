Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773609;
	b=KVBwvprflptNr69Ud/98MxxOij015Z+XZoBs1V+2sMVzUSW/9vYrhH4FuMW+JtC9iYSL
	 xxCCm+0hlCVQPQ2ysBgajls+YXK4gy+brzGD431f/usIey9kuWpHr4lRRRYBVZUxa6uvz
	 n4ganadq/pzEjtG0/w5D2MJ7CjcrN0m2uV6pHy4F7JEpgkHmCJu+01Q4uxz8ySAoSqmhf
	 G6LqdsmhpwDdXOWvxCjNBME8seQosqTrI4Z5Gx2ow7KeOxu8ZG0UUSamZdKanPQt6871o
	 KY8MZ4C8V2ZCrreUE1SCqmqt6e0d/7Pp4yFsHNmx/JxtAIjBQ0Qi30IC/HsjfnrG0Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fJx0DYOP8e4WfVqRCXD1s79YwLwRs0utHkgkfsT5hko=;
	b=02tQKe4dDUqKBrJxO+Xj6SLT/GgYBIkr5zPeBe+tfka7DWMRG+DgORncIhRECQNeGiFx
	 NCijIDeC+b2FminTAZ8BkHrLI8hOcAsaWiFZRSxHZTrSPO6QeTrB3Rb7pEyP03YlI5VJg
	 nlDdreT1eWW2Rcy/gHlZ24qkhRZiQLWIhdwbeJ+u7iAFXSVpoTYxYDpuR30H/o2UeYZRf
	 TPFgpS3QLJg7chEg58/lKmoBeS/SVCFaVBLm3DOeRHfz8BbgSkofRztHfDIAAtQ6M9sir
	 OQTKdck4S1/9rur1QZb7mFKKrX1FkAhf0Ih2LifJvYyFbgHjY4beXBMy2vw/lCwRuwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9u1lBD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50763606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9u1lBD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077561F01825;
	Fri, 23 Oct 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773609;
	bh=fJx0DYOP8e4WfVqRCXD1s79YwLwRs0utHkgkfsT5hko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9u1lBD4YNmvEdkIUQ/GNgD2kZ4fGmmsVfZVUPRpmsdgL5PCy3OC90nVSmQC4svVy
	 7GaEbUaVXfuZOegUFUk/wfPRevx4rAhFvTcj/p8+GVuxAb5eyZ161wJ0D7RD2RKe3n
	 1/xu21sH1azse2639MEzTThQydm/zxCYBrnLnG5nNg0Tree69MMcWRtS/BkO+of8bV
	 s23t5FKHHb6eeLUp26gA7Bt0fr59Ti7RkurEAFLCWNC96LEYZt7HAcos3qeT93tHQC
	 N4HpN7DGE1h6PieohJWZ5mEuYamzl0OSDlP8am2n7mOm1uMIoCsF3cCRE3DTm3AoLi
	 ZCqwq4QdI5D2A==
Message-ID: <sashiko-outbox-182959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-3-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-3-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:40:08 +0000
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
>           dwc_descriptor_complete()
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-dw-=
dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com?part=3D3

