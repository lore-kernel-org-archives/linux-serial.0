Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662351;
	b=o9wLJ5vtczztsjvgvkCcKtopZj3YVACsUpqn4nqFlEO5MLK7v/MFqrTjgj4xXpWuAi0G
	 Er6fxFoUbgZQM3/5TIFsgwHlJrNkeQsH7zLbD3oSiQkk/uENj8EnRCEZqYw2RsfuuXfmB
	 SNEiPwuXqHvMRh8QpfH1L8O2B0ASHTjJsoqE5y9rQBKeSW3gYSJIFdR+smlG9txj0a8pt
	 2Xam18uDVJ++4ELfuRWXunn2xu2nhhVSsE7JJXiCimxRiyabrKVJuR3k5QrgtAxPD9g/w
	 C6n8rCvEK8yb6dRWidXyA0kg0bJWeSUp6SdYD/MwieUCT0ZWeeVEMmtnFossijfJQqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nYGORg/byK2tNoCBVNX5CgeI5w5VBAoFSTDiPDAvh2k=;
	b=Rb7PC113fkWk9NpWBZqFSgK991NtqZo2UOxoQltcUgNIlrdk9DbCH9JyZg9x/JIOSj15
	 q2mc8l41xrZvzy9GzDDxsGX51vAVUC6bmcWxU658wEb2IvSAMy40mEenTKsHc9PGc8vBf
	 rdaMCceLYBNC5Ne9ZFxE1s+KOjvifBgO7sICwSC0rD1bznXRN1n/HwKD7JG2TpxQdJoTh
	 yCBe0SsRFGd5Wg/0GXH3m3EQBJUIiggpXNYIMnLauQgvt1GEplA2K0SaLc34TzWDDi1gi
	 /jy+t61k/o9Aq23Iev83kyNazt1UCOtMul2zDoNXiSFLo+b6ZPYdhBWe9ZxayLXjehA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxDY4pBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD94606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxDY4pBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747661F00A17;
	Mon,  2 Nov 2026 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662350;
	bh=nYGORg/byK2tNoCBVNX5CgeI5w5VBAoFSTDiPDAvh2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxDY4pBHAyemJm15sckraHyVtFWXGTG3MowXvdBgL/ao8zmUBFNA6LqGpJmOHRGIl
	 +x3TSgpVKY4jAUajfolFwG0ep7sj/q0tfe5DQQODz1nSIxUJFZQmg6p8GoSZLTIfJ3
	 zb1Lhz2W3SeUmr0OxOStxhjgpbFuTrLVRrvPl1knuJofIA2q4bwDytozZ6Osl62Ep9
	 jW09ltolPD4t7NPw1D0XlV2TeAyTLUacitHbj5FQrn4Qzh+0W853HoHaOR/m9mbDnw
	 1B+Egzy7+5u3wL/n34zzftkYBoP7bM79YOD7qgZ6xW6sT3IF+IFQkmRZkk6fonnjpZ
	 GC6gj6RUDKdyQ==
Message-ID: <sashiko-outbox-194336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:32:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D5

