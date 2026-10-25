Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894217;
	b=irYRJ+2X5kIykQTICWAJEcKtRV9KpqbmIi3grwpC9ZV6EpuukSPFkzeAOOdKlTJU+teZ
	 uNSU6R8ZT2R04bF/stjrqfgdEcgaSGBReNbT3JX0CXdFf7HYCCV/wgrK4BD1fUj/it/0s
	 3tzjYf1ecFE4YXMO4kCHHA05TJ6DB0WiVPisMRE1xcjBBKBtDrbDJ6Y/Iw/XQ8NHmaryj
	 kZxhlrR7Qmbq+CC00DbLdIOonan7ylI+4SvAYhHO55igp+o5EE/WEFnX7uSpzFhXl/d9E
	 oquwPaQOcXa8f/gWW5BFUNLBPTj7T6mXq+nbr64R1OyGHeZZAKoogVd/5MiRK2KeYrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RW40kBKrjtIyGlrCC2GIOZ6d4XhbYsmey/opvpzVFKY=;
	b=WHom6lqysL9434nHUvxmMBE8OJVWjtX5oaZd70W3ACB5KDu5QCY6HAY+NHmAh/FFlUUg
	 QtRUy4lPvq8WzRhMLtbUmjmr3ilUhYKv0PE6Flx0NrS6PNO5443xYn8HxiK7bDLu3WOSQ
	 RXW4/LN6oOVfjT76cNDu989fqnsHCpZhgcrYecTzx+RhquSFXr/133rypINrRo5sY+QFT
	 dzjOIu1Ezf7+xSAisOUUnT0+zb+91nhjRTYJvFPOvLyQ1osIPH9knN9/5nkWYP9dutyzI
	 6cKig1/g1d1vR3pk94C+B3P/6NEBXAhaeCtUkFhMxf1Bycv6sZuZA3JLPHlqls/wOmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6Ai7Gqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC42606A31A
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6Ai7Gqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6781A1F01825;
	Sun, 25 Oct 2026 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792894216;
	bh=RW40kBKrjtIyGlrCC2GIOZ6d4XhbYsmey/opvpzVFKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6Ai7GqavtLiEFdKOoSh+DX16t3D09KENUeJHOPtJne+DDcyu6QQROzZiBR84S/C2
	 uyn8W6xDEb8MjvWNJEp3i1KbUppMUVTWdd18rJUqwGgZAjDyFlycvB1NEBJ1krkz1D
	 WZFwyO7bJSaRnaNbMN9ob/+ScZjJ0yBwF6ZVkDE/HZeLnhqZqIlAGktccVs6FrKD2K
	 gDnsn8H3WpPZbyd4KNTI4iPHmtdmSHIO3qd/GQb///Ipl+0rl7iEbtMdVhwehnF7lG
	 lgLQru1JeJNZUxLKwxCgy+eC3QykOJNnsuqHXI6OJT2DJxvz0TRlb6dCcGMs0BK9zu
	 HkB+z2J49yQiw==
Message-ID: <sashiko-outbox-183978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: Disallow runtime changes to nr_uarts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yingjie Wang" <1075151112@qq.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <tencent_23BFCCE74C508AD599E72011EAE5E409C006@qq.com>
References: <tencent_23BFCCE74C508AD599E72011EAE5E409C006@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 02:10:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> nr_uarts is clamped to UART_NR while the initial 8250 ports are
> initialized, but it is also used as the iteration bound by the remove
> path. serial8250_get_port() assumes that the index is within the
> serial8250_ports array.
>=20
> Allowing nr_uarts to be changed through sysfs can therefore make the
> remove path access beyond the end of serial8250_ports. The value also
> describes the number of initialized or dynamically registered ports, so
> changing it after setup is not safe even when the new value is within the
> array limit.
>=20
> Make the nr_uarts module parameter read-only through sysfs. Boot-time and
> module-load parameter parsing remain supported and still go through the
> existing clamp.
>=20
> Tested on x86-64 with CONFIG_KASAN=3Dy under QEMU:
> - 8250.nr_uarts=3D5 is honored at boot.
> - Writes to /sys/module/8250/parameters/nr_uarts are rejected.
>=20
> Signed-off-by: Yingjie Wang <1075151112@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_23BFCCE74C5=
08AD599E72011EAE5E409C006@qq.com?part=3D1

