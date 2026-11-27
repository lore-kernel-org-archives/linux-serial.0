Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787275;
	b=urhiQ6vH8ggRzu2V78I6OVpR5TnKJyNFtBZQVY0Lpzd6grNPhOgIbYG28Hhu5336j+F+
	 zEzo+zmkwRhkXZ2qFJvh7hwzgAyDe7PmePHQB3WB71d8rKIG77b25ajYxn+q6RgPrgk5H
	 MWH5H28EzlU9egDH27T6c8Kn6qNlbM4Tvpt6T4HkvM1/46zphG6B4Bc670515QEwTBgp/
	 IOrXVx/VIHZG/2iXh7Y5zXMC4AKPqteUFTJf3SayUgNqZK4WaFaX/o6FQMul1cTqnQ9yY
	 yV7nbCoaQosYsQlzpp847I/NYayD4VSlZJ5gFy3YXH+9t7RKObaddIUZ6GcVxxyWYeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NPGtWeNgMZtsp69k7i5rry56hfhRDUCKl7ab9GRRKKQ=;
	b=Soeeir9yEJy3TtwLkdfcIRNdfVscaWOv1IbMmt8GyatKdV2rs+G09yW3s69apYZ3pVV9
	 jaCHs9Dc2Z6GvBm0GKiuRCwIO3KZSmXtYITwSiCJCeb0fdf3xVML7DcjdDB+wHwM2WLmq
	 dYwobYY5vzPWhQm7EMq8fEDv7Jk8M3RQ+F7yQ2M//45yvpJ6UIHtjclFRxAbudnlJGN7q
	 lU8xzt0r3MgtXdqgxKqXJ4C+GNcsgahv1oOWXCQJSE1EcC3he+E5vJBxAmkFOFj4qcKbq
	 49y94dymV/f6F7d6qwFqat8RoiPinAsC3c9kbNqYodZlgRICUd71ams1eYsxRyc1vBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8gSboNa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48359606A330
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8gSboNa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC31F000C1;
	Fri, 27 Nov 2026 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787274;
	bh=NPGtWeNgMZtsp69k7i5rry56hfhRDUCKl7ab9GRRKKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8gSboNaawdpaKhgjKLTLOUr5ZqUwfqMOjP7WDMTDSb5cJ7lwRTY28GKHYmntvgfo
	 Dd20jzNDNeqQ9Nqo5E5CufuCx3evdy1fKsgSmTtE530arblL1nSimaqMgqaUHvitoB
	 5v5Z+711TVHnAQ+DKQs80mqblZfCzdPNhYO7YEEQKxMiyepUtMz+HEslcTIwa6COW8
	 xuMz5sfjs34iucgRn5vUh1WZGwskMf3CjrvgK3dZolqAlOzYMSucsm1/Zn/eBFqLmC
	 yosK3DNwKVqNmHsx5JXznU/FSQZxCnifSgCX3eBfpZizVpkZA2A0aU0EcCio/LrDJk
	 qTmnvImZt+mdA==
Message-ID: <sashiko-outbox-237514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: rsci: Clear TDRE once per TX FIFO refill
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261127-divo-ssgrlpcsrc-2996-rsci-txi-v1-1-88e1614ea0b8@renesas.com>
References: <20261127-divo-ssgrlpcsrc-2996-rsci-txi-v1-1-88e1614ea0b8@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:47:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> rsci_transmit_chars() clears TDRE before each write to TDR, going
> against what is stated in Figure 7.3-17 of section 7.3.3.8 (Serial
> Data Transmission (Asynchronous Mode)), FIFO mode, of the RZ/G3L
> hardware manual:
>=20
>   To continue serial transmission, write all transmit data to
>   the transmit FIFO (TDR) by using a TXI interrupt and clear
>   TDRE flag to 0.
>=20
> This leads to two problems: (a) up to (FIFO_SIZE - 1) unnecessary MMIO
> writes to clear TDRE that take a significant amount of time in interrupt
> context and (b) a second TXI interrupt is generated while the first is
> being handled. This is described in the RZ/G3L hardware manual in section
> 7.3.2.2.18 (Common Status Register), under the TDRE bit,
>=20
> [ ... ]
> to 4096 TXIs and around 159 ms spent servicing them without this patch.
> With the patch the number of TXIs went down to the expected
> (64KiB / 32) =3D 2048 which took around 86 ms in total.
>=20
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-divo-ssgrl=
pcsrc-2996-rsci-txi-v1-1-88e1614ea0b8@renesas.com?part=3D1
