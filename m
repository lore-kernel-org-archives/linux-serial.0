Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6746AA8C;
	Fri, 25 Sep 2026 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367604; cv=none; b=oYDx84HFMIuQhAyQ+MXIrfyO4abgdOpJkUxgp8KSUdhgMZXkU9wwD1EouTaqXqsmQwSMB0sentDYTaf+0n8zAApPfwzjBHa0O9Bfy5dUJb/QRnTaSjgMy03Dx98MQ2g8/0EqGpIoFhU0BOq9bQsqLEMPgFHVTVBBZWRIwEZNovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367604; c=relaxed/simple;
	bh=HHoxvicqfZA+n2pKkHHOA7vzW00hj15zOu3veVA/Gp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQ1zuhhcZk2jv0TKdgs5KnLpU+Lu29HtadRj80bwSEBVfIHGDIKD/vrE9wV5BumBTRCvSZRsMeTFbMvffyA1f/a01dGlQAojvQoMYvpPFSE4/caL96dEFwlvhuqN8H4i+U+GSYOVE41FKnSMQNY/Wy61RCrBg5tRtdg59IZpjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8YY9oYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8YY9oYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC1A1F000FF;
	Fri, 25 Sep 2026 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367598;
	bh=b01Hf4th/bG4IK5EwrBUNtUAGx8dHBa8rLXmm7+ryHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8YY9oYI1fPfHZRqkxr2oGaz7y+r7i+el2YgT5XmhSjE9coECnpt15BeF+Xrxlhxo
	 ecL1NFGULQYPV924BIhFN2bVxj3mSwOHd3lC+SbHfDGKwRulE0TZln0R1hZGy/rPrQ
	 zzfYYldVCTGmvTy+XhQkMxcLRg9lJuSkQ60hmTpPF2q3ovx7/X8lJAYtclhdUig23i
	 Vlo9+DJO59fwfD7+5+UrkzOt33r9ZT8paeN+6vehtSS5EditSHxxKjAw4EzeapnTX4
	 Mb3PQm+WtaLDFRoHhnLUrDn22ZWgAM5A92zD/qmv4U/GGL8P36b0w8ZmcJ7s1RRG3G
	 J2vEhqBZo5L5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: use dmaengine_get_dma_device() instead of
 chan->device->dev
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-serial@vger.kernel.org
In-Reply-To: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
References: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:19:57 +0000
Message-Id: <20260925201958.2FC1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma-mapping: asymmetric dma_map_single/unmap pair in pl011
--

commit fb77536d75ed603638aebc851f73960ddf8efe10
Author: Frank Li <Frank.Li@nxp.com>

serial: use dmaengine_get_dma_device() instead of chan->device->dev

This commit replaces direct access to chan->device->dev with the
dmaengine_get_dma_device() API across multiple serial drivers. This correct=
ly
handles per-channel IOMMU mappings and prepares for making DMA engine
provider structures private.

Link: https://lore.kernel.org/imx/67966b47-22cb-4b07-80c7-2044f557dbcb@app.=
fastmail.com/

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index c4824c201e1c3..86729ddbdadc8 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c

[ ... ]

> @@ -609,7 +609,7 @@ static void pl011_dma_tx_callback(void *data)
> =20
>  	uart_port_lock_irqsave(&uap->port, &flags);
>  	if (uap->dmatx.queued)
> -		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
> +		dma_unmap_single(dmaengine_get_dma_device(dmatx->chan), dmatx->dma,

[Severity: High]
Does this change create an asymmetric map/unmap pair in the PL011 driver?

By updating pl011_dma_tx_callback() to use dmaengine_get_dma_device() for t=
he
unmap operation, it appears to no longer match the map operation in
pl011_dma_tx_refill() which was not updated in this patch:

drivers/tty/serial/amba-pl011.c:pl011_dma_tx_refill() {
    ...
	dmatx->dma =3D dma_map_single(dma_dev->dev, dmatx->buf, count,
				    DMA_TO_DEVICE);
    ...
}

The DMA API requires the exact same device pointer to be used for both
mapping and unmapping. On platforms where the DMA engine provides per-chann=
el
devices, dmaengine_get_dma_device() will return a different device pointer
than the raw device pointer used during mapping.

Could this break DMA tracking or cause IOMMU faults during standard TX
operations? Should the map operation in pl011_dma_tx_refill() be updated to
use the new API as well?

>  				 dmatx->len, DMA_TO_DEVICE);
> =20
>  	dmacr =3D uap->dmacr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925200850.1678=
179-1-Frank.Li@oss.nxp.com?part=3D1
