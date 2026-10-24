Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822632;
	b=ahoUKbmjalhTp3y+TVzP1v+Ee7sCt9x/q75IbkoZ/aCwMMeFm0h/r20jLcxUwOJd5/+F
	 yu+CnWcBCDlBW0Cjjexxpgx9CNbPRTjcYId+Tm89mcGVNm1JLbteEY5al0xPPciGYSsvh
	 /MEXgW/H/Ff5Ou/Nju1HavBcAl9opOHvr1BYVpRLd2l0gmLtzLRyF5XYCDNSIP+i3R3fd
	 9vF8R7wzGZMMSN/x/fARVV2xUOuGo2I9Ai4Lv9RflxTUvTINRH0igFLh4zerOe7Oeahy7
	 wn4LbqgrASlCvYSeNKsge5M6WEEKscg3bDs09VqoqqYYPnSJTXmb/SK4jIiQZuPThvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822632;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dkrqAp/ee6YGcQJuYNrpf+gUhyd2LxzZHaN6mFJMQsk=;
	b=JJehznaPAkiBm3eY9LZYx7w5WfEU1p4oIg+vJSelhlaYPjwR6Weqos8yu/yanrFxwfxW
	 K6dPgX5K4cYiZPgHsezWSLI+UNZG3j+m/Oth/UdZ1lvpKUcH3PTvqsJmNPd1HaPwpI6tH
	 ZP0/kdI8HCpVb8loMKo8kbLIXdBJKnUnRTnqblcxmH7BRaCP4g6PfnuLHot40EssuWyHH
	 g9MqmhzRsK82Jk+D6S0vBk2qxOnOCYo60k66nCqjDx8MUCFbIhUKENealcYdNPu/tk4v4
	 0v+YFR8w/O6341pR7QSyMYpOA5Y838hQEkjX/+CmY+BFB4JOInggN727+Qu9Lq3T19w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgilpjZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25C606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgilpjZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8480E1F01825;
	Sat, 24 Oct 2026 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792822631;
	bh=dkrqAp/ee6YGcQJuYNrpf+gUhyd2LxzZHaN6mFJMQsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgilpjZAnms0z0YyRnZVVzqXI95XUl1Bzb4uJwdqGm/xneRElEzkdflpZTXJd1UxL
	 ajSw9u3tf6PG6/vyKipjh7qtkYuAwuNsdFgxflBsSpnE/GsXeY18EiaxApb2o3QhAt
	 cqBW8z3QBkCxT59GIp7PyyZBkhqv9tGtk8p5+CRMlL82wUwxvSFtJLP9SA1529Rg5D
	 v6GBxjnRFw9sIkjvOEmJ4V/ecY5KOnRHF89dG4JjPseNF5KpPQDTSaGONifoGGHSVk
	 dTtXyDJal3fbWrp++79msHBY5tiYhpX3TgdaVwiDm6z72jq5+J8szDjU743tJQ9gbM
	 yBwq3r9B74+gw==
Message-ID: <sashiko-outbox-183569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_mid: lock RX DMA timeout flushing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com>
References: <20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:17:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The Tangier and Denverton DMA timeout handlers call
> serial8250_rx_dma_flush() without holding the UART port lock. The helper
> pauses the transfer, copies received data, updates RX state and terminates
> the channel. The DMA completion callback accesses the same state under the
> port lock, so it can race an unlocked timeout flush. The IRQ-chain lock
> held by serial8250_interrupt() does not serialize the completion callback.
>=20
> Take the port lock around each timeout flush. Release it before handling
> the UART interrupt, since serial8250_handle_irq() acquires the port lock
> itself.
>=20
> Fixes: 692aa1905679 ("serial: 8250_mid: Read RX buffer on RX DMA timeout =
for DNV")
> Fixes: 4831e0d9054c ("serial: 8250_mid: handle interrupt correctly in DMA=
 case")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com?part=3D1

