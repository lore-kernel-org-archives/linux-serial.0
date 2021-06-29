Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E3BC11F66
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 08:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1CB61DDE
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 08:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhF2Idu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:33:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40071 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhF2Idu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 04:33:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210629083121euoutp02e3803c132bbd7f5c184823d688ea11d0~NAGbDlUIp0529905299euoutp023
        for <linux-serial@vger.kernel.org>; Tue, 29 Jun 2021 08:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210629083121euoutp02e3803c132bbd7f5c184823d688ea11d0~NAGbDlUIp0529905299euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624955481;
        bh=VamTEb6C05zcvfh5//be2CVF5D6J6NWIMlYtTdNeS18=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bSrKWWjzf+Od6z+2y6jhdSVktnhkH5uE9r8A9Is+ZmvOUr2unftEEPOWAkHRmf2N5
         dm90j0eV37TeoPJDDrlDYbxK7jN+FOD4WEjykqHs3HbMk/EzhvGvzAzqu0Vn5Fol7N
         V4RGhYVbf8diRdZ3z2PP5Wy54HuczHUEqoOov8+4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210629083121eucas1p2060feb2bf53ed29a433ff210184ba797~NAGaytwO22990729907eucas1p2F;
        Tue, 29 Jun 2021 08:31:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DC.ED.45756.95ADAD06; Tue, 29
        Jun 2021 09:31:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210629083120eucas1p143ff0e66c1ee4130c798a6310dfdabe3~NAGaBEBU30826708267eucas1p1z;
        Tue, 29 Jun 2021 08:31:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210629083120eusmtrp1761995fa0a1700d97281920e1d5be1d1~NAGaASe-a2764027640eusmtrp1Z;
        Tue, 29 Jun 2021 08:31:20 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-25-60dada594c56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.4B.20981.85ADAD06; Tue, 29
        Jun 2021 09:31:20 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210629083120eusmtip15ce239aade0b307928e894049dc237bd~NAGZTg_MC0696506965eusmtip1M;
        Tue, 29 Jun 2021 08:31:19 +0000 (GMT)
Subject: Re: [PATCH v5] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>,
        krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, robin.murphy@arm.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2f3a7337-6349-0638-b126-183a57d0da6c@samsung.com>
Date:   Tue, 29 Jun 2021 10:31:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629045902.48912-1-m.shams@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7qRt24lGFx5IGtx4P1BFosH87ax
        WTQvXs9m8W6ujMXGtz+YLDY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7xcEPT1gduD3WzFvD
        6DGroZfNY9OqTjaP/XPXsHtsXlLv0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkzVreyFlw1
        rphydAFjA+M8rS5GTg4JAROJ7z3HmLsYuTiEBFYwSjy8uYwJJCEk8IVR4vQCMYjEZ0aJma3X
        mWA6dm15BtWxnFGi7cApRgjnI6PE28MHWUCqhAXcJZZ8esUOYosI1ElcbdjBBlLELHCFUWLO
        1rNgRWwChhJdb7vYQGxeATuJV/NPgMVZBFQlDl3YBxYXFUiWeD9vBitEjaDEyZlPwGo4BSwl
        /jZtAzuJWUBeYvvbOcwQtrjErSfzmUCWSQi0c0qcX3WeEeJuF4mtE3ZB2cISr45vYYewZSRO
        T+5hgWhoBobAubXsEE4Po8TlphlQHdYSd879AjqJA2iFpsT6XfoQYUeJhqn32UHCEgJ8Ejfe
        CkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYevHCJeQKj0iwkr81C8s4sJO/MQti7gJFlFaN4
        amlxbnpqsWFearlecWJucWleul5yfu4mRmD6Ov3v+KcdjHNffdQ7xMjEwXiIUYKDWUmE923e
        rQQh3pTEyqrUovz4otKc1OJDjNIcLErivKtmr4kXEkhPLEnNTk0tSC2CyTJxcEo1MBXONrgl
        eOLuzrYVPJIa7Akpf3+ox95K/v2K88O+71+sLC16M3g7+e+sk3papMja18jGqxH6WvPz9LXK
        i/2+OZhfX2/+dFO1aL3u+ZLvJkVNLE/yr39crzWryu/k4Z3Xj13rPr+7w9D/5bp+2/R4m88Z
        iwJTCvoYvm7XcMm20/5/U1ZK+8NBzS2efLYfGyz8paq1psTutP8Sztkl5vbpvOTaD+8dfLsN
        XEO+3NOwnX/DzyV1usOdR/c5Wj8G1Pd9Tv+3p1/AT9jwantdbt7bjHkOO/+2ZjWfyyj9d2+/
        G2cYv7S3YvweXaNPp5pebOEPcTV43Dt775xrzgtND6/JfNHT7t5x9bih0Aeuw6oVSizFGYmG
        WsxFxYkA1GwROs4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7oRt24lGBy7qW5x4P1BFosH87ax
        WTQvXs9m8W6ujMXGtz+YLDY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7xcEPT1gduD3WzFvD
        6DGroZfNY9OqTjaP/XPXsHtsXlLv0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkzVreyFlw1rphydAFjA+M8rS5GTg4JAROJ
        XVueMXcxcnEICSxllJg/exMbREJG4uS0BlYIW1jiz7UusLiQwHtGiSf3ckFsYQF3iSWfXrGD
        2CICdRKn709hBRnELHCFUaL57nIWiKk9jBIf5p1iAaliEzCU6HoLMYlXwE7i1fwTYHEWAVWJ
        Qxf2gcVFBZIlfq5vh6oRlDg58wlYDaeApcTfpm1MIDazgJnEvM0PmSFseYntb+dA2eISt57M
        Z5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmC8bjv2c8sO
        xpWvPuodYmTiYDzEKMHBrCTC+zbvVoIQb0piZVVqUX58UWlOavEhRlOgfyYyS4km5wMTRl5J
        vKGZgamhiZmlgamlmbGSOK/JkTXxQgLpiSWp2ampBalFMH1MHJxSDUw8rOv1EjnqTqpN6r0i
        8HR96aOTk7ZO8tHS7265xhbzTvui+Yf6K3NkTJon5CaobZ+80X7JIeHzHq4lP1Yo6xsoC9S8
        /MU/ee+Lly0CVx4WqUVESt5P36y548Rjvyj+Q1OllaUz2BQSpoZzvHANcW2L1nsal/akyELC
        Uvr7IpcYo4/RG5d1L9KQuxGYUbF93yv9hqsltxWuJzk5BplJrZiTa6Z/L3iq+97O2es6Hz/P
        CPDkn5IR4sN3/9OL3+8dOKfoPq7J991otF1oq/r2l7zeT/jElH5ZTP5w5IDp+7zO0OMrRT4G
        1W+a3Mrg7OL06e/cnKPnuGbbqKwPXBlz5f6ra0LvJeM1Db2PcPnNuqbEUpyRaKjFXFScCAC4
        9TstYAMAAA==
X-CMS-MailID: 20210629083120eucas1p143ff0e66c1ee4130c798a6310dfdabe3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd
References: <CGME20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd@epcas5p4.samsung.com>
        <20210629045902.48912-1-m.shams@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29.06.2021 06:59, Tamseel Shams wrote:
> When DMA is used for TX and RX by serial driver, it should
> pass the DMA device pointer to DMA API instead of UART device
> pointer. DMA device should be used for DMA API because only
> the DMA device is aware of how the device connects to the memory.
> There might be an extra level of address translation due to a
> SMMU attached to the DMA device. When serial device is used for
> DMA API, the DMA API will have no clue of the SMMU attached to
> the DMA device.
>
> This patch is necessary to fix the SMMU page faults
> which is observed when a DMA(with SMMU enabled) is attached
> to UART for transfer.
>
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Changes since v1:
> 1. Rebased the patch on "tty-next" branch of TTY driver tree
>
> Changes since v2:
> 1. Updated the commit message.
> 2. Changed the comment description
>
> Changes since v3:
> 1. Removed the null pointer check for "dma", "dma->tx_chan" and
> "dma->rx_chan" and instead sending DMA device pointer while calling
> DMA API.
>
> Changes since v4:
> 1. Fixed the alignments of arguments.
>
>   drivers/tty/serial/samsung_tty.c | 46 +++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..0cf4dfe77c32 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -305,8 +305,9 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>   		dmaengine_pause(dma->tx_chan);
>   		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>   		dmaengine_terminate_all(dma->tx_chan);
> -		dma_sync_single_for_cpu(ourport->port.dev,
> -			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
> +		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
> +					dma->tx_transfer_addr, dma->tx_size,
> +					DMA_TO_DEVICE);
>   		async_tx_ack(dma->tx_desc);
>   		count = dma->tx_bytes_requested - state.residue;
>   		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
> @@ -338,8 +339,9 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>   	count = dma->tx_bytes_requested - state.residue;
>   	async_tx_ack(dma->tx_desc);
>   
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> -				dma->tx_size, DMA_TO_DEVICE);
> +	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
> +				dma->tx_transfer_addr, dma->tx_size,
> +				DMA_TO_DEVICE);
>   
>   	spin_lock_irqsave(&port->lock, flags);
>   
> @@ -443,8 +445,9 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>   	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
>   	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
>   
> -	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
> -				dma->tx_size, DMA_TO_DEVICE);
> +	dma_sync_single_for_device(dma->tx_chan->device->dev,
> +				   dma->tx_transfer_addr, dma->tx_size,
> +				   DMA_TO_DEVICE);
>   
>   	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
>   				dma->tx_transfer_addr, dma->tx_size,
> @@ -515,7 +518,7 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
>   	if (!count)
>   		return;
>   
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> +	dma_sync_single_for_cpu(dma->rx_chan->device->dev, dma->rx_addr,
>   				dma->rx_size, DMA_FROM_DEVICE);
>   
>   	ourport->port.icount.rx += count;
> @@ -636,8 +639,8 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
>   {
>   	struct s3c24xx_uart_dma *dma = ourport->dma;
>   
> -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> -				dma->rx_size, DMA_FROM_DEVICE);
> +	dma_sync_single_for_device(dma->rx_chan->device->dev, dma->rx_addr,
> +				   dma->rx_size, DMA_FROM_DEVICE);
>   
>   	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
>   				dma->rx_addr, dma->rx_size, DMA_DEV_TO_MEM,
> @@ -1102,18 +1105,19 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   		goto err_release_tx;
>   	}
>   
> -	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
> -				dma->rx_size, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
> +	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
> +				      dma->rx_size, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dma->rx_chan->device->dev, dma->rx_addr)) {
>   		reason = "DMA mapping error for RX buffer";
>   		ret = -EIO;
>   		goto err_free_rx;
>   	}
>   
>   	/* TX buffer */
> -	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
> -				UART_XMIT_SIZE, DMA_TO_DEVICE);
> -	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
> +	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
> +				      p->port.state->xmit.buf, UART_XMIT_SIZE,
> +				      DMA_TO_DEVICE);
> +	if (dma_mapping_error(dma->tx_chan->device->dev, dma->tx_addr)) {
>   		reason = "DMA mapping error for TX buffer";
>   		ret = -EIO;
>   		goto err_unmap_rx;
> @@ -1122,8 +1126,8 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   	return 0;
>   
>   err_unmap_rx:
> -	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
> -			 DMA_FROM_DEVICE);
> +	dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
> +			 dma->rx_size, DMA_FROM_DEVICE);
>   err_free_rx:
>   	kfree(dma->rx_buf);
>   err_release_tx:
> @@ -1142,8 +1146,8 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>   
>   	if (dma->rx_chan) {
>   		dmaengine_terminate_all(dma->rx_chan);
> -		dma_unmap_single(p->port.dev, dma->rx_addr,
> -				dma->rx_size, DMA_FROM_DEVICE);
> +		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
> +				 dma->rx_size, DMA_FROM_DEVICE);
>   		kfree(dma->rx_buf);
>   		dma_release_channel(dma->rx_chan);
>   		dma->rx_chan = NULL;
> @@ -1151,8 +1155,8 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>   
>   	if (dma->tx_chan) {
>   		dmaengine_terminate_all(dma->tx_chan);
> -		dma_unmap_single(p->port.dev, dma->tx_addr,
> -				UART_XMIT_SIZE, DMA_TO_DEVICE);
> +		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
> +				 UART_XMIT_SIZE, DMA_TO_DEVICE);
>   		dma_release_channel(dma->tx_chan);
>   		dma->tx_chan = NULL;
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

