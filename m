Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197229;
	b=uWL8+bzQ+X2jd6kwsrAWaXQMGAGchfjwCAboGEb6C6S+8OJl4Td13ToeTxYeaw9HBmFP
	 qrKi0xJO4kUTG8Xz0GIb5ucKBrEFuZ5FrL92MDjuGgEHcj/GR38T8O9sTKdZq7NzS13nP
	 hCZhe4Fw49MzT3dzm97b2PB1ub6eWZaUM63WmLUIbXKTkfyTZVH0cIzjVigsl5ciqV3Gb
	 Gzz1/c6pTSvX/S1ISZzPRwScDO9YUbgS0EvIY/D4XUzUQA5csA5f7oiXzUbcciR/rOD0p
	 gkU0E6mMCu1Li5tVWVQBmgBAOzFOyh21k1BisA7nXSPKR5YgDWcn3OYGHxYaSCX8qNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HwDWOaP2IiGeWXMY+xvOK7Ai2VikRnq6xi714zhRIq8=;
	b=FowZDQcRjVc/+A96aHZFNDNgiMgKV+s8FwkCoF3W7ys7C62c+nlfFgDqCCoOFP9dHdd8
	 fa3vFbt9WKWEiZ0p4xaQVfoWgXraw1rM7cqCBJEjGG4FZ7K5VRQhzM40PJqf8cMBmSbFx
	 2UkXhCobnPxTdr4XVr0HsSIBhxI9XeiuiTY6j+SdqcCaysY0l3JoI3V2ybWiWnoUOpwcm
	 cXaCzVB3uZrPaK/xTlgv0PQIfygarqQtlYgt0WkgiQVayTSqtCsVVMZZQLN1ZbiaV1v7+
	 /fr/j0adfEsdvTHqLfiEcghvaLr6qAwtbugUNSv+EUggeq/xiv59KTD9d/Z5dbMIuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iITJOkxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A6606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iITJOkxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2F61F0089F;
	Mon,  9 Nov 2026 04:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197228;
	bh=HwDWOaP2IiGeWXMY+xvOK7Ai2VikRnq6xi714zhRIq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iITJOkxlfhu7SOnKd5nPSc6hTIaiFIsstyR+c0ELy7Iiy2YY+K54/tCxJ1HsOhrjA
	 3+kaPSjegWC3Q4ZeLOII5NbpcaKyv13sVjJp+zXoWBEqsJfQocVoWP/hI8fWhgnfoI
	 CxCyFfmSd8CLizVmn/M0kJWoDOKSf+4vcxp//RnNIlX9W1c4JiczuDFFGcSJ80JKRe
	 uN102sct/u3w7rZg8b7bM2yE0uZV3nbfRpyFcli0k1lO2zQiDsdfOmHzIoBmXQVIZK
	 RRdykeBpiX13JbmwNGQHj/VM9pDGqNSS/DJHpTAvK2NZajZEVzlxtEkyquwRo2Pbqx
	 M8NSN/tPcCbTA==
Message-ID: <sashiko-outbox-204395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-5-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-5-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:07:07 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D5

