Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12A471D1F;
	Fri,  9 Oct 2026 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529978; cv=none; b=QZ4wzxJmAmvHL+Pn8/nHGt1goImKmJn1ar5uSk8ZWseeq/kOpKiv9I1HzG6f+3HpAfiYW2EY0dwoLCIaBH8ZfMKg8K2qGGX4uoG45ZMrE6K9GPysECIPeYceuwQ2YptTWs+d5eGM9Idoh6tFZPnmmh6vnjoevK5gN/P9m81fj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529978; c=relaxed/simple;
	bh=AOgT1zg82M0CaVka0kvO9QHKm1hcCgEZaJLo51q0Zzw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CBB2S6ue5VQjXBi33YT8iI6xNOrMWPL8m9o3W5flHiMpwUXmrSHLbcTWzTAyrfKa5Z9TCn0iTeRF5UwYlsNTO8k8vR6D1wVWhK6ptXDXCmNQZeuj1Zs2pvxT+faRAAOjXzZU6gAHRSaKCBr/ZEoMwOB9OC4o3eaUdcLksmS3l1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZlxZeXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZlxZeXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9FC1F00893;
	Fri,  9 Oct 2026 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791529977;
	bh=fany1NLs7MlcZ+lUrhxz/L/jhyQCwRmA8MMlgFMA71I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZlxZeXYA8l8Z8Kp/wSOzeAsKlCbSOJxPisA5WREm2MVMgFmdeyiuXmYZ9Ry+Ad3V
	 pnBK0+rnWfivqTM4wKLVacAcYHzJiI7pFzw5CYRjsx+S1ZHEcEsFaNQWp+EINU5onU
	 RjuhzaQTPJz/WtqBVCQKYmhGODPM32p1KRoCDlSg7+Q8y5YnmnEDB4ns+2xXR7NH6m
	 3yZfoUrXwsaCvfF642rl3KM2yFaN/pfgVvrd9oiKTDEOzrMvKd5aC+JMHhgTnzakbx
	 Reu4Hy7hklxHtAdErUyXAnMojru8tY6k8UrDrFBRQvbCmHbMzbI/sZobCec31IMqsj
	 HzLw9oznr20vA==
Message-ID: <sashiko-outbox-164982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dmaengine: qcom: gpi: Add UART transfer support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naresh Maramaina" <naresh.maramaina@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20261009-add-gpi-dma-support-for-uart-v1-1-c69e728df686@oss.qualcomm.com>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
 <20261009-add-gpi-dma-support-for-uart-v1-1-c69e728df686@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:12:56 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dmaengine: qcom: gpi: incorrect nr_tre calculation for UART transf=
ers
--

commit 8dcb83edc68c0730c98ffc9a0682fbaf3ad23874
Author: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>

dmaengine: qcom: gpi: Add UART transfer support

The GPI DMA driver currently supports TRE construction for SPI and I2C
clients, but not for UART clients. This adds the UART CONFIG0 and GO TRE
definitions and exposes a UART peripheral configuration structure.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
[ ... ]
> @@ -1841,11 +1930,17 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
>  		return NULL;
> =20
>  	/* create TREs for xfer */
> -	if (gchan->protocol =3D=3D QCOM_GPI_SPI) {
> +	switch (gchan->protocol) {
> +	case QCOM_GPI_SPI:
>  		i =3D gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
> -	} else if (gchan->protocol =3D=3D QCOM_GPI_I2C) {
> +		break;
> +	case QCOM_GPI_I2C:
>  		i =3D gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
> -	} else {
> +		break;
> +	case QCOM_GPI_UART:
> +		i =3D gpi_create_serial_tre(gchan, gpi_desc, sgl, direction);

[Severity: High]
Does this new uart creation path safely interact with the existing nr_tre
calculation earlier in gpi_prep_slave_sg()?

Earlier in gpi_prep_slave_sg(), nr_tre is calculated like this:

	nr_tre =3D 3;
	set_config =3D *(u32 *)gchan->config;
	if (!set_config)
		nr_tre =3D 2;
	if (direction =3D=3D DMA_DEV_TO_MEM) /* rx */
		nr_tre =3D 1;

For uart, gchan->config points to a struct gpi_serial_config, where the fir=
st
field is rx_stale_timeout. Reading *(u32 *)gchan->config will use
rx_stale_timeout instead of a boolean configuration flag, which might cause
nr_tre to be miscalculated.

Additionally, the earlier code forces nr_tre =3D 1 for DMA_DEV_TO_MEM,
but gpi_create_serial_tre() appears to generate up to 3 transfer elements.

Could this mismatch cause the ring space safeguard (if (nr < nr_tre)) to pa=
ss
incorrectly, leading to dropped elements or a hardware ring overflow?

Note: I see this was successfully resolved in a follow-up commit upstream
"dmaengine: qcom: gpi: Calculate UART TRE count per direction", but I am
highlighting it here as part of the review of this specific patch.

> +		break;
> +	default:
>  		dev_err(dev, "invalid peripheral: %d\n", gchan->protocol);
>  		kfree(gpi_desc);
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-add-gpi-dm=
a-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com?part=3D1
