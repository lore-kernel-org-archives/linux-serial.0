Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667038;
	b=KlHsWvoHi2DUb1sM9Wvihn/kkvJm5H/LyiAwLN+kL9Qa5uH1hcF95IyyeEnwVaTXpJ7Z
	 h3CjvdsZn/xyU/TvpRJmtxKLFk4sYyNOg8r6kYyo6+dLl0bDHMf6QbOhKcvAtt/xQaJHI
	 F8XcUJGLyMlnxUkk+RpbZIEX8Xo15v00FLMH6o/ieqy9DZjCicGYuAFAPmU2Sa5lulX+Z
	 Ay/YrH9xXm18PqtJFZD1zHlf4xj39ezE6K+PvpJo/7aDpfDDi4xlFRc3jrriITcgQqBw5
	 TPgSnBEhTMqZ86X/HPzWg0n9/AIeuREiHKwLLLVD4WCj8WE0KlNK5xPW0DUP3GojdIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ofGGRjHdqNnKQ7W5CF7ogBXncEtY1AoTxWh3ZB3Gy0s=;
	b=1KtJc+Y3aP0j0fj2asckybslyTPpXPH2MqEvnuMhtm6ksXyuw8MhxBLBQT40o8lqpe2C
	 fTWBkQTfb8cxAasylmL5l0n7LW0qvL3UNndmgNsaUF2VCecsoaGJ/obb3qo+vJCboTOXm
	 Z8MYKUih0dnKUoI3wLE/XhBM70pea5/Kkhr37ElIoaI1gbrceodSoxg2h8/2EbRAZfCRq
	 6OY0AdBQy+8LBQ9T59p5t7Kwz/WzPZOQ7HnRXpJw/1MI0VngMdZ4zJhiEO5dkZnYzcYFy
	 OwIKb7x9O2PkzS/aqyR3gNpIsUz0L8go2Fd9Q86ALw8eFUE1m0CEIy0A7x6wl+Qznsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqgSeTHk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84011606A326
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqgSeTHk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F941F00919;
	Tue,  3 Nov 2026 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667038;
	bh=ofGGRjHdqNnKQ7W5CF7ogBXncEtY1AoTxWh3ZB3Gy0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TqgSeTHkxt8/FsrPc3KroctnnyPG4qAJPFwNdPSKeD+//cWI4Z9X0hDRLtVH7suR0
	 sFRQ32IRc2CRJVhL8W16/As4t8rmgVPtScbYeUSGJlWEHp/H094WaIbz1MVSDzdf7H
	 DwiB4Ddt3SpVxnxs0iHnsr2vSkYL2QAkb5H9xokCYB0uhp5u1CmbsN1/IDOyv9veqM
	 bO6fltyyDMyZ2Naduhjs2hLh+KLKWFO6TjrKK+jAedofaoOiNmrvlQFLda1WnmmiFv
	 1M4//eoA97hFkA2IlJA9go7igWK3ELBifkaiiEUYUdoPEALl3xiKCaByf0/drtWTJs
	 +YJaDq3C3N5og==
Message-ID: <sashiko-outbox-194388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tty: serial: ip22zilog: Fix potential NULL
 dereference on exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-cmc-tty-1-617955e787@mail.sdu.edu.cn>
References: <20261103-cmc-tty-0-f5f5ec0841@mail.sdu.edu.cn>
 <20261103-cmc-tty-1-617955e787@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:50:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_unregister_driver() frees and clears the shared UART state before
> platform driver removal calls uart_remove_one_port(), which still needs
> that state.
>=20
> Remove the ports before unregistering the UART driver.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 3fc36ae6abd2 ("tty: serial: ip22zilog: Use platform device for pro=
bing")
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-cmc-tty-0-=
f5f5ec0841@mail.sdu.edu.cn?part=3D1

