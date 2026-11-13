Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565046;
	b=uCc4PjXVZlZNWxS9Am7VaneYlkQIEiig64jBQcb7Ftodhck3nW+MooTGm/IS0JxEbAfz
	 ioIMHahPMjNmTTmZftOXFL3dnaKAmA0mEomgFNP3Jt9WrUYzp/z+dMyWBsyLzEeeh7yVk
	 8IDfvh8uZeArFi2z2hiVHi3tCymviOeFU3DDTdt+w8/KmGYTMk8kh2lBOXv4vMCHwLjfK
	 6NIljXL5il2oPDL/Nl9dWhHPjfVqtn4kOdpkubYVs/MH3KWa6+inOI27J6SHxv8COi+ZZ
	 BasjOjxFdT5MBSvL8VaSTCZL/C3Z1ZORx9DxkwWJwb2vzQvi2Txf4C+XRRGHjG1DrPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+hiFD2zH9tNkYO+ArUV69hkymoW41sH2C6ZldP//JNM=;
	b=xuZhQirO0onw6SM07LdBonh0UWMmv8uNEsPcQ+1Yi6keleBym9jneNBuSha4PDKJf1Lv
	 acr7mX2ABJBlGizB1ysyoQwjHdvMKn0CGNdpFEqXFp+czQL0wEQ/bSb7cgcrBr272m6h3
	 6DKH+TXtX8U+ExV45rIXbhYWA7IfbuYJ6oBHAdLnK9IxRWWqTTG5hkdITxLstW1xOvwfb
	 pWDdOCXUKJ5VVkLkAkETyItQF/8INnuIcIT8DxvfbZyqVLp4XUutyyil/2ZxGc0D9T+t4
	 IdEwp5J/j7OsZ6C860cZXlCHBVnlS6jj4BfheaOfif0o0gCpBWiSvxDNH3PB/goQs2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAgZBUI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9B606A331
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAgZBUI9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4C51F000C5;
	Fri, 13 Nov 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565046;
	bh=+hiFD2zH9tNkYO+ArUV69hkymoW41sH2C6ZldP//JNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAgZBUI9sHxZBNDXd6OXp33GW4pjaO4KVYmM28KZ1ITap8eckBrPIm0R1IE5a6c9m
	 Bu5S0IefQZDEvY0VIrQgF9K6wnGIm5fxqSlBD+eFXlBm/bbN+9L6yAR9KTYwluRql4
	 6PS9nLo38u9EcM+0VgFIrpqDgViLsSmYlVlgKU4OkYcIZYhKN8XzNdBpQTyPRKD+kc
	 Ibd1/6q8dn1GGOjWcwWBc2Zu16PxphE8I5JdZLR9a5TTP1IDUXN8YyzpkHmAbyjYy1
	 HfYaLvJp54hi7MO3U63y+mESNMFm8aTmAxeQH1uUOU4tZ6/6UB5UN8KzMZoRnoa58A
	 j6O8BmhdCOwpA==
Message-ID: <sashiko-outbox-212615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-5-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-5-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:17:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_flush_buffer() resets the transmit FIFO before calling the driver's
> flush callback. An asynchronous DMA transfer can still access that storage
> after the callback returns, while a new write can immediately reuse it.
>=20
> Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
> flushed storage until its transfer and completion callbacks have retired.
> Serialize the reservation with FIFO producers using the port lock.
>=20
> While the storage is reserved, write_room() reports no space and write()
> and put_char() accept no data. Defer write-ready notifications until the
> reservation is released, preserving one-shot TTY wakeups. Keep the flush's
> write-ready notification under the port lock so it cannot race another
> reservation.
>=20
> Wake tty->write_wait after flushing even when writes remain blocked.
> [ ... ]
> Assert the port-lock requirement at uart_write_wakeup(), alongside the
> reservation helpers, so callers cannot inspect readiness or release a
> one-shot notification concurrently with a reservation change.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D5

