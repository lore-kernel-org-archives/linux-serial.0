Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405264;
	b=v3ThTH9fg14EQQg4FXBNTkLLVJKI/aR57l4frqi2bb2cFSlrja13p+TY3r660wFO5nv3
	 J0hl+dzaqXVwgVMJyn/Zo+F4dZe3pa7paLEzwL0RDWN836WGFKHSbUhHnFlFLWsyiVccQ
	 cfJC1Pkae7JJWqH67f4I4NOh8i9/iFwbEl5vBoqaJxT+niN7rWy36HmgOIrxgOm++VkHX
	 maZSTTqWKmqkhL/FMMhm1Rv7BZ1Qf6Gwn+4vNsJj0tvAEgHlHnkH48cbJOza8bS2Dfbvj
	 b7OiRnxQKdB+NlCOjPo5LXDLuhzlbeZbiTW77gxnxjHTdAKDMn5T7KUCN7n3hAcWaeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nA/zlXU6Xew09Ln4IFeStcoHiX9bHaGdV6JF2CsO+4Q=;
	b=YSi3tBZxBJvOTla+79ICMpBhy2h5UIUVv9bZoCBWGj1vQeWppCjkUsxTiBb5ECMh/HLe
	 0corHxh9lQy9pCyNIOKMY8Zv4GEOywJb06ZbJ8wt7QQKgPQvSC5qyooZNUW6rh0shzMal
	 lIJ0kQNqfytjCCDWRbVpmtqSVtJa/c7DwTviqL6NBJgGC5g7JDf4j9z+drosrgCm+IuAO
	 ikdJHUDbgcPDcmNb180NF1IqfN2Jp5rc7fWq/HIYr8gNL7s7oaBXaoQSp7xcrwqMqDp6v
	 c6DMug35TJ/6UL/6tbouadKJ+hGPA0TcArAjRpmVLfV+kYjAuSiKm9mt/pEjZF0cqXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDu1yb7c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D795606A33C;
	Wed, 11 Nov 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDu1yb7c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D751F00A07;
	Wed, 11 Nov 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405264;
	bh=nA/zlXU6Xew09Ln4IFeStcoHiX9bHaGdV6JF2CsO+4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDu1yb7cbPII0cHrbQ6RzX+CfY91xAcNFZe9hScONs2YlRmmLE5jE6r185121EPpr
	 m6Qd4rtjr0938NL67cyyqfKdZHg6B1t8hCxsl+xjWuRMVjj1zOiSXfSRiAydz6Ehri
	 K8XkHuHOC/boH+fqsbTTeRfPRXLUG/yGjAJuvTUdzyCPBj4A8mFVMdPTKu0X+ZICJv
	 wMNR2gWkQ6AxAGr/1S9GvPyd7NFEnYXj/DFUYqADt3m2OVWuvelIAsdsToh47qNX27
	 +jdwRvM3uAuiu7oo9+ppOZzbe6y/8PmgvkxP1JiXUqa3hL9EUpGQKD/Ow9BsJkiW2E
	 ICeVZt2RN0ZZw==
Message-ID: <sashiko-outbox-209112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] serial: max310x: Three-state TX and RTS while the
 port is closed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-7-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-7-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:54:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] serial: max310x: phantom break on TX line in
  max310x_startup() [1]
--

commit e4e606eca28fdbe85b131fef6cbe0acf9223f301
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: Three-state TX and RTS while the port is closed

This commit implements the maxim,tristate-when-closed property to keep TX a=
nd
RTS three-stated in MODE1 while the UART port is closed.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 876bdd1f5496d..d5884c870d8e0 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c

[ ... ]

> @@ -1542,6 +1557,7 @@ static int max310x_startup(struct uart_port *port)
>  	struct max310x_one *one =3D to_max310x_port(port);
>  	unsigned int val;
> =20
> +	max310x_set_tristate(port, false);
>  	max310x_power(port, 1);
> =20
>  	/*

[Severity: Medium]
This problem wasn't introduced by this patch, but can max310x_startup()
transmit a 50ms phantom break on the TX line [1] when reopening a port
that was closed with a break condition still asserted?

MAX310X_LCR_TXBREAK_BIT is only cleared in MAX310X_LCR_REG after
max310x_power(port, 1) returns.  Because max310x_power(port, 1) sleeps for
50ms via msleep(50) while waking the device, the newly enabled TX pin drives
the latched break state across the entire 50ms settle window, which can cau=
se
framing errors or data corruption on the remote receiver.

[1] https://sashiko.dev/#/bug/linux-48f66bf9-1d5f-4959-b6b9-bc3800762a8e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D7
