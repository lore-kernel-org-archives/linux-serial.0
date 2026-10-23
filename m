Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773290;
	b=AGqtNQ8zDi5+vTW/mwBrbdfZIipO/CQvwrRiZWB6N/Xdsuu11zBiXtI/N1pUteHw3/lo
	 qKYla+pjGGTS49ZVOCsOUHCk2znDzNFWL+X5f49ilygI1BbEHyx7ll5fOaBCBE99LX8/l
	 JNcYBQVZd+gfaYt1dAbs/aP8qZjNFARfbQNoyK/t5u25iB3BfFMS2j/V5pWu5JBAQqx61
	 rS4l6ra74z/tvjHXvAtCAJnc+gW3cFdrqQ1clkde15XYcZSLUXQKlM01noh9c7CCm1VQp
	 VvuY+exF1T6M31vUSnZ3L1pTXiuLTuJkh5rVlEM0s/7CiAA+UcDj3nmwaAHM8wjjtFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kBF9fTYf5JIY94o0ImXzD8NE8bd7i0QSwjRCnpCCnGM=;
	b=oUVK1lr3kwm5v8LzMm6llxN7qeWUsbXgp8YRH6dnQ0R0T3kJjtytTY1dDGZ9T5/Jr3Vt
	 fvR6gFxsV1MJ660o3UqadUHQfNR7LsP5IOrkmq8RSChDX0SwxN0WDfH8FnN+P67bJeh9X
	 nLtcfWcmWgV2INAUtrjYn/Jv6iS1BJWhyCbZnOrkpMYG1cKc2blrIxSYiahm1/TMh50z2
	 ockPUEKioFnob4bWyScuBo2YE9qq/mytMe74GuZjoN6DQtxK8TN/nL+e2ddjW9qeC7KrK
	 Q+G8OgnMDgs6McDauDR8KUzie2Yr08ed+8j/+6k0KWR6f6iO+yl5/rgSGYGfiysaLGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAP9YlvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DF606A31D
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAP9YlvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACD51F01825;
	Fri, 23 Oct 2026 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773290;
	bh=kBF9fTYf5JIY94o0ImXzD8NE8bd7i0QSwjRCnpCCnGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAP9YlvAc8ZPWkntYYl5bcRnL9EcliMCUbuC+L4ruhjQ4LH0mDdCB4vP5OcddtBl0
	 LdWETI/JFJp92WaEnNmbLgxMJOdg6ESQRZPvVRjGSO06as5LuWEsEN49LSCygZ2xiN
	 920gFSdlHa57y7SYa2DjcBklx7IbrkQc/kfyQIQXUG+KkooS6zm4NYZ0EKENkYBuhi
	 lcRqXd7/bMGCBfOk5GIz9PrPgjwiX6NFJRwweeo+ZiYXWEVe4MsFxeXZPq8l487RkF
	 q7/XMfnt3y1vfSfTcmHd8yp3BIDzsd7VTcawGZNvougu2lP2IHjEUeO1ekfpX3gnqp
	 mpeHdEX4cDegw==
Message-ID: <sashiko-outbox-182952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-2-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-2-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:34:49 +0000
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
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-dw-=
dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com?part=3D2

