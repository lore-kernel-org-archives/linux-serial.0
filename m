Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145318;
	b=jNfVITVZTLLlTImlu9OHSi/I5OLlafqLCbzeMudMCYD5PsmRU0jjLA6wRxnEfxgmgwJu
	 9XZxw15PmO58NoiUPkr6rcqJClPrj/8zshupliV554z5q6pC7TTdl3d8mjDFQdpCCpjqf
	 cKM8/FzeZruLt1nmD1ogXEIbu0n9eF9We2pD6zJ+GDmymY5GWNyOL8HVgiKeqcoUPCJEn
	 XhPL1cIvBEgaMEFfX1bo4XO3voj8kKDa78LtIOKzW2uUbuLZ1nnW32bsXpX9m/dJ3H6CG
	 x7v6IMF/QryuKwgQTt8rV429ux+sZsXC/n8MgDfqsyJGXPI+L68pLNzJDlBHz0/+Y0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X7JNDN9taOHLQvGKpIRpHJCLa88pjttdoNY9nZVoivk=;
	b=Ho3i84zyBsu2btO9hg0tjQWjySbHeuhERKPi6GoVd0GgkjE0Tki30VL/dou8ATXLEuNA
	 Q5Pfv5A77Kbbl+fHvW9aMHPuwAHPRpTrXZWrU6nxqoLaAD0HYUMvgxP3xnbRmhhhTxMQ9
	 06XGxDPiprHK+Qlh5+/Ua+RK77an+LQiYU9/zL4gjQMCPrPEjYvZ6YY8YfKetq0xzmF5h
	 7mPtFpU/Rvn1Ea2a+MpcZygpWljP0c+bo9q6iBvfOfimBL+sYYXa1AnEK6ZwprJEdOiO8
	 oguksrUxuGIgKcSLwV2DpTiw6lh/uap9uH8L0hsuzLuzlZBfHlowEMUWxGxHvIgqNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0DoZvbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E5606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0DoZvbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B861F01825;
	Tue, 27 Oct 2026 23:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145317;
	bh=X7JNDN9taOHLQvGKpIRpHJCLa88pjttdoNY9nZVoivk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0DoZvbEeMBwiSQtKuIFkj7sX+dWkIfECATxwuo0AA+WzmrZWcniNDwi+Eb++sXnH
	 g7vy9Q1S6lWDclXZSLTOcMh/J6QO/kdknmXZgz5ALZWWHgsAdwQ7oM0ep5r3DDn2nU
	 guSFQIoLkl+8F0HDx1056f1eAKQRViHM1QQrA6ZhcBCB3BcOs7ApD8TB8EPW1H2HXk
	 n5xm0iF1onmUcot8f1bKjuEjJPO3GI+8M7+kMRCBQUbpRgZ5eVqQloZgvIeVm26Tq9
	 Xh7ASDH5A8ggMwt/EXRFXiNfyRO7HrwEqZIZjrZy4ObemeUx7M5WSoFyHogZuTEBsd
	 FXMHBiOgQUpUA==
Message-ID: <sashiko-outbox-187243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-5-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-5-985a023ba4b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:55:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The RX timeout path pauses a transfer, copies its data and terminates it
> asynchronously. Clearing rx_running at that point lets another receive
> reuse the buffer and cookie while the old callback is still waiting for
> the port lock. Inspecting the new cookie cannot distinguish that callback
> from the completion of a new transfer.
>=20
> Reserve the receive buffer until a worker has drained the canceled
> callbacks. Keep FIFO access separate from callback retirement: after a
> successful pause and termination, clear rx_running while rx_terminating
> prevents another descriptor from reusing the buffer. Deliver the paused
> data before allowing the interrupt handler to drain the FIFO through PIO.
> Normal retirement only releases ownership and leaves subsequent receive
> handling to the UART interrupt.
>=20
> Preserve the normal completion-path LSR read and gate DMA resubmission on
> [ ... ]
> provider still cannot terminate the channel in process context, retain
> its buffer and leave receive interrupts masked.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-ser=
ial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com?part=3D5

