Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795763;
	b=Uio0FCwTdxJcCvP7ADpuo33qwJ6A3b6/GW0YSE4LeEM0fvlLhmZGxHe3o6z+5uONzXhv
	 xtpZRmK+JNUVwy9VpFnINE4IPR6rDQyXvFCk21ypsgLj3apkNQlY5zZBoMx5Nd3S0ge0e
	 F2VcH5hfo3c2HiIm9lx4LuELa6RFt3sCLz9SXqS+yleKKwJQKss89wShSVymFI9qKvbJ4
	 c8LUqTYYW3Mzok4P8k4aZ8HAMhBCp1hYDK6n1zDju9w1LP7SC5UPAbAav5XArfTiXPzJy
	 jJMMWX8hllEYHuS1Sd5ERMyeeY1LXb+L3zsIxLghqUz5GA3FdPQysfPj9Ze/WEK3K/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M5aGoqIbRmroACjryODd85LNWXJP102euSgXfNELYhM=;
	b=b+uJRG6AOCqJLKELjA/Mr5LOqO+bBuzNGmtRFWrcn17EY0SIO8DlPqT8anvzZ7I0/cXf
	 u/QTUAj3oO01wexkpBML/nHBagmh2ntDneTE5zymilBLtTplBg7sm8Wtu7Da3vThqLsh6
	 +9Lv6nvJdPSNuvWdv7ZrYio9mzvH6CNzDD0FNbk9CDJ56/GyPKcusJKQByBsAbfmGXeav
	 XqpNREf+Q86egayg9nGP+WKFN7DCNiAHbqkpSF/bXe1l/0sAGS1M5vzFcdMtUfheUe3+3
	 dV0vrvJsRIOXg0RZMOFevqDX+ws+vUNi7M2dnWCS7RXde2YU03ksepKhEBb1vM5f3yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGxLt696;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FB606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGxLt696
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E481F01825;
	Fri, 23 Oct 2026 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795762;
	bh=M5aGoqIbRmroACjryODd85LNWXJP102euSgXfNELYhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGxLt6964/Bg4LEQjhuKDBuSTQR1xCb6vjxkDSj8Ki6MHleGIXdXkhbH19lvphXD0
	 OV+fXdWPJwumpMoCSrlELBwD4HsGLZ2hOaquYW/nhck33lPT9azQezRwaDmfOpxLDT
	 fZW9S1M6IqaU8MJJXWO2KnErV7yQ/5ESfMj6iojbBhMpHkhksSp7OZ1TpXzptuT+ZD
	 av3ejU2LkjjQgFXbz06mOdZOYLtlw3zXwgZNlVb02wBf/Afvgq1/kmb0hq7Um6DVfO
	 XL4ovpWlLHdR6i5Q5Z3VEnsmTqo4ytzlFmmF0eju825RZKN1JXeq6sTfpTTd83t71b
	 +yjlMgFn09BGg==
Message-ID: <sashiko-outbox-183318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v4-1-e759de1839de@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v4-1-e759de1839de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:49:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com?part=3D1

