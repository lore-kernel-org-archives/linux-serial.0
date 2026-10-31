Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793404962;
	b=c/7yQZC4/5Wlhlfwq2uNXJ6j/kPP0r8nvUWaWWEyRu3hXK+XowSbTb6OM5fuIjfFaBl7
	 qlcKnhGDx2CJ3fo6qwHswlZGi2+7QPuj5LpliRA1mGI7LmIIrg/HLbUpjOz5TQsU43L0B
	 EYOshnJX6HYHoQJ1DK/2MKp4ke3PmCQ8jYH3LkmNwMMJ3ELgDr50sJHwBMCiKyf67wpty
	 IShOjEmdE7etdYBYr9cB8Jlmk+VktROReNG5lrXsYfpKtD5W0CIHEpOV4+JeztyryuqK6
	 fhkKJf1idvAfvWSBaXEH9h/jHdCtfuouCgUaNa9sS/FHyBD59VNVhh4MWcdgf7k3VaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793404962;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=14Pw+8PJ6RoMXG/WlMSzhtvIys0zzw7oGwyVM87giAM=;
	b=X1jL0dcLYvTM3FTH9s9QYkhDdi6QLtKmVEsuaQDOiMCEVVKJSKjYfxMGxvNLZm+NEPaT
	 H6CAjDo3Bl6LqX+tRJhxWfeNjGvk9xLbWDPj8ZAtdMloSOXOOwp4BVCkYEu3pOjFK1jSt
	 Uiya+cgeBErh2G2UfgsEwhKX3VSX8qZ8gGRl47hvxdyol1APpX9f7FEHiIVVya8Dz9Aw0
	 te6b8Nxazn+v+gegundaQ9fwa6giG/ygfhS9SFlnGac7/jVUUYv1C2dA4mjMU69wNXDLS
	 R/Eevv4iMd0o2qLCjSuPmWdDGKKrQoOH7ypa842TpRBs/xMYHHaNOOVjJs03wtajnfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lsuS2b0r;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C430606A31C
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C430606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lsuS2b0r
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261031000234euoutp025eb70bc4d6e647ade89b9e5d196a77b9~jdE3blU4U2840128401euoutp02O
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:02:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261031000234euoutp025eb70bc4d6e647ade89b9e5d196a77b9~jdE3blU4U2840128401euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793404954;
	bh=14Pw+8PJ6RoMXG/WlMSzhtvIys0zzw7oGwyVM87giAM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lsuS2b0rUxu1tc5HNnLe03lSZ3rQ/TGHwBoXjlg6ygy6nN3H8vfgSqiB9bjoKAT12
	 FC92+/NrazS3reG/b5ziuV3OQ3yd2PRiTsGNW3ESe+m/HKJutdcbOVNnfWRuOw8dyy
	 r2QB4sjGdnmP8hVlUSJK2d6++l44cp6H6m0OK9Zo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261031000233eucas1p23cde07d79b422f6b872173c1182e058c~jdE3FJbD_2311423114eucas1p2u;
	Sat, 31 Oct 2026 00:02:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261031000233eusmtip2599c2648691da4fe9c989b858fe5bdcc~jdE2V6X6O2498924989eusmtip2d;
	Sat, 31 Oct 2026 00:02:33 +0000 (GMT)
Message-ID: <8cd8d4de-2174-4d64-9aa8-f65e47942904@samsung.com>
Date: Sat, 31 Oct 2026 01:02:32 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] tty: serial: samsung: use dmaengine_terminate_sync() in
 release_dma
To: Samarth Narang <samarth.colleges@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261030162334.3000737-1-samarth.colleges@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261031000233eucas1p23cde07d79b422f6b872173c1182e058c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030162739eucas1p18c5a6e164b995c7e15adf4d989577e4c
X-EPHeader: CA
X-CMS-RootMailID: 20261030162739eucas1p18c5a6e164b995c7e15adf4d989577e4c
References: <CGME20261030162739eucas1p18c5a6e164b995c7e15adf4d989577e4c@eucas1p1.samsung.com>
	<20261030162334.3000737-1-samarth.colleges@gmail.com>

On 30.10.2026 17:23, Samarth Narang wrote:
> s3c24xx_serial_release_dma() stops the RX and TX DMA channels using the
> deprecated dmaengine_terminate_all() before unmapping their buffers and
> freeing the RX buffer. Since this does not guarantee that DMA transfers
> or their completion callbacks have finished, the controller may continue
> accessing memory after it has been unmapped or returned to the
> allocator, particularly when the port is shut down while RX DMA is
> active.
>
> Replace dmaengine_terminate_all() with dmaengine_terminate_sync() to
> ensure that outstanding DMA activity is terminated before the buffers
> are released. Both callers of s3c24xx_serial_release_dma() run in
> process context, where synchronous termination is permitted.
>
> Fixes: 62c37eedb74c ("serial: samsung: add dma reqest/release functions")
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
> This issue was identified by a research static analyzer for DMA
> lifecycle ordering and has not been validated on hardware. The patch has
> only been compile-tested on arm64 with W=1.
>
> On Exynos systems, the UART uses PL330, which does not implement a
> device_synchronize callback, so this change follows the DMAengine API
> contract without independently establishing that all hardware activity
> has stopped. The PL330 termination behavior is being raised separately
> with the DMAengine maintainers.
>
> Two related questions outside the scope of this patch:
>
> - s3c24xx_serial_rx_dma_complete() unconditionally re-arms RX DMA,
>   potentially racing with release_dma() and submitting another
>   descriptor after termination. Should shutdown prevent further
>   submissions before terminating the channel?

Yes, this need to be fixed.

> - s3c24xx_serial_stop_rx() calls dmaengine_pause(dma->tx_chan) before
>   checking the RX channel's residue. Should this instead use
>   dma->rx_chan?

Right, definitely that's a bug in current code.


>
>  drivers/tty/serial/samsung_tty.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 640f85e2d..4eeef149b 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1145,7 +1145,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>  	struct s3c24xx_uart_dma	*dma = p->dma;
>  
>  	if (dma->rx_chan) {
> -		dmaengine_terminate_all(dma->rx_chan);
> +		dmaengine_terminate_sync(dma->rx_chan);
>  		dma_unmap_single(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
>  				 dma->rx_size, DMA_FROM_DEVICE);
>  		kfree(dma->rx_buf);
> @@ -1154,7 +1154,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>  	}
>  
>  	if (dma->tx_chan) {
> -		dmaengine_terminate_all(dma->tx_chan);
> +		dmaengine_terminate_sync(dma->tx_chan);
>  		dma_unmap_single(dmaengine_get_dma_device(dma->tx_chan), dma->tx_addr,
>  				 UART_XMIT_SIZE, DMA_TO_DEVICE);
>  		dma_release_channel(dma->tx_chan);
>
> base-commit: 83f32c773255720a661aa45d83e36278135f23f5
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

