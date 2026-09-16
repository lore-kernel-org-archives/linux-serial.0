Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C29381AE7;
	Wed, 16 Sep 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572654; cv=none; b=X2E8r+YpZWZ/tlutld43LrhHrhVXz1KuW2+KYKhEJUwCeQVxmGEOmDReNw2IP1yYDmmjN52W9xrfFzuyStmZVWGeD4yCOmyWJlyIPBeFvoTWf8RerSHMvKZNvNP8FVn9gZwBl50Zww8JjuHspJee9eAXWc+xB3USQSK1QET9y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572654; c=relaxed/simple;
	bh=nxlsQunVz1mZQqRKve3V7U4nPt5q99sDdcL4jsZ6Izw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NqzT3FwGA+ewUkFrDz5BAvSgev0cwn3Jh5GHnvDGcwdUKY3MW5vVhDh7FyLMdN08NRYjIj8WxL5I5SwgsPsixHhdCUpOszIvTqgqdm7C8/YxH0W5utLgg2TzNdqhTU8UYcy65rqvAlR0exSKeiB0gHfq3sr85s5uijLZaD34IoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esK73rYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esK73rYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982411F000FF;
	Wed, 16 Sep 2026 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572646;
	bh=nxlsQunVz1mZQqRKve3V7U4nPt5q99sDdcL4jsZ6Izw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=esK73rYxkcG/qDPD779aaorJTmJjQcyYlRlxGEhjorRIFlMwbFzqe9+zcXC9sQrMS
	 L1PaNzcAAdLQwvgm1IVfAwM/Z40F3VgaFatO60hxkp2oNx37QXGA/RlfO3IaeuHMhx
	 1VqhfJsIdYEKl9UuikAb4I3Ql6j01s30BCc503Vmugotjfwm14jqVpNYBvFqMMEAkg
	 N83zWuztzzJhzQWaoBd57eWH9sjJB24T8TxxyK8njC1GspCRcwLG3XiUNTj8N15HtH
	 +jeuzzP4pa3Rn3bczw1iRWyipGHMQx/CVfPGc3J/mKVDs4Xx8fdaLrGsZ3gCJPxOJD
	 0IbAR8EyZVKcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: fsl_lpuart: use dmaengine_get_dma_device()
 for DMA mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-serial@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260916-lpuart-dma-v1-1-021be5b03e53@nxp.com>
References: <20260916-lpuart-dma-v1-1-021be5b03e53@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:30:46 +0000
Message-Id: <20260916153046.982411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Replace all chan->device->dev references with
> dmaengine_get_dma_device(chan) so that DMA mapping goes through the
> correct device when the DMA controller has per-channel IOMMU domains
> (chan_dma_dev=3Dtrue). Without this, DMA map/unmap/sync bypasses the
> IOMMU context configured by the eDMA driver.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-lpuart-dma=
-v1-1-021be5b03e53@nxp.com?part=3D1

