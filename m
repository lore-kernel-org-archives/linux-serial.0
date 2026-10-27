Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099812;
	b=kPoijaaLRED8SDyk0sd6mG+ZpcGe/mhPV7SsbSR5JkSzLZGqWSLDKtFpAFTvUqAamWho
	 bHTjPiTDkouHRSZ1BBBG5ViwlChlkhubJLABTZ+7eiy5kpzti3kyOtuYDSdvqLewvTBu2
	 ihL/es7DZPMT777aTnTAFHivEH3CwKzGSEoUr1sALsRjWlisAV3hKAPBeLZqLC1gt4WpP
	 eFgSKGmASd7S72mSeXpFOMKenoEtjObADZeG+zZgtjnQGGAu+Kb5xPv+3mAERpsi3tej3
	 nYJZaS9ZTSpysUdwLDHeUSR1Ms3bybZPuW1519O0COMe+1ReU5X+EhcAeMj0unnyvJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MpCOTmW+AHXn+UJPmf00PL9dHPSPMByYvwTS8niwzzs=;
	b=IuN9npxbktq8wEjmFVUC1lJuZfF/L4E8Txias2NxT8/xjD7ua7qAON66dU4hY3qxWKtP
	 ccbishujnQ+/NVonmW/Ccgf9FPjWCvHOUSq8VHNh45qtd0CaMSffBuyeOlp4mZ7s+fUX3
	 ddZot1Cixi10RuDFR8BlLMTDsRxtKtaNnouon69cPkPFXWauziJAZsa7tnTUJ8i+u37Ui
	 45HUGEea2fL+j8KGSyiNlr7Av/92Cn7scvQMzsWnXfVBmoonbzroE0r4TbQ5BFawe6YqJ
	 sGsO5wdo8teqpHOqAOKmZ4p6S2EwDTgC6hMVkXGsBjr/vVpRR8Y7XkvvIMWdQMF3JgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaIdvOrJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319F606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaIdvOrJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B9C1F031E1;
	Tue, 27 Oct 2026 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099811;
	bh=MpCOTmW+AHXn+UJPmf00PL9dHPSPMByYvwTS8niwzzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MaIdvOrJR0DJywUZuI48rQmjJjnwsi1V12FkulA9VnBq4c5sVpKfPND+d7n7zST8V
	 sozMelLOXMclBf6pP2uXjA0h/jgaKZ0tBgxEUUhwIz7rJLEH02VZSZLJ3MgukwoZ6E
	 EMsk8u+XVD0w7lHdXKN2gNCDzjTGpvh+snK+BhiwHFeu31IY3BxTOlrY5zIPfqKkvE
	 VQ4CSGkErRTjd+L6Dp8SCJXVYaICOxruOB/vCnvdLDyqCbBAoOk3A8lnM3BhGES4cl
	 hSAqjICJH19FBuhOH3nleKqlF01gU496XUM75JmUkSi/a0lHG29pMx83Yyk6iS1VdX
	 ZeRl9BTDhJsrQ==
Message-ID: <sashiko-outbox-186430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/24] serial: core: respect runtime PM when sending
 x_char
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-2-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-2-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:16:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> __uart_start() calls the start_tx operation only if the port is runtime
> active.  Otherwise it asks for a resume, and
> serial_port_runtime_resume() starts the transmitter.
>=20
> uart_send_xchar() calls start_tx at once, under the port lock, whatever
> the state of the device.  With 8250_omap, serial8250_start_tx() then
> calls pm_runtime_get_sync() for a suspended device: that sleeps, and
> omap8250_runtime_resume() takes the port lock again.  A tcflow(TCIOFF)
> on an idle port is enough, if autosuspend has been enabled.  It was
> allowed as long as that driver used pm_runtime_irq_safe().
>=20
> Share the part of __uart_start() that deals with runtime PM.  A stopped
> transmission still does not hold up an XON or XOFF character.  Let a
> pending x_char count as work for serial_port_runtime_resume(), and keep
> the port from being suspended with it.
>=20
> Fixes: 8700a7ea5519 ("serial: 8250_omap: Drop pm_runtime_irq_safe()")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Karl Mehltretter <kmehltretter@gmail.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Tony Lindgren <tony.lindgren@linux.intel.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D2

