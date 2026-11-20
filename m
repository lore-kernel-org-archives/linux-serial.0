Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205284;
	b=s/oURXbzUp940q8PuERPyzHWyEro1jLvTY5zLRsuTb0O9EaotgYB+sdw38dwxF40pJ25
	 mTO4dembnd1oEONj+b2wu29eU6cc9btg4sDMBPlPOj0kWgMLVbIRUyaLc6+gbQbJ0JdAH
	 nTa7CbINhECUnoLPXybTxMCmGLkhxii3taOA6/B44gdmi2B3hqU4D6oI3fB+rB+3WWGQ1
	 x/BjYmRgimBWutrv2LoB80jslR+OYcQ5wC7hEwjW9T3oyebGTbnm+i/I3x+K5niEsiXTg
	 Ggat/Q4ZVX1zsR2VZsSen91JJPhv3UhTADc4vBP0hI1o28g9UKYQD1UiYL3peiPCGNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0lM3ieMpnh6CRiiFdHHvkgVtEh5qSmuUbRUU+MOQc1U=;
	b=AmncXAmCYB8KJ2SJmIaFmVoZQHllgpgN8Mi0RbFJuznv7jbCkAccDTFX4x3BZLYeH7w9
	 foSW6EwJAiF+FgHPQb1Le55nl03ZV9eSDvsacID/UtZVwdepR+C16WBkbqSqsShKExwAO
	 fVzmwWM1UQ81+9JOGKzBNLyyPpANn8urGI80uobHwDKt72ziP75PotvbsUCh74XPXjPAr
	 uwvJX4OiJJ5ASY6CnNA/hMH78CyubtMJmtptum1yDlYMZ/f5pXEHIyycMt+yQJA0qPmYc
	 vda9NOtHoeLxAL2nSEJIVR0E+3qxSOLJxIq4KS8Zp6YgE+ZlJeZsZN+ZRset7TtrDcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbiHVian;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5403606A320;
	Fri, 20 Nov 2026 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbiHVian
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA921F000E0;
	Fri, 20 Nov 2026 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795205283;
	bh=0lM3ieMpnh6CRiiFdHHvkgVtEh5qSmuUbRUU+MOQc1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbiHVianpJFB9Cn42ovUhDP91XU7uD9qx2Z5GY749cZ8goqybKHJ/vsQxh0E1c9rA
	 BY9JrqVXYqD6kq/HSF6/RGT5nugHg6P/YEsOZOa4Beg8WKV5h/w3oUYbeX20ToE6Sx
	 /LDkoyzqgHQL9jzmz6R6tk7Bm1YhBIB5YZ3+13GqWE4AhUyyaeencpEemjkySiFILa
	 qkHiamzWxfn/jlE9pdDvl4Q3v1QP9a+DZlXs1kz50gp3H8KBTvt6sMe4hh55ow/0HX
	 4bHgJ/axLjxCTtKAd1cPhppG9bE5RhzqtJI5/eiTaRY7aGeLoRQjvMEc+O+Rrp9lrl
	 rKQ5x86UlO/Pw==
Message-ID: <sashiko-outbox-225998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/7] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-4-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
 <20261120-submit-dw-dma-synchronize-v1-v11-4-9b9166bc2cc7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:08:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dmaengine: dw: unnecessary per-channel spinlock in
  dw_dma_tasklet()
--

commit 08af3593b8765b38f061156136ab91bdf9ca8c59
Author: James Hilliard <james.hilliard1@gmail.com>

dmaengine: dw: use virt-dma for descriptor and callback ownership

This commit converts the DesignWare DMA driver to use virt-dma for
transaction queues, cookie completion, callback delivery, and channel
synchronization.

Link: https://lore.kernel.org/r/20240911184710.4207-2-fancer.lancer@gmail.c=
om [1]

> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 3df696e41ff2e..0d2407c6472be 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
[ ... ]
> @@ -431,42 +401,46 @@ static void dwc_handle_error(struct dw_dma *dw, str=
uct dw_dma_chan *dwc)
[ ... ]
>  static void dw_dma_tasklet(struct tasklet_struct *t)
>  {
>  	struct dw_dma *dw =3D from_tasklet(dw, t, tasklet);
>  	struct dw_dma_chan *dwc;
> -	u32 status_xfer;
> -	u32 status_err;
> +	unsigned long flags;
>  	unsigned int i;
> +	u32 status;
> =20
> -	status_xfer =3D dma_readl(dw, RAW.XFER);
> -	status_err =3D dma_readl(dw, RAW.ERROR);
> +	/* Channel release may have drained a polled completion before this run=
. */
> +	if (!dw->in_use)
> +		return;
> =20
> -	dev_vdbg(dw->dma.dev, "%s: status_err=3D%x\n", __func__, status_err);
> +	status =3D dma_readl(dw, RAW.XFER) | dma_readl(dw, RAW.ERROR);
> =20
>  	for (i =3D 0; i < dw->dma.chancnt; i++) {
>  		dwc =3D &dw->chan[i];
> -		if (test_bit(DW_DMA_IS_CYCLIC, &dwc->flags))
> -			dev_vdbg(dw->dma.dev, "Cyclic xfer is not implemented\n");
> -		else if (status_err & (1 << i))
> -			dwc_handle_error(dw, dwc);
> -		else if (status_xfer & (1 << i))
> -			dwc_scan_descriptors(dw, dwc);
> +		spin_lock_irqsave(&dwc->vc.lock, flags);
> +		/* The snapshot selects work; recheck events under the channel lock. */
> +		if (status & dwc->mask)
> +			dwc_handle_channel(dw, dwc);
> +		spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  	}

[Severity: Low]
Should status & dwc->mask be checked before taking dwc->vc.lock?  Both
status and dwc->mask are invariant across the lock, so taking
dwc->vc.lock unconditionally on every channel adds unnecessary lock
contention on idle or unrelated channels during every tasklet run.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-submit-dw-=
dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com?part=3D4
