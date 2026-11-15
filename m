Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728053;
	b=qbw2ezLg+zpr2WByzE2bgeV3KGKZx0vhmX2Etx7GPyj4TGssOQ6Ez4uP1LSzDM/K0wXw
	 4DyrB/OG2ungt8pPDzhWHbwJ5yYk6AEXqXhbPubkzFT3QuY8zqHkt1zklygQ38zn3ZBjt
	 SqCF9Q1OZGbH8HUlg3aNG29rUpFocq8aZ6EyNUG69zCmlWSvtKOb0lO/j1SUGZgrq4qan
	 7tXHCrgBd+H/g0vzbHNfQZHI0CzBhMQk2GimjT+FGUSbPAgzwkIWW8pQ/O1s0EetkmyzI
	 x/uDsanGhTd0JPR+f9zfEvTX5uun0euIv0R+Z+jXbrRcAtQSsiPcT75vNIvcIMH6OZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F2OAUcuJ1n6/hp7yCoBt/gpX1ruGBUsONAAi2BluS0Q=;
	b=hJTgGuaGNfD9aMpbqCr7/OAlLxNwgu7I0SjUtHTSkE59NpprsrugwPESr3fcVnynncWa
	 duLOp2ZB3VdpfXCKchn06rt2Y5kJpH6Pq+jQk2mD+dqh6b5H34QeRinjJYABx+B289ml3
	 UOuUPCcTA7m2p6q8oOstNqnx+leBoVvkEGZZx7oHnMt8mTFSgcqvknF09zYWBOFFDU9v2
	 JraKbnUKI+IBRuqt7rrNGukGPftUDGYeZaSIDHlABH6lVWH9Zi3Ued9mOY5DGTwbfOhFJ
	 szoaVzhpEF4I9ljp77GjvxBdbjLzfjKnRCchHIKqewgUsPRjFJ1xsX/lf74eH59R/Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TX69Gogx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98E1606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TX69Gogx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CBE1F000C4;
	Sun, 15 Nov 2026 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728053;
	bh=F2OAUcuJ1n6/hp7yCoBt/gpX1ruGBUsONAAi2BluS0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TX69GogxL3VC9sHc+jWoAblb+8sfOECdJo9nrpMLp20of0plLvrZhQ9PU+I1q7W6Q
	 HK0d69WUTHCKmH9T8A1eHLn4NPMojZ2WuY6TlGG9xYJnRFDTgYiBW/2jzMYk4qwNNr
	 V7cagQ1jquqjeXxoUfjgvcMJ4s3RbR1ul/Qat1AFqj/Czibqsdoq7b2/mRd4IsKbBN
	 mos4901c3+MIINhHcpke/Yl0f1f2UVFzFz/tdryjcx0Zj7Z0v6lepViblC5cVBs/6R
	 9rQp0mcVHc/xu4WdwYDpc+D3ip9cK3spj/t8BpnVOpbnh7tD+xcr51Xivws5FTfsNh
	 F5B8f3spOhQRQ==
Message-ID: <sashiko-outbox-215264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-10-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-10-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:34:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> The DMA transfer status getter can invoke a completion callback from
> dwc_scan_descriptors(). An 8250 RX timeout queries that status while
> holding the UART port lock, and its DMA callback takes the same lock:
>=20
>   serial8250_handle_irq()
>     uart_port_lock_irqsave(port)
>     serial8250_rx_dma_flush()
>       dmaengine_tx_status()
>         dwc_scan_descriptors()
>           dwc_descriptor_free()
>             dma_rx_complete()
>               uart_port_lock_irqsave(port)
>=20
> [ ... ]
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: defer notifications while preserving polled completion and cleanu=
p]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D10

