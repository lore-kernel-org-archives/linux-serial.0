Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648761;
	b=AgbBOYz9WnIFRMVfft5cBwX+CoTX90RFvQK0D3ayCjX4w/RcCnJcYFpBqD3CE72X4lbi
	 nPDf3okraYCMtldglCXqFTMecmRifZLv5MUuwW+NFxuqDUSuXDa1/9X3stctXVaS2qlG8
	 m4/RtPa5LPgZobmP+RqqLE7cE7KBYqHrYoHGvl/QyISqUwIcGvKngEsv4MvwspUuAJxMM
	 sjWmDreh5zXGnCNrkAWTXXHViTFNfa2ET5iNBtWMYUN85bR8puGvE/zF2mXppzr4YimEr
	 CwtcM2u1IY+FTP+xqG9Y5z78o74bZE2IO5kuL3t7yAWqyj/HCRs2tcOBz4l0Y2f4SCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zNOWmI555Fw3+30jvBoGh2GbL/GiTj451zBYtJZaM6U=;
	b=QV1VRlUK7d0tb9G6EP6pr6FJQ2A4kxHaVNudB62DLB0xRQeYlommZJ9+RS4BJpFXepwK
	 AlNJko1OkBzVQW4rYb/bWRIqGPRj/gseACIU6oJxdMIGowgiAG228mT3Nr/nPuZffEZWw
	 GbcIxAU+4h7Ec6QM06Ih20bqf0pxhGIxc2dbRJRwJYMhnLtZxpVTekykY4y15mFeHJMBn
	 vcdKr07kyYaap+/GvSMelnB9bNNgVnDjfYdMpLMg4IEhPKPVrLP117vgT2+MczZpzOSSM
	 vGyt5XoSsz1OVfqDP/bd912nioNSrF3eAtHfAkn8CWCOlSDxjkazKE1nOjLZ6SuzVSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zxd3h7/0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D0606D80F
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxd3h7/0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE51F00A17;
	Mon,  2 Nov 2026 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648761;
	bh=zNOWmI555Fw3+30jvBoGh2GbL/GiTj451zBYtJZaM6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zxd3h7/0bykMF9nSb33snDNfuWWTl1QitRTK4AoWyHDKkDIB6ml9XmsDSFsLJO9tE
	 VXP48xrqBuhqwgUP8SV3izoR64S/vC5NclmYge47qPa1HMJbSneeIjI0IT9gkijpCn
	 V5Sqpm9jMysjJuRX/DOAkaG7yvwcwnEzpM/C92W2bRgphENZovmZfHHJfCPxmysQta
	 /6X3Jgq02jJPkPySej2hTO56yOPJ+/tzCNf/tfaqmm8nf4hrxQ0fz6tvnDvUowrnq7
	 8dKT10/j3POvo/vrmTdm66vp3tTMy1Z5Mq5G0PN+RDyU4U0RnIFgzkx7fG/Rb/FmW3
	 l3LZz8oeyOiDg==
Message-ID: <sashiko-outbox-194019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] dmaengine: dw: Fix XFER bit set, but channel
 not idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-1-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-1-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:46:00 +0000
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
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>=20
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>=20
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>=20
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> [ ... ]
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D1

