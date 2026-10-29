Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260150;
	b=tMi/PyrU+NvVVJSioWIH33JzOgYNXag3jpvh7wXaq6x0xu7gevIWU1RvBejPEJAAy3en
	 IELQ/jxM1I0Jrnn/gratfsmevCFlMbLMGLINbGtzCnXFBwHxutUIVbjt+peoQQts6ro+z
	 S13f1ByEyYreEm0C/iSCHn57+Qig79qtODW1mCoS1HI5uGvjz4OQJeI6U+PocjwzgaBIX
	 wrW/txSpbKKgOieOIowU9r74r23i57PFPQIDMZ2sE+XdVBA3OwsJsHH5daKk3difyjrDO
	 bz3Ur8XUMivDzSjjwsTmtWr9J7uPrOLBrAs70z2gPiXn93tX65kjPEmIhzpgHLNr5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lUreweQ/cBMZSQVNgAzpw9bUswrUV21U88SBWEdgN7Q=;
	b=1fdUHDJiSzPkDGlNkhFWq6HI+oT1Q2mQHjeTjjNsqRinjR0nNKUG3oxRhUi4iOyItV8y
	 uGWm2v2866gRqplZQkazv8QEOq43zTrz5EjZ485ZwJIgokCKvdGCHk/XdjQJCMqS0rcPj
	 u06AbfWWyCfU2Vid/1wA6gHtB9Fja8cDFeKaQEl5KDeL8k7yS+vMqMCRLPYpaS1IIMJb9
	 YkkuOwYxO74HihipyphXs074Z/vQuufUwEyXpDSgAwAfGWoC4zYIWfWSFgKa7BT3rHAUY
	 5O+cY+ESzdZdbhRQ/GKxAHUSQ3sPLi58ce4INmwvn0Qjw8sIEu1fMdY1YWba69KIdcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ezx28/7Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906B606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ezx28/7Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BA1F01825;
	Thu, 29 Oct 2026 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260149;
	bh=lUreweQ/cBMZSQVNgAzpw9bUswrUV21U88SBWEdgN7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ezx28/7ZCfxe4rMM/KJT/rQu9BTh0EUbVmJkkK+mdL7c6pxKPu1MbkBPtr3OYp0Jr
	 XJRq0hqVqPAJv1qWemLbe5NTBf58JwZQTJYzTTuY7Y53TJk+MXC/UmDKRaeoeo+C9w
	 OfG1cDLSnL8KMDGW+7KGoUkYKIPE+YPn/SXWwpMlgsEqw3ffsq2/a8RtKYQ0PtPAvz
	 xIvyNVM+hgcgbPzyMIlNHYsnknllgH1OJ6UzrajxDiO/pbkbdz1tfsprcWLMgJeI0G
	 ef0swYyzs+/YDtLJjtBw+7Ethw34znuzy69KI1iGCe2PumwyxabsxrMFgndWGuO32h
	 dVLPB14U1rAYQ==
Message-ID: <sashiko-outbox-188901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-2-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-2-3fd56ba352ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:49:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.
>=20
> Take the port lock around these notifications or their transmit helper.
> Keep sleeping SPI and regmap accesses outside the locked region, and keep
> the FSL LPUART completion lock held through its wakeup. Acquire the port
> lock after releasing private channel locks to preserve the ordering used
> by UART callbacks. In the MUX timer, publish available FIFO space under
> the port lock and keep the hardware FIFO-drain wait outside it.
>=20
> Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> path, since their interrupt handlers now acquire the same port lock.
> Preserve the caller's interrupt state when releasing those locks.
>=20
> [ ... ]
> the restart worker during shutdown and removal. Release Lantiq's hardware
> lock through the transmit helper's completion hook before notifying the
> line discipline.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-ser=
ial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com?part=3D2

