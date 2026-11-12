Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447403;
	b=kU8etbJi8ZAsbyPsF4t2XlX++8m5vEgrvxiGo4f5lNQhMFqcPIqv+XZ5uAtPkC/f4nGg
	 V0oty5RZEC9Gt7Ve/J4tcEveaC+wZJ4EfAl080vACBLGWrPhZvbVazDvFxvTXVbElwyGp
	 42wZA3JyhnHhw1Pa6LajJU7LO2rPeeIjQN6KmxvGdzjSqaCFGajUftAr1w2+e16voIF2z
	 o0dZ9mwOjbvvApUNQ0PFJmFpcyJOECFCxPToFrfopZIUPK4XNtJEHDtmAVWUIXnlHkbnn
	 qXQEutPl0Ks9WeNoKRenD8rvCQrwzGXlYmlOLLaQXycZWcz+bebjORRlg/5/82cZp1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IxF3BiqyFzEroif2LpuZrfkp7tiAexGF4+CRMA/Zge4=;
	b=DO+fJXvBnF6a9OjwVz4ZO0Q5e474n6SJGfx73mY+/FjaViol4qEu4fOkA5Oj5Kj4E7EP
	 SX8sVSGcJ7i0HJU++D3AJ9t7APRuw6RXRjNKORH5aa7YtbIc2z2fmxxaX0hldpGdsMNgY
	 GbFehp477pNdEeFXI0/+m1vfyYSb3mbYClCHp01d7oP17nOqbQS9krHAHqrDd2/e95HOy
	 wa6oEvM+9OgYxJG4ucOgbK0pAag/aFQUoJni+wHb6lmlt2LE/mOb4AM5Bi+gELEVQtBtZ
	 dY3264Uw04htVPNv8keV9WZLNgWXrahVg4XSNzmMjUuxBEP6+xn/oCwG7zIXLNxGMng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAItgOvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04294606A32D
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAItgOvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8802A1F00A05;
	Thu, 12 Nov 2026 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447402;
	bh=IxF3BiqyFzEroif2LpuZrfkp7tiAexGF4+CRMA/Zge4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAItgOvgWfyY0YFvKXdK9yEU34+bXPGBcD/gmHffs1Efg9Z8O5QamNUiytYVFOQih
	 KCefukrwms7LS7wru1yl+4WVyfx4M5USNEWiOt5fH8fCDJVK3agjsLBd3Ku4AWnRTO
	 da4R/+ibOrCK0ao3vbzJmXNImy9HaVl2HVoF5D90ANyAo+DKNvG75II20owhBKlfJL
	 PLsbGCSRRSPIjsQuvp5/aBxHarYiWRqyik1ef7qUEUsEH/7+SvEg6Uza9T3knwSW17
	 4opKwT379IOaQFxgkALraAd5dPMYkB9h8dd/ip4SSOhxILUIvGgw5aR/Ha3ssZEKAT
	 5SVy7y0/+RmeA==
Message-ID: <sashiko-outbox-210072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 8/8] serial: 8250: retain DMA resources when
 termination fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:36:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial8250_release_dma() ignores the return from dmaengine_terminate_sync=
()
> before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
> the channels. If the provider fails to stop a channel, the DMAengine
> wrapper returns the error without synchronizing its callbacks. Hardware
> or a detached callback can then access the released storage and state.
>=20
> Checking the error and returning early would not preserve their lifetime:
> serial core frees the TX FIFO after the driver's shutdown callback return=
s,
> and port removal can then release the callback context as well.
>=20
> Require successful synchronous termination of both channels before
> releasing any DMA resources. Retry failed channels after a sleep outside
> the port lock, leaving channels that have already stopped and drained
> alone. Keep the shutdown gate and storage reservation in place throughout
> the retries.
>=20
> Start retries with a 1 ms sleep and double it up to one second. This
> makes short-lived failures responsive while bounding sustained retry
> activity; neither delay is a hardware timeout. Report the initial failure
> and ongoing failures with the elapsed time and current RX/TX error codes.
> Track the five-second progress-report interval separately for each
> teardown, so failures on different ports are reported independently.
> Report recovery once both channels have stopped and drained.
>=20
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D8

