Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648347;
	b=26xG5tujnGz0XUxn4NBxALva4CRQxOE2aGpJQR4H7THyvT8rFWwAv/tz4F6enIuYkMkz
	 WYaDBBVAvjFF59Ix7eaaTYjMkHpuHAIcj5x4x+yNpZJNS1z5JikJl6sZRsEYVkDYQP0XO
	 WYBa7+Q3GsnwZkH3JTC9E3UinaY0nga+rD+EbSQZyK86Yc6oHEfs7mW63eu0T1LU+4+wo
	 0URlKxzgLIID3P92AQ//sER0qhf2dqElCRlmgX28hjOPnZ/cRzomYczHcjLJb8uBVCTUy
	 IZPoPhtm2iBsHNo6yjJzP6sMaaRY8d2W2mQUEeIRJEOjHCneeExL0IYDiOyMfPUBlXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2KgYi5o0ixWt6N3xGegWmjhTqypMG95E8bDTOx4JTjc=;
	b=eXGPxRpXbGMi65E0LcFYwoxbTx6te5I+hJdpjQQZPX7bIwjRd8H+vZzk0ktXQ/uCazSz
	 SxhWvycBAHLozGtz5Lr4XZC6hVRGluWiXketvgh+Kt9e0bU2ioGKxIm3z6R3/nWev7C1D
	 lLE5J7Rq/ThgWmO7Z5h1TzBge0Mrb/mUIhYtvny5w+0Z4AZmx9JZ7YYdpVeFvFSIGK6Jd
	 Oe+mhpZFPC9PJkytdPFUe7hFq1s1NiqAJHvMXrXuu1npu/CPEkSWPaUq3J3BsPd58UW98
	 DphVsVrI3kBkXbQsD5jqXk5stmJ2lq82lFk9AcxOQVMq4wpzdzrj2QeYnSN7cIWKbxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zo2KVY+m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CF606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zo2KVY+m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E21F00A16;
	Mon,  2 Nov 2026 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648346;
	bh=2KgYi5o0ixWt6N3xGegWmjhTqypMG95E8bDTOx4JTjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zo2KVY+m8qNt30jFMNTtbp/Y2fm+qkslO1h/DuL569QoTGhomJSIf10tJGX3ZylPf
	 Gw1QTgxwAsUW/xew5X7I5WLHc2S4EhxtM+5DptCBt5/LuYF2to7sJmwc+uSuBpsAfI
	 KiZIPyBZ1k9EPgke3tVtpKgLf/XeQvhlWAXd6Vnv+0BR14EtNQcs2t5ZA0ejkB+LCp
	 Aaq3uKRzeB6PtwIypcdrdEBxLpnFbChLY8f2d0upZTJxNWYLjnvzh4BopAK5MfVgP1
	 JQUjDdwsdTkwizKaWAXRKnMFUe9XS+Np2M0FBIuEu30dnr+BGKoMgSbtagJrMdmGOp
	 eWnj60f1oky8A==
Message-ID: <sashiko-outbox-194014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-2-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-2-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:39:05 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D2

