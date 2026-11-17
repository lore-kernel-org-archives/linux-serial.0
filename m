Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956087;
	b=DGllNeWMjhB+zYRimJ+o8AkODYHAVpU1qMalgvIJ3UuL2uNJbCI3DNiYOAx90uEaYO/M
	 8448k+yWgLSsw5X8+FWqgngHAGr8cD+C3gZomoeMxwzjtdUJcq1m5n9JUoSSmgB2HC+sF
	 n27N3S78FZuNWC5jbiZ4X/k2hKSolRISJOhjlYJg8L6x1zRPcKfiXkt7+iRlGW/7Nvb5w
	 qLvhSUZkMAmJnOPiLs2UHUZLWuT51ZNz4Je8cw3cNU0dE6HtlgsryMSAod65eLVRd1HHU
	 W9+8x7c5IMc5aE30/E7cJX6Pr0V/2oENPqrrSCisUtGkpxQ2PZpK4Y1sUZcj/mhA9KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AteIRt+I+puDYWrkqeRrzqlE2U3lEzv18N4TdnYH81Q=;
	b=jJRmTFy62IgVLd6mRQQOkE2Bd+6/YhCJ7kk5951uA3v3Jn00gItaTHKoN6i3Yz5ypne5
	 Fp6IXNHdCrUxoiBkN274cmMeABV54V6yDpoI1xbKz06ofC17jecklsC/Z5ulhHu6PkuPb
	 l+qoU1gWzyM9gZ7emLTaVoEA5stJsgGxfdocbGIQBbsMTyFFLMOlDwyaO3OFECfleaiTj
	 TXl+xsIm66ql9hT2J8R/I2uuq+Z33aC/BwIk6JYcw6UCJxJOgICfO4UmKSQIG24A3e3+P
	 vcYi6HxEAFsXyMBfwa7BTsD2Dc5UkpJb6Z+E3nHDPxY/8gtcTEigG0iz1ywGZFI8qvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G95E8cUP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1E606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G95E8cUP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983DB1F000C4;
	Tue, 17 Nov 2026 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956086;
	bh=AteIRt+I+puDYWrkqeRrzqlE2U3lEzv18N4TdnYH81Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G95E8cUPQyUhSDuNEv4M1WZdyXyRmkFtaA2d/zIW5nZKSwsYdFzc3UtPZKr44+kB0
	 rRoSCTR0afpkZh2mQizgdsnKZKcbHC6xJuzFrm8BmMw3c6+8wHbDXm24S19oehK6Ea
	 epbwdxZd+v0QwkubCnJWA6YzPQJwRJ+ifNNibvgLQ9+tWv18+ki8Njr1caZeoO68Bo
	 j1IoU6pf/GCxcmayBb+ybnvqwIML90RobtgxX1Rs1qmwvgJpm9KRlB1qNXca9zyqim
	 sI3uEGGbUS67NlKbbM6wm+BBIpvdKQjX083flsGQdUlXDLBWQ6wJudUJAhMbaRoYTx
	 XL7W3+ZsisPBg==
Message-ID: <sashiko-outbox-219767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/6] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-2-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-2-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:54:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>=20
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>=20
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to =
dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-submit-dw-=
dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com?part=3D2

