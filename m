Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564040;
	b=HbTn7z6eSLyvbF0slWvDHBTrg7PvfrVDd9oOYi7joGM2cDkk3Sc3TmuL1cll3kVuqOS+
	 6sT25iNzeJ93cIYA8icP1NC55Wwd9mflmmNX8VHN8UdSwPqt9Q9k9muzinR4sn0cUdeoE
	 lDdm9V8Hr7Gq/9CeVaew13zB5vaYfP4rv8bTSHhvxneXF3bHt9SxTg6P0hgiluVRG0e0s
	 /uxv9TrvZPBW5E2GKG1TQFHyWX42tAlcApxq58l/mmcu/oa3rymwHwH5LKypbM6lIn5dB
	 2wqoYrhNZJittwRJYaXRlREk5I41BxCofuvZ1LI6wanu2dgcinRMDpHPqeJrmJ8htKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CuXxKqy2C4OTcxKZlmSAyFn4Z0kdFj/zrp3DdI2wdpU=;
	b=YwekScdGPd/ZTj3rJSY/Ai/q+7i6HJq7Rrufj/2QduTLLqTcAMxs5vFXwIToyvI5P67T
	 1kTz501oKbW7WxGULiQdCEGo0qiuoy/9l6+MM6IOucqfBnyBwFuMpvRa6TtHrxu7G788l
	 D/O5MguKI8jLw14cahSp9ivqEidkvI1l/H8I9ZHyy7ZyN5u8FXCFZ+0A9H9wJ8JZeSk7K
	 gB0JapssJp2bFPyDc85yF1+SHl6/D/I67vAsJ9D2t1XnRTqFKCV4En1d+GNlC1BYWlC8e
	 1LgO283/t+4Rh+nrQT9atLg0rxvTVu3RgCjvcfyggF5FhMZcjhrNJff8RyaZw11XSww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjppuXie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D675606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjppuXie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4631F000C4;
	Fri, 13 Nov 2026 10:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564040;
	bh=CuXxKqy2C4OTcxKZlmSAyFn4Z0kdFj/zrp3DdI2wdpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjppuXieZCX+p1KpKQ+01kRPzKOlXeaagvhQKyRDtCHgJZeLQLC28fMI/uyGufn96
	 YQ6SQlqL/bey3NI3WGNZeIV03L6DMME5pk8MziIpr1tqPgLt/kVsdNkLXr0kinlrpc
	 /B3sB9d8vMF6K2bap6YhMDb5a4D9h7aMaZ8EI/79kmWXAYF/UQSsJCn5l4+C8Sv80I
	 k/t3iBO/bQnNvBWyaJvyNQ2UDg0o5VuYlUFEKNHGZnNTPuB6VJj8jepss3EvHixwK0
	 +116mh6m8Dwxj199/tkYpVkfVA5C2ujUxI6c+4fE2lEWtZoujspGK3w2vpGn0erji1
	 AfjgXItS84U0w==
Message-ID: <sashiko-outbox-212592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/8] serial: 8250_omap: quiesce DMA IRQ handling
 before shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-4-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-4-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:00:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> disable_irq_nosync() masks the UART interrupt without waiting for a
> running handler. That handler can have observed up->dma and continue
> using it while shutdown releases the DMA channels and clears the pointer.
> Synchronizing the IRQ later in serial core does not protect those accesse=
s.
>=20
> Publish the DMA shutdown gate under the port lock before the final RX
> flush and interrupt masking. Have DMA IRQ handling check the same gate
> under the lock, so a queued interrupt cannot restart receive processing
> after the final flush.
>=20
> Drain the UART IRQ outside the port lock before releasing DMA state.
> The lock excludes competing RX processing during the flush, while
> disable_irq() also waits for a handler that observed up->dma before
> acquiring the lock.
>=20
> Clear EFR2 after draining the IRQ so an in-flight handler cannot restore
> TIMEOUT_BEHAVE after shutdown has cleared it. This also waits for the PIO
> timeout workaround, which updates EFR2 outside the port lock.
>=20
> Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for inter=
rupt handlers")
> Closes: https://lore.kernel.org/r/sashiko-outbox-206203@kernel.org/
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D4

