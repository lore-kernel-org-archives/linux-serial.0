Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFA446821
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932396; cv=none; b=lDVltpmyYZvQoAxur7yMmGZmiqErxfzKBEROVFhuiGDn9ZyFcS1f3vFMRM6jKpruPFunBzbCiFbKZef8C8efAaburA9F9aCPwKqps7jGIa1GB9atd1iQcuRuFCROgfNGbbwkstNEodY0VakGAr7retnRUGKe5CJSRlCeFC4GZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932396; c=relaxed/simple;
	bh=hI17Q1bSHhnZrvga5TYsaovr32fRuWv5S1izpjytxwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4ZxQajuT9+s4u/sal8a83GBOVUATit2W4pw/9+cLrGCwCjh0ZTJ4Vxin0NprVSOUKld75aZnzbwajI7X+ZPO7ujOTNC1c0+P9JB6yJnhJ43zeELGbIMQ1BA67Iddkd0RqVROr3o9jwDfvi+cXyA80ywoiu6LRFNt7D5uPzzK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Fc9wEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Fc9wEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4DD1F000FF;
	Fri,  2 Oct 2026 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932394;
	bh=hI17Q1bSHhnZrvga5TYsaovr32fRuWv5S1izpjytxwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4Fc9wENXNS12Mpf0+6qRIoX4fkZ5Nib9e/aFWyWAZ3flwzEYQ0mjLct5/Wv/Vyrx
	 T96hZeL+txugXCh88RqbELWQCCYFnfiM1OliEF1Lqby0bVYfgQROfeBIHoT1vJuz9s
	 I3bFu5xif6HvJDi+JLyMF7PFdTMCLEKuxNIzeF1lkY7Y7vp/EF7YMP/EK0Cu3yWFfE
	 ETZPo+kQO79wlLnyqX5AKbm5bEjnm3wKc2KXfrDiLlvciwa9PJ2DuWTCWoctK7dUB9
	 nb4nxwqjB0tIXO9IoUuuAXJYX1FXrayq6o/vRZW+FBV33OufhQoqJFh3Qi2aHLnIlP
	 nkXhbTyOzZ5JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: tegra: fix TX DMA descriptor use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: Austin <austin.schlegel@arthrex.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
 <20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:13 +0000
Message-Id: <20261002091314.1E4DD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Austin <austin.schlegel@arthrex.com>
>=20
> tegra_uart_stop_tx() calls dmaengine_terminate_all() and then
> async_tx_ack(tup->tx_dma_desc) on the descriptor that was just
> terminated. With the GPC DMA driver, dmaengine_terminate_all() frees
> the active descriptor immediately, so the ack call that follows
> touches freed memory, the same use-after-free pattern fixed for the
> RX path in tegra_uart_terminate_rx_dma() ("serial: tegra: fix RX DMA
> descriptor use-after-free"). dmaengine clients must not touch a
> descriptor once dmaengine_terminate_all() has returned.
>=20
> Move the ack before dmaengine_terminate_all(), while the descriptor
> is still owned by the driver. tegra_uart_tx_dma_complete() already
> acks inside the completion callback, where the descriptor is valid,
> and is unaffected.
>=20
> Found by code inspection while fixing the analogous RX bug; not
> reproduced on hardware, since triggering it requires stopping an
> in-flight TX DMA transfer (e.g. via a modem control line or flush)
> at the right moment. The RX and TX paths share the same
> dmaengine_terminate_all()-then-ack structure and the same root cause.
>=20
> Signed-off-by: Austin <austin.schlegel@arthrex.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tty-linus-=
v1-0-ecb8576c802d@arthrex.com?part=3D2

