Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3039394793
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601240; cv=none; b=nqcfaBzG0imVdsNFVLJqrMDPQxXhRVHJpiRja/zOsEYml6i96GFliKoh2XiA67Xku4I358JjgdO5Ayxl57yh7oZGhAGRJO5e/ahRNlN6C+biNlQG+tgK///Q4JntcIfwbsjGqLHnVkRJgBie9W9j3AnNqEV4+sUzfhNy9nWGKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601240; c=relaxed/simple;
	bh=t9PQhDd1O9N+5v3x0QMJbkzp+Fij6DwQKE6aUxO1gBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCHWMOfn31NVvgVXoWseWRsiurkr5vtaK98Kr6cRg+zUyf/la3gM6NJB80w1sEWmqdQdexd3prm4Owo1TdByJVxjhokEqYKccXiiruM0KtM2sw/aaNFR9u9IcA5Y294QQ84C7+fygPDjJjlogW5jkfYhhvyZqEOo45ElTYicJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0B2oQk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0B2oQk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759EB1F00A3D;
	Sat,  5 Sep 2026 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788601238;
	bh=FqyeJkJERLEY3l2wNEG0jZiOccQZar0ocgb4F7/NzDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0B2oQk2trTI6tpjKs4b/CoKUCKf+YP5Cc9tOpRUov1h633aSnfqpjwdSYQSwaY8A
	 4t1kpyK/XkNNSCo9QW2hzjdDelB1GDUhsY7FBiJ8xRcB4ZF0kGloyjE/9aZiPt93mw
	 IgQBQpERw1RtF5iQMOdUAZCScMvJ6hSJIEyOevDKxtL4ohMLcnEiVBcPJM3+LIvzVw
	 mAq7GHZVsRwV2TwOJuU4Iran/6RVlWmdFOpp+8W4dHVzi3F3AcG3e2kuU0RhmaZTiT
	 gt4vbZtpDfeYI/zbULE83+/1Yo7BCneQE9POQo91nTwRVsDXkVM/PVW3YpjjsTA1X7
	 5kx1ix5XXlwtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] net: encx24j600: convert to kthread_run_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: linux-serial@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <ab6035a1d48109ba93fdb36d15d3306c46ab94b3.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
 <ab6035a1d48109ba93fdb36d15d3306c46ab94b3.1788513591.git.brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:40:38 +0000
Message-Id: <20260905094038.759EB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing state cleanup for `priv->tx_skb` in TX timeout, interface =
stop, and device removal paths leads to memory leaks, data races, and poten=
tial BUG() panics.
- [High] Hardware memory structures read over SPI are not converted from li=
ttle-endian to CPU endianness.
--

commit d2a821de33aec8b828ff820d968fcd13ce493790
Author: Bradley Morgan <brads@mainlining.org>

net: encx24j600: convert to kthread_run_worker
   =20
Convert encx24j600 to use kthread_run_worker() instead of the
deprecated kthread_run(kthread_worker_fn) pattern. The new API sets
worker->task before the worker starts.

> diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/et=
hernet/microchip/encx24j600.c
> --- a/drivers/net/ethernet/microchip/encx24j600.c
> +++ b/drivers/net/ethernet/microchip/encx24j600.c
> @@ -884,7 +883,7 @@ static netdev_tx_t encx24j600_tx(struct sk_buff *skb,=
 struct net_device *dev)
>  	/* Remember the skb for deferred processing */
>  	priv->tx_skb =3D skb;
> =20
> -	kthread_queue_work(&priv->kworker, &priv->tx_work);
> +	kthread_queue_work(priv->kworker, &priv->tx_work);

[Severity: High]
This is a pre-existing issue, but is there a missing state cleanup for
priv->tx_skb in the TX timeout path?

If a TX timeout occurs, encx24j600_tx_timeout() wakes the queue without
cleaning up priv->tx_skb or clearing pending TX state. The next TX here
unconditionally overwrites priv->tx_skb, leaking the previous packet.

Furthermore, a delayed hardware interrupt for the previous packet can arrive
and trigger encx24j600_tx_complete(), which frees the new priv->tx_skb and
sets it to NULL. When encx24j600_tx_complete() subsequently fires for the
new packet, it sees priv->tx_skb is NULL and calls BUG():

drivers/net/ethernet/microchip/encx24j600.c:encx24j600_tx_complete() {
    if (!priv->tx_skb) {
        BUG();
        return;
    }
...

Alternatively, encx24j600_hw_tx() may run concurrently with the delayed
interrupt, reading priv->tx_skb->len when it has been set to NULL, causing
a NULL pointer dereference.

[ ... ]

> @@ -1100,7 +1096,7 @@ static void encx24j600_spi_remove(struct spi_device=
 *spi)
>  	struct encx24j600_priv *priv =3D dev_get_drvdata(&spi->dev);
> =20
>  	unregister_netdev(priv->ndev);
> -	kthread_stop(priv->kworker_task);
> +	kthread_destroy_worker(priv->kworker);
> =20
>  	free_netdev(priv->ndev);
>  }

[Severity: High]
This is also a pre-existing issue, but does device removal strand the
un-freed priv->tx_skb?

During driver removal in encx24j600_spi_remove(), the kworker is destroyed,
and then the driver private data is freed without cleaning up priv->tx_skb,
which results in a memory leak.

[Severity: High]
This is another pre-existing issue, but are the hardware memory structures
read over SPI properly converted from little-endian to CPU endianness?

The 8-byte Receive Status Vector is read directly from the SPI interface
into a struct rsv using encx24j600_raw_read() in encx24j600_rx_packets():

encx24j600_raw_read(priv, RRXDATA, (u8 *)&rsv, sizeof(rsv));

However, struct rsv in drivers/net/ethernet/microchip/encx24j600_hw.h uses
native CPU types without using explicit __le16 and __le32 types:

struct rsv {
    u16 next_packet;
    u16 len;
    u32 rxstat;
};

On a big-endian system, won't the raw bytes be misinterpreted? For example,
a packet length of 60 (0x003C) would be read as 0x3C00 (15360), which excee=
ds
MAX_FRAMELEN and causes the packet to be dropped. The corrupted next_packet
pointer would then be written back to the device's ERXTAIL register,
destroying the receive ring buffer state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788513591.gi=
t.brads@mainlining.org?part=3D2
