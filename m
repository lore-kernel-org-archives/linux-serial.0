Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794414F70
	for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788080752; cv=none; b=QyPji3ODNoJCkt1V13LGO23urq0qh4FnOlxgeeZV5jLFDR+yfVmFgNulvr3DLXUgUHUyQ4jUDFvhkm+C86lMO8LDd+nJm4ZzfivLMX2Sg/p2Iz6ZzLGvvc1UpSi3Gh5uQMWUlUCR4Ec+/HCt4SekqlN0DN9kbz15SKo4bovJ9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788080752; c=relaxed/simple;
	bh=bRu8MAyWQBL9/fWcs2oCr1eSFrh56Xi3ykvJKxG8/hE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKYbwLPAQstiX/QsgMbCC1tjlrliTp1784NTrBIr4fFVrooT7/8beddzNEw+reJLT+9RK4hg2ajpza3JOgatV5Mxg6dBSSDQeZjO4tKntjwVdN0D6JHyU/p5jEuQ/yflnpUg2pyO8Ryxh3FV7bdNw3lraR/74KV2dQ8oFTGDf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUpkjaVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUpkjaVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EC31F000E9;
	Sun, 30 Aug 2026 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788080750;
	bh=iweLc+71aXdADfc0PNhpoO+0b/RhBMIBTCeu2Ol1Zeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUpkjaVkRBVvJNyqvEbOw3lCqj5u/H14IVD/+kF9knN78Y27eV0fi6gegLtQFjWam
	 SP104fCIM1ySYyQejcmwgxf4KDnf9h8sByZhQ9Qq29KEn6puiW0U7mDgyfc0uzTqUs
	 DvT/esySUQxEtL7fBzoeCnghZ5dS8NGqBKmHpXpl87Q4TgEITExPMKMG9QjkHeDdh/
	 82C6HcOtE87j7yzMwqWLbvCnVm5t1XglfqkzeVuyhouilPo9ecepT1nD1kEK3nfbyb
	 KNXPnIITg0peaSh7p36FlqtGDm9rqxVkKHil0DZ8vB44FWjB9F3EG23RAWnv//ACoQ
	 GzaCDPI9Dr3Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: msm: select PM_OPP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Sinyavin" <sinyavin@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260830085340.2542624-1-sinyavin@gmail.com>
References: <20260830085340.2542624-1-sinyavin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 09:05:50 +0000
Message-Id: <20260830090550.79EC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Scatterlist DMA length is accessed after the scatterlist is unmapp=
ed, leading to possible underflow and FIFO corruption.
- [High] The driver unconditionally ignores the return value of clk_prepare=
_enable(), which can cause a synchronous external abort if the clock fails =
to enable.
--

commit 2cb7eaaedfaf012a0738d9fb2147009502a57d43
Author: Dmitry Sinyavin <sinyavin@gmail.com>

serial: msm: select PM_OPP

Commit 173ebdedcd84 made the MSM serial driver unconditionally configure
the core clock through the OPP framework during probe. This commit selects
PM_OPP to keep minimal configurations functional when CONFIG_PM_OPP is
disabled.

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index cf7dba473b203..bf680d22199b1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -904,6 +904,7 @@ config SERIAL_JSM
>  config SERIAL_MSM
>  	tristate "MSM on-chip serial port support"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	select PM_OPP
>  	select SERIAL_CORE
> =20
>  config SERIAL_MSM_CONSOLE

While reviewing this patch, I noticed a few regressions in the
msm_serial driver itself:

drivers/tty/serial/msm_serial.c:msm_complete_tx_dma() {
...
	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
...
	count =3D sg_dma_len(&dma->tx_sg) - state.residue;
	uart_xmit_advance(port, count);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code underflow the
count and corrupt the TTY ring buffer?

The msm_complete_tx_dma() function unconditionally reads
sg_dma_len(&dma->tx_sg) immediately after calling dma_unmap_sg(&dma->tx_sg).

On architectures where CONFIG_DMA_API_DEBUG or SWIOTLB invalidates SG
entries by setting the length to 0, sg_dma_len() evaluates to 0.

Since state.residue can be non-zero and count is unsigned, wouldn't
count =3D 0 - state.residue underflow to a massive value and advance the
pointer out of bounds?


drivers/tty/serial/msm_serial.c:msm_init_clock() {
...
	clk_prepare_enable(msm_port->clk);
	clk_prepare_enable(msm_port->pclk);
	msm_serial_set_mnd_regs(port);
...
}

[Severity: High]
This is a pre-existing issue, but can this cause a synchronous external
abort if the clock fails to enable?

The msm_init_clock() function calls clk_prepare_enable() but does not
check the return value.

If the clock subsystem fails to enable the clock, execution proceeds
directly to msm_serial_set_mnd_regs(), which performs MMIO register
writes to the unclocked peripheral.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830085340.2542=
624-1-sinyavin@gmail.com?part=3D1
