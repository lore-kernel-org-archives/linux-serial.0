Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667220;
	b=SAF9PgQuNF+CJvNd4QgLVZzIVE45R41DXH46/EP3SF+3uZoLGXWKk25yevwVs+OVMBzg
	 O5JjH7pJsjPrMkb7XWVJxOxwVNXXzSwxeKMB6sbgV6EHHLXmGKENzrcgDPB7UkjcjdrrE
	 Ft3i3322Dt0ZGppCa+uB5CjDD/+sFX6F0ZBMHEIF0WEBvGrMUKxgFnZQSngfax/8Blbp4
	 nRnT0qi3AX1dsoeS54ATNQwlmXg533w8hE7B3zqZGYokdiHW5NKHjnNcEmmYhKOgem1AM
	 sL6GxlOCjr0E3rVIHnjKZ3QZDlsC8hOas+OpnZLPX8ii1yLBrW9cKu3Rw27qBbKNksA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wl0SqqvGAwqSv7kUcARZGwvkbhNHgEW2h2F7AIS5N7g=;
	b=zBc2g09vsIss6lnbWUMwM91060rj930MvRC5WoRG4bV21zcy5HAIiL8ehoajLOiiEAus
	 gXvXlee41h46qPZI0UG6+7L+J1EnH5Af7nx/WviEuCyARGCurZ0svwqxR1yhcwQ7BaQWU
	 IDeRnDiNFxixyRcxgfgFFO8MF7Q8gJNJsRDhnnjgr2dxw26KfPrv2oD+Tc6PsRdYAYTwq
	 QXdgiWmLe7+4BJW2Vhbmahf7AjyWl0rfk8dN1WoN0IlxxiH3Hk59qIikDjLBSMI+gV43N
	 GoRMZ9Uinp9acvO9XOm8WoS6ETlPiJg56iOGqVrO0v9ergrnbGu+yCOGcJnLayWZBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gCJLbyq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85083606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCJLbyq/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF46A1F000C1;
	Tue,  3 Nov 2026 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667220;
	bh=wl0SqqvGAwqSv7kUcARZGwvkbhNHgEW2h2F7AIS5N7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCJLbyq/6uJB6GqmqVHLg0SBUFrCEpLkbNhpvocABtFFIcs+Gub1q4jTDYWOucLp/
	 e0eyP+kjHoz4L77vBmc3yVYYIi09/l8AQ+zJli5gnuJnx8ZmMuwZzTd90126hzCJYO
	 cRoqBjwDiMLDtxqk+PqRq9s5IQZko4dLhuhjJtm6ZkdbCj+O9VUTYI9Rn46aAfpb1e
	 RzJrojHmTVrfOSETwyRrExZwl4CYAAEly7Y02XSFg62T2bmDj7K9o/wnFo8e3YRIlG
	 h4gaFqhUF0EkZhzcPdsPblERXwu4HJjzASnhgywyOeLYfpyovrKUpjMJa0QdURpae5
	 8RzLL10a7vwMg==
Message-ID: <sashiko-outbox-194390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tty: serial: samsung: Fix potential NULL
 dereference on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-cmc-tty-2-683dcb126b@mail.sdu.edu.cn>
References: <20261103-cmc-tty-0-f5f5ec0841@mail.sdu.edu.cn>
 <20261103-cmc-tty-2-683dcb126b@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:53:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Removing one port unregisters the shared UART driver and clears its
> state even when other ports remain registered. Removing another port
> then dereferences the cleared state.
>=20
> Keep the UART driver registered until all platform devices are removed
> at module exit. Retain registration on first probe.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 6f134c3c7703 ("serial: samsung: Move uart_register_driver call to =
device probe")
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-cmc-tty-0-=
f5f5ec0841@mail.sdu.edu.cn?part=3D2

