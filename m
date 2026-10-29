Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260304;
	b=y+7D/KDrJJikqp1AzaYlZokDfXnD41vnSMEspUyElq8WGeH4fB93Q2sIWrCn6pbLQqnS
	 xTFf0i1i7iyUioHD7vO+IZ+aVf6Dh4sPeF5MC9TcOXRGl6+hpvoyfsc0r/LM6sk0/Di7Y
	 k/Zw+iVaL0PsQwlBktIj2mFrWeieadBNaijJvI8AQHn1p/CAQYNUrFLYPKxTl1sySTBPr
	 qG0ZYgfsyFWFNwtxWz/n3WwRnhckvXgP/lUe+yiszVX4XNDRklT7Hgrp7PTHq/cTUpkVL
	 uKctFwPsekEqNrf6Q5xpD31XFE+h/U+mj+oHpRbOEhOyL7yHgOk3MnWgsfUqYuMd+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260304;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tcCrIlxLJiJ0GfSjPAaL7cO/FkfaLmwUXkuxwrGHJi4=;
	b=y4t/C/fIE9PX576hEH6xcsQGDnd9usr+AHp5FKhgT4gcNOTzBUVfd3GYTsD7cjilSnhN
	 bY0b1D29vVvsZBh/HogQltFbJ4FQMnfiQTrxPqTmS4rWUg0Hjca/23FudR/kr78qSgpbT
	 WNxk/JhdDMUSpblF0LekZNjINyz0UW9K5sBIEGJUKiIfmAiZYyAMAhPSB0yu+Enq6avPt
	 xo9zlb2mRYaoIJWXn/ACq5PqJ+w9pbMo40Vhp10D+wVmcI3s4cLf66RExROoauz/kC/r+
	 sbBf9z91C2QY9U/1yhd2lvKZqExiHm6YLTQpB+VJnsJlaP/QjflMNa9H9m01MmhZYvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKvSuw77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA28606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKvSuw77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D51F01825;
	Thu, 29 Oct 2026 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260303;
	bh=tcCrIlxLJiJ0GfSjPAaL7cO/FkfaLmwUXkuxwrGHJi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKvSuw77TgS1k6pyxm9Jww89YpE8Uu/9aHWLI2b8V+zLoYszUlRAaX0o8jtMVAUOQ
	 2a/hFSALPraXfDVR1/Td8Ql5gx9xSo/1oEm2s2HPI/KZQn+seHrnFZm/qxWSjDby2/
	 mD8WSdJgu2kLNSVDhxgVCSlR6cis/zrfgnQpU5AbsGtQmahJaLTcLNHz8qnhcLaksn
	 oz0UBhOLRiv5gldRdZ4WW6WNOvVwE2pYJnSE6HlWoY8edDiCnK8YP8wIY716UwIHQ2
	 XjLGLHl91f1gk4+Gb+kjR32x7P6RbFrfnRRrtAc7iT2M0lP/+gFXAXZtHF5DmlK6U+
	 gHeZp5dpYCZYw==
Message-ID: <sashiko-outbox-188911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:51:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The generic RX timeout path pauses a transfer, copies its data and
> terminates it asynchronously. Clearing rx_running at that point lets a
> new receive reuse the buffer and cookie while the old callback has not
> yet run. Inspecting the new cookie cannot distinguish that callback from
> the completion of a new transfer.
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
> the same order. Drain the UART IRQ before releasing DMA state so an
> in-flight handler cannot retain up->dma across its release.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-ser=
ial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com?part=3D5

