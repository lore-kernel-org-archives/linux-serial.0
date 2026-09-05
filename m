Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA43E5EF0
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602096; cv=none; b=pk/ho2N09Fs8SQgl4UzLSFz+8VKNOhnu4FA3yGR0Sx3ztR0Ut7O4Y/5s2kbwY0AEEFQfHk6+ng2jwCk8anatvVcjQMs5W16dU+n/ajbXpbr8pAascCew8an5OxU/rEuulTgsea5L6Wz9HAWWTVFBi5VeKuEjYH3vBCC/kj7dOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602096; c=relaxed/simple;
	bh=1AjkQ6BXaSozPVxmK/qZMxj1lGPRevnEvvOL6EtOXLo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JsEMmUjGeVNliMhBFjb1n7USNKFH9AqAUrwBME9+R0iJz/7EotL3ROeQPbbZ73zVrLoCpuXSs95NeopG+VPl+hGZ5AEzI+sFOJTX4HcEo/6VhaYwrYGp34ULvHOpEJAmpbyY8tr+GCQguXU75cc7Wy3AlJjskDdPWHH6HyLhHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=esw+sgqx; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=3lSbPgOU; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="esw+sgqx";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3lSbPgOU"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788602088; bh=+5EY1/ecw6qH8xH7rYe8een
	zuL4OTvImzSj7U5T51WY=; b=esw+sgqx6DMXwP3W7O7YgCaGSmhTuhDLoyDsxUmix3OZ+xP6eE
	O0tWpD18X9oTNYMB1J/WVdEFAci9kaSGRqbQr5XvssuKkBTAhmNJjVo1rXha/xvronfAxG6/5ay
	7XhSQ7/+Cq574LajdWUiM0E9ZC8xPiYYVkiwE9+FDnc78lD9tPF6TyxnDnrAkfL3TtdQBzf6YDQ
	qZ93njxNmgQMi+N3V3xJzrtARiq19DzDIaH4IRGJ0OF6i7g7rzLCLf1ofktGCOJPV+Q4Lp0P2bm
	0GZ77/hHJegV/B5PUabazz1GfNHJFFJkOAn7/sOTD+zsJVIrQ/TVRcN0maxsKBkuiSg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788602088; bh=+5EY1/ecw6qH8xH7rYe8een
	zuL4OTvImzSj7U5T51WY=; b=3lSbPgOU9quhdZVfptE9YcZqLTd2yQUUA2eQgj3Al4EYejBvJ9
	L9mEdoLEoUF8ycN3Qu89bpoiHJuW8phrOqCQ==;
Date: Sat, 05 Sep 2026 10:54:48 +0100
From: Bradley Morgan <brads@mainlining.org>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-serial@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v2 2/5] net: encx24j600: convert to kthread_run_worker
In-Reply-To: <20260905094038.759EB1F00A3D@smtp.kernel.org>
References: <cover.1788513591.git.brads@mainlining.org> <ab6035a1d48109ba93fdb36d15d3306c46ab94b3.1788513591.git.brads@mainlining.org> <20260905094038.759EB1F00A3D@smtp.kernel.org>
Message-ID: <2A074C41-E499-4B41-9BB5-680089A6757A@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 10:40:38 BST, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential
>issue(s) to consider:
>
>Pre-existing issues:
>- [High] Missing state cleanup for `priv->tx_skb` in TX timeout, interface stop, and device removal paths leads to memory leaks, data races, and potential BUG() panics.
>- [High] Hardware memory structures read over SPI are not converted from little-endian to CPU endianness.


Meh. No thanks.

>--
>
>commit d2a821de33aec8b828ff820d968fcd13ce493790
>Author: Bradley Morgan <brads@mainlining.org>
>
>net: encx24j600: convert to kthread_run_worker
>    
>Convert encx24j600 to use kthread_run_worker() instead of the
>deprecated kthread_run(kthread_worker_fn) pattern. The new API sets
>worker->task before the worker starts.
>
>> diff --git a/drivers/net/ethernet/microchip/encx24j600.c
>b/drivers/net/ethernet/microchip/encx24j600.c
>> --- a/drivers/net/ethernet/microchip/encx24j600.c
>> +++ b/drivers/net/ethernet/microchip/encx24j600.c
>> @@ -884,7 +883,7 @@ static netdev_tx_t encx24j600_tx(struct sk_buff
>*skb, struct net_device *dev)
>>  	/* Remember the skb for deferred processing */
>>  	priv->tx_skb = skb;
>>  
>> -	kthread_queue_work(&priv->kworker, &priv->tx_work);
>> +	kthread_queue_work(priv->kworker, &priv->tx_work);
>
>[Severity: High]
>This is a pre-existing issue, but is there a missing state cleanup for
>priv->tx_skb in the TX timeout path?
>
>If a TX timeout occurs, encx24j600_tx_timeout() wakes the queue without
>cleaning up priv->tx_skb or clearing pending TX state. The next TX here
>unconditionally overwrites priv->tx_skb, leaking the previous packet.
>
>Furthermore, a delayed hardware interrupt for the previous packet can
>arrive
>and trigger encx24j600_tx_complete(), which frees the new priv->tx_skb and
>sets it to NULL. When encx24j600_tx_complete() subsequently fires for the
>new packet, it sees priv->tx_skb is NULL and calls BUG():
>
>drivers/net/ethernet/microchip/encx24j600.c:encx24j600_tx_complete() {
>    if (!priv->tx_skb) {
>        BUG();
>        return;
>    }
>...
>
>Alternatively, encx24j600_hw_tx() may run concurrently with the delayed
>interrupt, reading priv->tx_skb->len when it has been set to NULL, causing
>a NULL pointer dereference.
>
>[ ... ]
>
>> @@ -1100,7 +1096,7 @@ static void encx24j600_spi_remove(struct
>spi_device *spi)
>>  	struct encx24j600_priv *priv = dev_get_drvdata(&spi->dev);
>>  
>>  	unregister_netdev(priv->ndev);
>> -	kthread_stop(priv->kworker_task);
>> +	kthread_destroy_worker(priv->kworker);
>>  
>>  	free_netdev(priv->ndev);
>>  }
>
>[Severity: High]
>This is also a pre-existing issue, but does device removal strand the
>un-freed priv->tx_skb?
>
>During driver removal in encx24j600_spi_remove(), the kworker is
>destroyed,
>and then the driver private data is freed without cleaning up
>priv->tx_skb,
>which results in a memory leak.
>
>[Severity: High]
>This is another pre-existing issue, but are the hardware memory structures
>read over SPI properly converted from little-endian to CPU endianness?
>
>The 8-byte Receive Status Vector is read directly from the SPI interface
>into a struct rsv using encx24j600_raw_read() in encx24j600_rx_packets():
>
>encx24j600_raw_read(priv, RRXDATA, (u8 *)&rsv, sizeof(rsv));
>
>However, struct rsv in drivers/net/ethernet/microchip/encx24j600_hw.h uses
>native CPU types without using explicit __le16 and __le32 types:
>
>struct rsv {
>    u16 next_packet;
>    u16 len;
>    u32 rxstat;
>};
>
>On a big-endian system, won't the raw bytes be misinterpreted? For
>example,
>a packet length of 60 (0x003C) would be read as 0x3C00 (15360), which
>exceeds
>MAX_FRAMELEN and causes the packet to be dropped. The corrupted
>next_packet
>pointer would then be written back to the device's ERXTAIL register,
>destroying the receive ring buffer state.
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
