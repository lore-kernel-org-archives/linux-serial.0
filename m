Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145252;
	b=HSNzv6QWouoSDYlu+t+mq1vIYokNckCk9VTkQ0b4hkArXCirNloKkUdOV7r+91nrBCuv
	 5qcN4Ptb8G8198hwVnr+KJt2lcS0r+nEWnY91kNq88OcUwSEKpf/Y9Ehx/j5VF2DR6UJo
	 65RwJVZ8EnRmGj631smWbGslxEXrTUQe9HUZWF+/lpTzs5sHGChbaJcpOvKFgepATYOa6
	 sKE/uceAeHR438GwrM4GHi17Fq/O6qQgdPMSWyj3XBznFNzU+rFhF43OOeaSqWgf3sdpD
	 ZJbiN2tKFUezIgwPQUf1d4A2abvskpFCjzz3yz0dCd8iWvnt3iBmMxm7OtsRJufjT3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HhSUa4OGz1uXBea2oR6mWk4vuUtKSppc5BwgEI6Z29U=;
	b=Shdhx0TWXTMzaNsxYRmL90kx2gXMHKV6QTmygapJfNG4AaoXIBSB3ohE30fVgdOb4Ggl
	 bCBKdSdznMW1+qqBRCT0uQoj+GSnTvTusqdaaBeELkMnYmsNLpHSgbbMBDP4sgoxNVc0r
	 9eIAQ26RBQqbsDtTCq24mT5Tpkb1B8Y97vvztE3Cm+14VhcXap5CVF7Gg6XC8XOTwxHPp
	 Yc5nYQcEou8QQ/CmDTihWrV7jjgEAVQlHpuY/XqP1lTwfTrKIVlyqrtBntJHT4NTWtEac
	 XeLa2RfS7xKTN0gToTVZqtP6TtVjYcLQ5NCEjJlKlINhoYzNAjirLhF6chaO3vxFujA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYudD7Q5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811B606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYudD7Q5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D14D1F01825;
	Tue, 27 Oct 2026 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145251;
	bh=HhSUa4OGz1uXBea2oR6mWk4vuUtKSppc5BwgEI6Z29U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYudD7Q5agSrZd5MGSDsNurHl0DSBNZARgq8O+yfkNM0AqZBGE831pOqC1yBsfRP5
	 E9CGz0U66jZMS7kXrK53ZS+5n5RlBOG8eORaCOsTOUU2CAHBmTpNCoj3JbJGsxAqV6
	 tgDljNoyfao6GwtQBZNT9rGpsHKZB76OUR1l/KcxqqRu8vOVL5iHq5wN4+oV4I0sTL
	 0oHIJcFs0osdQEkDkO+xZ1OMiWtDcgoej6J7y/H8OrMJXMjNk9Myvy+y9GZmIOrtUy
	 uY6Ft7jCrjazrBu6icfMpTO5wDLO3iHxfmLaxPsDcNARl9r2T8Luhu8cD/b65tWUHs
	 FHTBy1CLSxDOA==
Message-ID: <sashiko-outbox-187242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-2-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-2-985a023ba4b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:54:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.
>=20
> Take the port lock around these notifications or their transmit helper.
> Keep sleeping SPI and regmap accesses outside the locked region, and keep
> the FSL LPUART completion lock held through its wakeup. Acquire the port
> lock after releasing private channel locks to preserve the ordering used
> by UART callbacks. In the MUX timer, publish available FIFO space under
> the port lock and keep the hardware FIFO-drain wait outside it.
>=20
> Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> path, since their interrupt handlers now acquire the same port lock.
> Preserve the caller's interrupt state when releasing those locks.
>=20
> [ ... ]
> This serializes write notifications with port-locked serial-core state
> changes, allowing readiness and transmit-storage reservations to gate the
> notification without a check-versus-shutdown race.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-ser=
ial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com?part=3D2

