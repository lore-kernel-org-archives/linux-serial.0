Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471447;
	b=w+VemcxcBogOfZmXGeZI0fn2mQGxSMl0eqi7hfO9+lFpy/k2weiMKUb1MtHyNc01CL2C
	 CpHmmZ5WZhY8jzLGQVoOx1g6CX1d3uZUEkNWQvoOmSnPZy4b1ljQrrV1p4V4m76bTgrA/
	 D9QP00jbP0tyAPJZ799Tc/v9ejzFFB9Q+dpdIzlEejkmPG6h5kbaymuuAXJ0piOS7yPw5
	 D3Pm51GFZE1+JbN+Oj4efsgupZosgaFyopOZsPo5chHnVrf6E5AhbF7IqJ7aMtkues+YQ
	 yU6b8H3xo4Q+ZJIyn0wpzGZwJTYan3HuVZIWSJlAhSsMlTnQ+PZwwqam8XGWRzhs76g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mHnAtc1uMbP9BQ0yfxjZH50zEkGKKWMjzb+R+FIdANE=;
	b=WYLzpPOLqpsgCHfnI7fNWtb4VT4BWd5JoG22Kfq2P1EurZ4y4p4EobaCw1+PeOkArisu
	 0ibyyh3Tp762NuZuP1z5su7tDUgT7RAt6ko1ScREFwKr5csdAeYvr7hcch0FKXdhEfpeO
	 tYuWpS6oyzEwmLMMW1q9Paek7J+hyst8AbRm1xdW3kn/F2NGv4+iNTcptJOLPtIfACfvF
	 HSIM20Z4/RiX2cgFWfJ5n+IE3yhRkEL6SKJZW6/nYTaXHGDvACK/ABYOyyjZdH9GVwRRl
	 vr+vTir477RluyYzJbCOXJkg40EMBux74ZMR9GiQv/90nQlsBXsWE8MYxqyVzwWtl5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVBZ+bTC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24277606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVBZ+bTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7284E1F00A05;
	Thu, 12 Nov 2026 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471446;
	bh=mHnAtc1uMbP9BQ0yfxjZH50zEkGKKWMjzb+R+FIdANE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YVBZ+bTCZDlne4uadorIoqm/cc9RvK7WXkZwAIgmvbRxKOud6Z4f0/aQdN+175ZrX
	 UIO3nK0A5z/dFJOKm/twxBow/BFL/OCQmgvT7PlXR7FgCa9MhswZXIP30tRwYdQEEh
	 GKCfmzZ+IE1tJXiMlPkvQ9wVZ713OuwdyYTuHt2hTkHNX8qyv9iGKDkrnIPikxTUDh
	 Yy2tXtQATiXhxy+if+SCIAUZHtQVQv2IbWAK+VQeLqLy3RzHPVSsAObixgy2qTopMs
	 3WEVw6xrHIAXs24pfi6Ic+mM7iRMcEWb99qinWOLGZj6uV/SW6LU0nMQOiKnQB9E+t
	 MJMLyVkg/GWIw==
Message-ID: <sashiko-outbox-210685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] serial: amba-pl011: end an RS485 transmission
 when TX is flushed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-devel-nbuchwitz-pl011-rs485-dma-flush-v1-1-6b811391651d@tipi-net.de>
References: <20261112-devel-nbuchwitz-pl011-rs485-dma-flush-v1-1-6b811391651d@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:17:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A TX flush during an RS485 DMA transmission only stops the DMA. Nothing
> ends the transmission afterwards, so RTS stays asserted and the bus
> stays driven until the next write.
>=20
> End it from the flush, unless the TX interrupt is still enabled and
> ends it itself.
>=20
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-devel-nbuc=
hwitz-pl011-rs485-dma-flush-v1-1-6b811391651d@tipi-net.de?part=3D1

