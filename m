Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947407;
	b=H/YHzxSROGylIrRwOgQ49sdpiI0NEmOcDVPoAxboS22WahtqKTe6v1DsP0T2xry8rjy2
	 xrkW6Au7e/LdBTJVvDYZR7SmTVdDoWR564D7DD0EGKshSI+mZ+Pz0MBAEA41xWylqyEq0
	 6mZgMHqnXUs7QM0E6+s0h8H8M1Dkq0j0VKiJTlvp0AS9P7Y3JcI7COvCknf0Zi3y8FK2B
	 c+xRFKJtLZGSLZgJEek4gXvlfQ8FNXYxwUVlk8ShP7aAOQT+tzRUBDZ5kkiuYGecZ8zqX
	 tRE0cAxFFdBO1sC7VbVja+MgU2aSdsHmZJXLGuOeR0KVYKNmJLzdeeHD7z/Z1LdFZ2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FzVuL6icdyCsBMzbJyAWMFc+z9uLJthy5V9FxTISVjs=;
	b=pI1x5SDtR6s8J0X3w9Q9gdA8kcB6JMlB3LSS+5GkK40wNaYBvTtUlT3V2fnPWmte9W5K
	 AdCsxs2rJQoewbuWmVSLpEl2Cruy03wnf0NJlBmiJEz4gKhcGeP/y1tLpPr9EJ8bS+LB5
	 GRvlqHJ25wAaQglbPAP3wiq/8yGmhtD5koprwkc8jiCrYQAyg7nY0PSSswPbwfYBR12eb
	 LcYfXgwdU5gKWQOM/BFUddaCkCsuiEQW7KxITG9eiS3ZR11ykUvhXPyodC0WCPjxyQGcK
	 wgVq40hNABMk/hIgYPV++e+CgUOQvcT+CagyzPbPy9+honXJy0hgGTJVbFUpXrXOH/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iETBb46Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52698606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iETBb46Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D2A1F000C4;
	Tue, 17 Nov 2026 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947406;
	bh=FzVuL6icdyCsBMzbJyAWMFc+z9uLJthy5V9FxTISVjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iETBb46ZqJIpcYikjkPItHYolGgy0KwhOzqpOtRJPnQBP1dDxeiTYrUoux/p3txx6
	 vK3Zy/0t/Lz3bWB3tEByFN+pQ/mlrcGgG9Q1oJbPbqj9Mnn2ilTDOc2/okt3s5XVkG
	 O/Edjb4M0TusgyfRlp5tiVOEBTJClhTdnMOjDxBGS+RZthTvr2SY2L/DKHjSLaAfWk
	 UvtuzCMbui9as5dtCgO5KqeHYVNfsw6SSruufC/IavIRx+pM9G28In5tr8nRSrQNOQ
	 hR9Vd5RPGuZ5giYT9JLiorMxGJLmoZuOuchZz3e7Z82D/ut60fz5RtOje39mrZBmY1
	 5uADbhGMGSxHQ==
Message-ID: <sashiko-outbox-219608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/16] HID: ft260: group sysfs attrs per HID
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-10-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-10-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:30:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Split the single sysfs attribute group into per-interface groups based
> on chip mode (DCNF0/DCNF1):
>=20
> - I2C-only (mode 1): I2C and GPIO attributes on the I2C HID interface
> - Dual mode (0/3): hid_over_i2c_en, i2c_reset and clock on the I2C
>   interface; GPIO and UART attrs on the UART interface
> - UART-only (mode 2): GPIO and UART attrs on the UART interface
>=20
> i2c_enable is GPIO-related too: it switches GPIO0 and GPIO1 between I2C
> and GPIO, and its store updates gpio_en of its own interface. So it is
> on the interface with the gpiochip, the UART interface in modes 0 and 3.
>=20
> i2c_reset is an I2C attribute, so it is only on the I2C interface and
> not in the UART group, which holds the GPIO and UART attributes.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D9

