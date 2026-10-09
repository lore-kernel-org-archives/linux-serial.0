Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1D47207D;
	Fri,  9 Oct 2026 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529942; cv=none; b=mQVatwxWffZVLksCDlXSuqJ0nG80OpnZI0KmTrZb/3neKPKfziM4ZCm3eGOOc/q8/A8dI7hPfXJg3n4S6oE4Lr0dtTyOjp/7lmrSXIt0W2QeF1UlzlOJUBL2GHH90JbfWxr5tWZTxuQhnaZsNoYsDpD1qokB3T0KaFu0dNIAF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529942; c=relaxed/simple;
	bh=japcjZbozo01Rqts7M84ZrdfBfev7sRXgBI+exvSmYY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XLwyAZMW0+pWgAVpEG+WqossZ2aTiDuqNDKFFm2zkcUzO9tpASSYxGZvvX+L1Q9avMcx27Y5T4Zf4Zdn2KOp+i9hRgz/YO5fhPXin8N51wWZSz3Uha88Ljf1yiNLjEW4wTnKaEncvcZnzoi0OGq0+g2FSb4rgFbqBYeEuL8s3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0o73RSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0o73RSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63ED1F00893;
	Fri,  9 Oct 2026 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791529941;
	bh=r+QwyD3BaUX/un5rmMG2HbcTRXNGB8mQjYJd+n9avmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0o73RSDmjlpszgLKgd0d+/wtXl8Jzk/JvEbOOG+AS61eW9aP+dGGbHyjAYrowJpP
	 NwD42uqOu3ACTWI4tSk+XOzAsBduCKatWWG2P8vCagTpVmgdr1tzRGIsjRh5jLiUkk
	 PTy9dsQxh+o14MgmFJaccgsoEvg0s6m1rG0GuF0ngW2wCthjAfKqbNBWbQlKP4DTTF
	 KYP2jU750jrocPD6EXV/tXrOdjgPQgxKQB3wHAarHWR9hWv/QA2t/6jJvSdG0SrcQj
	 4bd4hw7DaEJQdOyUw6ExbXZFV1ujElTVEgA3Aa53VY1Ds1pYnNKOc0uSrOygk4IyuQ
	 LpILV23OkLRMg==
Message-ID: <sashiko-outbox-164981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] dmaengine: qcom: gpi: Calculate UART TRE count per
 direction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naresh Maramaina" <naresh.maramaina@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261009-add-gpi-dma-support-for-uart-v1-2-c69e728df686@oss.qualcomm.com>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
 <20261009-add-gpi-dma-support-for-uart-v1-2-c69e728df686@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:12:20 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dmaengine: qcom: gpi: endianness bug via u32 cast of config stru=
ct
--

commit cef09069b78a3ad6018236a1002aee6d9919181a
Author: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>

dmaengine: qcom: gpi: Calculate UART TRE count per direction

This commit refactors the TRE-count calculation by moving it into a
protocol-specific helper function. It addresses the fact that UART RX and TX
track configuration updates independently and may require different numbers
of TREs, while aiming to preserve the existing behavior for SPI and I2C.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index fb26a286e5df4..f72b80bf5553c 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1882,6 +1882,35 @@ gpi_create_serial_tre(struct gchan *chan, struct g=
pi_desc *desc,
>  	return tre_idx;
>  }
> =20
> +/* Calculate the number of TREs required for this transfer. */
> +static u32 gpi_get_nr_tre(struct gchan *gchan,
> +			  enum dma_transfer_direction direction)
> +{
> +	const struct gpi_serial_config *serial;
> +	u32 nr_tre =3D MAX_TRE;
> +	u8 set_config =3D true;
> +
> +	switch (gchan->protocol) {
> +	case QCOM_GPI_SPI:
> +	case QCOM_GPI_I2C:
> +		set_config =3D *(u32 *)gchan->config;

[Severity: Medium]
Will this 32-bit pointer cast extract the correct byte on Big Endian
architectures?

Due to Big Endian byte ordering, casting the configuration structure to a
u32 pointer and truncating the result to a u8 will extract the 4th byte in
memory (e.g., data_pol_high for SPI or high_count for I2C) rather than the
1st byte (set_config). This can result in an incorrect TRE count calculatio=
n,
leading to DMA transfer failures, incorrect transfer sizes, or ring buffer
overflows.

While Qualcomm platforms typically run little-endian kernels, the Linux
kernel on ARM/ARM64 can be built with CONFIG_CPU_BIG_ENDIAN, and this driver
lacks a !CPU_BIG_ENDIAN dependency.

Would it be better to use proper struct field access (as done for UART in
this patch) or cast to a u8 pointer to ensure portability across different
architectures?

> +
> +		if (direction =3D=3D DMA_DEV_TO_MEM)
> +			return 1;
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-add-gpi-dm=
a-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com?part=3D2
