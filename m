Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230426;
	b=AyutQ7upyV3+HwowutCsIfAkuWuSgOq7JWE7xid3y9r8O8VYhGbnvBJZU3KcrOWxkZvg
	 7zrOlIbfgADhI4rpxd68CgkakPs5e370k4zm2I2wXJ7Xx7ahCVyY7zcC8xhyEH8U8gdOn
	 pPGdwzPtOv5LrhYinXnRxhc4lpIW1mpMphteVRFKehtD7wSYTbldwZrrOflZGX2mv9CJ8
	 j8sqjj+PgObBqa5PwPZpdKR7ccoochSxKbkojY1gsrqL7AiKuQj/0P08taAtmyy9nxdQC
	 KbpiH+LH6CBk4QzbV8fatXuH9zsrzMBCBEC/EM+0lP/EUDrF8eWmxfuBL9UessIWtoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X0sLpv2NHPu/qZHJQYkUAvCmJvzIdrFgN+ftns/GTdw=;
	b=I0Y24fIDJ8ruHH+VxfwPKNwlJVSdvNsVECNvrUNBMeH4e1MYQfgH4cFtQbcgDQXvF977
	 pWK+WyoeaBeNTT5UwsUg82W+PPIRdbF/TcwY71R3KTUD6huzpc9UztD9I+VKe8qGEIgnM
	 kGY2JYyYfCzlESZgGyHUNfUP//6kQ8OR8gpKPZy4S4/rLfmrkIklL/yXE0xODScJ1tWZN
	 ZZLy/JCDSKROVRC4j1rWiCvYlJNjHfKudwEo6ZZPZB+DoweflcI9HLTcHW4DXw4I/Pexd
	 OmVp05Y0VWyrdq7ezgsFsKPVVmucr8RKFXI2in44ppILIqZ1bdl7fOyoxv3r7T8j4ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyP+N9eF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2F606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyP+N9eF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040491F008A1;
	Mon,  9 Nov 2026 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230426;
	bh=X0sLpv2NHPu/qZHJQYkUAvCmJvzIdrFgN+ftns/GTdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyP+N9eFQ7vecc2t0cGKw90+En4Y0HSbzRXBZSMvD+Jj7Is5SCParKb3xa6oj627c
	 K2JBvx0GJUTsYkQFbLiQYumejiL6mwT9p78BXOJJhYevCOF6oZNOWcC8o/0SfuY0cX
	 TI0iA8ipLU6u3kPr1egYlxRtw7lqrt3xQZXasb82MpMqANACRu14lPcwn/ugKEDwe9
	 hBZtgS/Ss165CN34ESkHJ1LDguPXR8Bhtq4u3/DmXPY4BshzwKdGbGOqwcmrLuPxAO
	 s0dvaaQ5WqhhrufC827THprEoxUQHUC2NkES3HjWLkB1Sf6GOdUI9OBbwkjZN1T1Ri
	 /NYCYjR9IYQnQ==
Message-ID: <sashiko-outbox-205008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: sccnxp: Fix potential stale ports after IRQ
 request failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-21df1234b2-serial-sccnxp@mail.sdu.edu.cn>
References: <20261109-21df1234b2-serial-sccnxp@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:20:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The ports are registered before the interrupt is requested. If that
> request fails, unregistering the UART driver frees its state array
> while the registered ports still refer to it.
>=20
> Check each port registration and remove the ports already registered
> before unwinding the UART driver on either failure path.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 1d65c0b12656 ("serial: New serial driver SCCNXP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-21df1234b2=
-serial-sccnxp@mail.sdu.edu.cn?part=3D1

