Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426742;
	b=iwUrzO8/hgtzK3bOQ4uwwR3vRVp90h70ulBMlGK+f4sfhjYWsoSy6EFpVZlQZoMU3LWO
	 2KXGTjWr7I8M+g7CEOs35JP6UxjxPvvCbLNpFO6WaLMvdvEi6ZA5hKMS9PMpZW4X4xJ1k
	 FlBsYFrYfvWvIu5LIIJf25MhImwIUeJGOhj8a0OB54QCqQBdjBd8n0v07M+FuGFEIZNJp
	 Z5EHdqQjPumoU9VpDE6eScj6VjSZOE9kIs2/Dp4A20gC+0rAb9j+PX8rqcyEq/wojtpjG
	 GLEC77pBQRwPj4uulfg93iyJsTbwWy7U095LNE06PR+ATpqEHlP0JufdZEI4KntDeAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hvVJyABq3uS/3JiHc4W7LFqMTyl46jPggFYTN/PJ1Us=;
	b=mRSr0qeNvvYpZAplpfl8hjuGbHOEya5iuHR4GKTkvPsWKI7zrIfadlvRR9qjRiNOxmpj
	 uUWKi5Gk98Qw6SxZGWOjv5xG2RY9zB0pEEOKF7H3IN6Og/ZTMvMn15tg1NL6wZVHjVe8O
	 a9wIGGXSxXj3v+gzXURyY7+FHM8VJQ+pDbMLVgEy52m5zqRcucr0xo7fx2uHHf0dyZIWx
	 xhClruaisLiQXkB+LK7c3z4I9iCc06zUedlyaTi6Nk1p3ZF18dW2rZALNkin0HwxuTn1u
	 OrdjMMckXOz8Y8bUm5SeFuvc6Y2hdEi7gPyQpa9X4p5VBViSfVkS6Myc1OAO5lEBhYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlQd4tYb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7205606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlQd4tYb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B181F00A05;
	Wed, 11 Nov 2026 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426742;
	bh=hvVJyABq3uS/3JiHc4W7LFqMTyl46jPggFYTN/PJ1Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WlQd4tYb917yIyhaSDuFuS27hpcYuEDLojT9XKSLtSyGtKq0SyeDYOfJ/OT9ry2kE
	 XIXrzw0F3FloZ06UOGFnBkxSs4FRMculFhUUhe8ssvAnWCu9jr7bL6R1QAEKqEEJyj
	 OuQJ9JXvaKAIWw2c+4shvFdfoXlGgJDC9hnIwNH32xirbi8XWWjOtjRURcWnSiUUv9
	 LEUGBIw0SpcZbcHhJxFAEjdgk13GND/XxeRKzyw//jW6GKxBNVjdpD1ZzrlTdmG7mm
	 NMNBPktRm7BJT6VggG4vJ/sxus1f4MC8tH8KgCKziJidS9fCLa1b6ytW2ZJEiUvfNV
	 eGcZn1KtWZRXA==
Message-ID: <sashiko-outbox-209595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] serial: vt8500: Use devm_clk_get_enabled()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-2-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
 <20261111-vt8500-serial-cleanup-v1-2-b33594a25f87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:52:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Let devres own the UART clock, so that no probe error path, present or
> future, has to remember to disable and put it.
>=20
> Pass the clock lookup error up through dev_err_probe() instead of
> replacing it with -EINVAL, so that a clock provider that is not ready
> yet defers the probe rather than failing it for good.
>=20
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vt8500-ser=
ial-cleanup-v1-0-b33594a25f87@gmail.com?part=3D2

