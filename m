Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA7451996
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932396; cv=none; b=C0IdyndMx/aNCerXnighgkTmpqlHcSQi1L5p3UDUWA2gL2LjFVQ6Vzr7Y9MHPAqo9/jqoc0yXqD+3BafvVjvQfJlZjIXXzhTF0TPW9rYg/XV7RLpdRQt2+ZmzXvi6NqbAslJOV5YIP9szOfRnkqHbcsLCgw7n1D3qosgtdqVAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932396; c=relaxed/simple;
	bh=F+/A0AGJ/Bl4B29a0AMrx3A0qkxioR9Jquzdcngf+Ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ec/PXtZ0WVkuYrIvyfpPEdpzibiWFdF5vxuVx+r3RgslAQq9VUfJXBchfFR9KGPIgupuM4HAGq1NnnWGPVM9FrZjj1bwOPPAE1yaTIYoLLnX4Wip2v236iwA28xgC8Ylf9RtHUo03KFL6s9pbGDSqOwsjEUm8gq0CvW/vtPGUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPBVtRFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPBVtRFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2551F00893;
	Fri,  2 Oct 2026 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932394;
	bh=F+/A0AGJ/Bl4B29a0AMrx3A0qkxioR9Jquzdcngf+Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPBVtRFdgdeuUSpaoF6qh5g8Pbd/DrASzkqjMEe8IXNqx/ZgaCbcDX03w5BzKWT6b
	 NeJc8gU7VsBIt+igx98tMdY5amtl0kmRp1jpqB5TLNj0zMMk2sSC7+hAg+5r1CLJFR
	 23RmA7xtk9qmqoNnOznWoOq2Uvm3VRkj3Kq3lx7yhzyusi4JD2DscEN65LIy5NjySR
	 D2IJ/+ErxQEg5h6LQa5whWRybvO9NGRulRKRz8+CXlfzA4SMl4B7HRSHyvOrTFDZTh
	 5xCrl79DWP/l7KU1bfiqkbVqQv6AydRdnlwSk2mBiuhtHYINTU86BPeqJFcdD/HueP
	 uCz8S+WHz+lzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: tegra: fix RX DMA descriptor use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: Austin <austin.schlegel@arthrex.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001-tty-linus-v1-1-ecb8576c802d@arthrex.com>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
 <20261001-tty-linus-v1-1-ecb8576c802d@arthrex.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:14 +0000
Message-Id: <20261002091314.BC2551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Austin <austin.schlegel@arthrex.com>
>=20
> tegra_uart_terminate_rx_dma() calls dmaengine_terminate_all() and then
> tegra_uart_rx_buffer_push(), which calls async_tx_ack(tup->rx_dma_desc)
> on the just-terminated descriptor. With the GPC DMA driver,
> dmaengine_terminate_all() frees the active descriptor immediately, so
> the subsequent async_tx_ack() touches freed memory. dmaengine clients
> are not allowed to touch a descriptor once it has been terminated.
>=20
> The same freed-descriptor access happens via tegra_uart_rx_dma_complete(),
> which also reaches tegra_uart_rx_buffer_push() after RX has stopped.
>=20
> Move the ack into the two call sites that still own a live descriptor:
> tegra_uart_rx_dma_complete() (before the completion callback hands the
> descriptor back) and tegra_uart_terminate_rx_dma() (before terminating),
> [ ... ]
> KFENCE reports, tx/rx byte counts in /proc/tty/driver/tegra_hsuart
> remained equal throughout with no framing or break errors.
>=20
> Fixes: b31245b94207 ("serial: tegra: ack the rx dma desc after transfer t=
erminated")
> Signed-off-by: Austin <austin.schlegel@arthrex.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tty-linus-=
v1-0-ecb8576c802d@arthrex.com?part=3D1

