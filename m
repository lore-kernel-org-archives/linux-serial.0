Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827425;
	b=oDqDOq0u5+XIMqr1Iq/VMUT2soDOIajxnHV2QiehXNup01vl3zPig+MjhdbdeVdzK6T0
	 IPcVLaEtKFbYjQkFgeWEM/asGvsa5wlqEcqHLb6Z8RTCFrd3qF+O3gJ8tW4/2RzNipPkx
	 t+mxktdY1OKj4uHspR0Ckuo6zZW3c32c2dsl6WcVzKcq/Irafjcw8mTgEiaAbGH0ffnal
	 PikfJaXyJBL8d4QmNjiMPauPjHzuX/7m5EP7+XTrhwGxq3hoPc7UxKlaNzj+d/1O7N3dC
	 eIcDqepB/wgxRLvVzl0PYAkmI+oNXdEJQiMOYdEEj/0aDUEoDTjkvCr8sTxmt/4hRCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827425;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eKNAoD2UjnWVHmZOZ+/VflaMR/c8CiX2VZxxw2ZnKVk=;
	b=dF4ElNLOudXxPyq6Mi30Rm+bigVixlmfs37uJZzlRyT5B3HbYjbcc6awCKmR6qkTWaE3
	 +cYiN9rt/uLML8UL4yADI0pHJZOSF3dGNTQN4iNIMr8pDNf+7+KxzYVTfm4KNaNEpqiqw
	 IrMJK5ZCICtyqBWMzK4ZOytmlOZS19JO6POHJcVMumGiOYWqTJmMxbapTCjA41NMsCCRt
	 9E5Ixd1tLcfWdEttLJprTFEMlnGhLQDnMVOyE+PTv8DiQ2K3BI3TUpSGsizAv1YkDj3iy
	 9An1m6OjQrM5MROL94zRn/i3OzMig5csNwyPPX2UpqdB2n8ZAVFqpYsXkiwhUUVg5WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrEr0JCw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117E606A786
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrEr0JCw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B911F000CA;
	Mon, 16 Nov 2026 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827424;
	bh=eKNAoD2UjnWVHmZOZ+/VflaMR/c8CiX2VZxxw2ZnKVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrEr0JCwIqjizz1z0APhYzJG1TviL06qtrm7gPbJxRi66hCP8LzlYd03RuqGShsmP
	 tQ83bKeoD8WylyDjM9SmtRw/OhLRSCnfT7Ynb9+sABhmAWxxBrs1nzmlN2atgE8HwH
	 +sDQ3Y9CjQtZQQav9EmEV5ZQvr9+LMQOKvEyoAMLTR38HZh1qEBDXo5OprTCbczBKF
	 Y9Smp7SkC6LR1taJD4lz7yKTpxNVJLy8AyZDm+yhQQNpYRg4+iwQmuoROTCxUBxmCh
	 fFcQx7cDgkBqoyNyBSld8Vs1r4LAJJl7PNvPmr0Dsr/MYX5nMfG6hur3PbMd/yiSgi
	 5P1ycYG+riaRQ==
Message-ID: <sashiko-outbox-216851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-3-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-3-4a82d64fcd1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:10:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The status getter can invoke a client's completion callback while polling
> the hardware. An 8250 RX timeout calls it with the port lock held, and the
> callback takes that same lock. Termination also lacks a synchronization
> hook to wait for callbacks already detached from the channel's queues.
>=20
> Use virt-dma for transaction queues, cookie completion and callback
> delivery. Keep the active transaction and hardware state under vc.lock.
> Polling still processes RAW.XFER and advances software-LLP blocks, so
> clients such as catpt can complete transfers with the controller interrupt
> masked. Client callbacks run only from the per-channel virt-dma tasklet.
>=20
> Submit only the first block of each transaction to virt-dma. Its child
> LLIs remain on the driver's hardware-chain list and are freed together
> after the callback returns. Keep the controller tasklet for hardware
> event processing and error recovery.
> [ ... ]
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization=
 support")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail=
.com
> Link: https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-submit-dw-=
dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com?part=3D3

