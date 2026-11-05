Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863578;
	b=OvMV3zmHl3SASiZ5ncTedi2+ZxSNrxklanNaHXpmlLagWTtKl7DYigAaOBP9AN0ucOaX
	 SLlK6+O6JqziE/dME3Z/RqNPE/eUk/xAbWizM9S34jgw6NX9BkhH04FSXOtA57xagZQgZ
	 QH+12AKxtRcX0KPMrSQ66fLwG4shPWiAKMtYPJLCa9/C+PLOO2eaQdLI/+vTRnBZHJyEg
	 ZTy3tw7fDpViGwB64fRZKjXy9qRBaeejLYBfxh5W033bsIM+Gp6cH0GUsEcrS/XS7pWMi
	 gOusGVY7pqEVMhPEhKHJ4FV8zoYsaEa8QhX0BNDr0/Rxbu1BS5aCecVjdYpJ9At3OyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TtC5hda0oyUqmImH18ufuzJJlwIUVt23JeYLRwQS59c=;
	b=BMh3Ic2s1f+0M/RwhF4/xZQcFgXToKrwAfIdW1xJ1fZ17CqrMGv/COlHHvnTsGw8kH00
	 KWYPGksB/ZYbxT3M1eUCA3heGPYMFh7HEm8flTLVULnqihW3x/R9eUV0rt9Yx+8qfqTIV
	 18bG8S2JDTs21njW7E6MQ5S6oVR3o9X8qDkvooJU36ZRji5dzygyBDdceFMAxYGutrciC
	 lecdYqCDg0Wx7K8Pxwy+WxwEjSgrdt+vq8Phi8RuTEBgJ+so/uRb+4mzghaKq8N87OX1D
	 kAronCXno2EitC0w6/TCXWZEyLYwMAotNTN4QWjC54fRVxZG2snFtf4hqNnB0t4rnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D+MCvKl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC8606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+MCvKl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122981F000C1;
	Thu,  5 Nov 2026 07:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863578;
	bh=TtC5hda0oyUqmImH18ufuzJJlwIUVt23JeYLRwQS59c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+MCvKl/HA2u/95ooRgBidIX7znKvF9Rlg3oNx0wxYExDZXk84rmmtZ97fL0lhofL
	 GiQQY6rz8tjuxiRUhBW9kQmBT3cDX+mjAe7Ou+cVFahc5H3n7mEWpSEbfFw1CrpeLE
	 rRks5UhNwGr174iEuFP2gcZNeX3+xoWPPbnbKhgZJozhZD2szcv5VVFxhQZ+LYdHB8
	 ygQI9Y5h20L2eTf/DbCZlOkyV53CXJrUrdI73SsV2qPKEH9vkWb6Y6mELySRV8Suzf
	 3UXeA2MWBjdGW/Yg799KseCz2haEfpaf3G5Ip+O2LBHwUfUODWW9Jglwla1Ew0nFjt
	 kreuIKzMrr0GQ==
Message-ID: <sashiko-outbox-198666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] serial: core: Drive the transceiver interface
 select GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-serial-rs485-mode-gpio-v2-3-027e5348892f@vaisala.com>
References: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
 <20261105-serial-rs485-mode-gpio-v2-3-027e5348892f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:26:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Multiprotocol transceivers such as the LTC2873 provide both an RS232
> and an RS485 interface on the same bus pins and choose between them
> with an interface select input. There is no generic way to drive that
> input today, so a port wired to such a transceiver is stuck in
> whichever interface the pin is strapped to.
>=20
> Add the optional rs485-select-gpios property to the GPIOs acquired by
> uart_get_rs485_mode() and drive it from the RS485 configuration state:
> the GPIO is active while RS485 is enabled, which selects the RS485
> interface, and inactive otherwise, which selects the alternative
> interface, typically RS232. RS422 is a mode of SER_RS485_ENABLED and
> therefore selects the RS485 interface as well.
>=20
> The state is applied in uart_rs485_config() for the boot-time and
> resume paths and in uart_set_rs485_config() for the ioctl path. Unlike
> [ ... ]
>=20
> Drivers calling uart_get_rs485_mode() need no change to support such
> transceivers.
>=20
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-serial-rs4=
85-mode-gpio-v2-0-027e5348892f@vaisala.com?part=3D3

