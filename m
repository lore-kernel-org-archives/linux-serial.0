Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145797;
	b=ByW4C+C6QE2ijVRFjorwOffHA6hOZ8aXsGJ9rWtywsXyAnsCJYgfiMkCpqh06nM/7Oya
	 KR1uZPMufjqwznDsM3Eu6EdaxdE3XewtBudNgQDuEnN5bqG5trTQmd7Xllko7PStHr3Md
	 XqfPoCe4EdJJNUZwy2Ib8zyzaG9P+58ibvG91MUKZP88rN1hu1DeWjYmy4hLQhzeR9OZc
	 FWV7byjkOMdKYnoufU5zcTlbVQNTM5v1HB9qXi3tHEHDNwJMmyk8WX6137mGiiX2vskGg
	 D+OuTqtfviNTL71kD6H4nFAY6jPaLEuOsia3YVzuFUardNs5o6KEz2b+j7NLBa5I4gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145797;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JtozCj7kGaWzgsGlt9NqLNmI/z3InruJxiV4sibxWRU=;
	b=PHPrwqVyNOWkBIqecMnMDsA0DFF//nO2h4gz0GnPaSijVZp/ulFefoIea0mVjd/rfm5s
	 wuRibAd/3s+sh7uYwhoBK7HK25Hrne94QcrHQ2YL8UgHMrTUvTRCOlcP3a0AKhenmo0o7
	 l629D+EwL3hoMZEHhj27o3tG71z7vGeewLnD8LQFyVVa/9nqVJJe7mNDC6+I7rx2vTMLw
	 p6o0x53/s/N2+KN73Iqx/0SEtvM7RMlKOR2gWyuRB2mC5dyjoAO8HVP8QQzPEoR2fappI
	 VPY6NlNKt26oCyB7lrULCD4GVuIjwnViYaTG9OJ5kVSOjegXx8Xst8PiasFWkIv+iHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjJW0OIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD3606A31A
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjJW0OIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA1E1F01825;
	Wed, 28 Oct 2026 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145796;
	bh=JtozCj7kGaWzgsGlt9NqLNmI/z3InruJxiV4sibxWRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjJW0OIncGXTm3CTa8X6h05p0Cz5q9RtkuPTd5s2mKLUo5xlF/SYkU7N0Nb7JJAyF
	 d0cOES1X6ya3gayg+PvnY3SZriyeHH2lkSFEBmVdlOFWedAdXSiQhX7zfUwFZjym4V
	 GvvQX0kKkezRVcoj9Qv8LPRNJTHRTiMAGNRlsWvNXzQeptFuMSrY8Ymjh7R411ip+J
	 +eJLOdz7euzPW2TMcs2TgWXIu7zE1lKyebrkvj1QjeB3hxovNh5NY5e6R7PRBYSCEE
	 runCHaO9xe69m6l1V7yk5fnCifulxYTHQlTjJUbZF3ztbrJXqbtlAnBQ8A2iS55zLx
	 qgA78lsgi2q2w==
Message-ID: <sashiko-outbox-187247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-3-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-3-985a023ba4b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:03:15 +0000
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
> reservation is released, preserving one-shot TTY wakeups. Keep the flush
> wakeup under the port lock so it cannot race another reservation.
>=20
> Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
> high-priority flow-control characters, which use separate storage.
> [ ... ]
> Publish resume readiness under the same port lock as the TX restart,
> without clearing any reservation. A concurrent flush can then reserve a
> new transfer without resume releasing its storage prematurely.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-ser=
ial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com?part=3D3

