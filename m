Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574775;
	b=4kZwcaflSsG6AUxOcV7s9mZJY7fgfy2lSfZK6OpV6/flTvnCR49fxcbe4UWmMaKisBXw
	 ENKBMNIlH+c/YLUPyPHau/l9BTE292LmcF/muZFkS2bOFuhp+krx3OKeO1kBZl235RZf3
	 hK2BUozhIuOWk7c3cGKdkPlywctftTfroc8EKJC1fZbBbG1vtT1VfvrzaC9JWwT88a9PV
	 JWrlc6OWERhpHtoABoTaYUOm509twn3spdyNIfF9LChvvgq88VlsY2O/rlVzywN3nYQQm
	 0TI7vSaQUZ2svVAfGnhC2uvLq4HiBTiQaVhcm//RVtxwexFPTWhpNiSBcyarUgt+1Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574775;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MRuaP+aVZPQaiRqPkWefhJqmWA0yRUBx0VGaGpmtgbU=;
	b=0fkr6lWWcy+pkCRfVGsYRtKhg++YXa3Ptn4o7/adq/aR+lorTwnGfoG6EmSEog7QfNFd
	 zdTWAbd4wZGb9FlpzAZQhpouNO8oOIs79g/JCuxE3Ld1EtZPOwLwYWxlGIzi/p+C2IbcT
	 Z17k+95CRex56XOkPbJye/uOYU/kM3OglcslhMFIpd89LBumcNljwNS8fhjBUX9viAV0D
	 dsXNdL4ohwoaSoyWHEazYAKd5/EYaXEdIAc67HH5p2U+3YlvhoHBgCPXtTPYYPcvNAcnb
	 +5nKjMttP+1RXix/6k/S8qQm514Llf4JVSKvNeoNzZZp+d6sQxsBtwTW4p0pVdfhR3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xipunbo4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486C606A329
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xipunbo4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614F31F01578;
	Wed, 21 Oct 2026 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792574774;
	bh=MRuaP+aVZPQaiRqPkWefhJqmWA0yRUBx0VGaGpmtgbU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xipunbo4853bZRdHWiYXGCBahjSU5lmnxPPizAlIacUXe8v3xVtl3NUChMOqJPIDL
	 C8nGvNJpJQ4d0ckiCRMAnWEqSLjqLJvxTzI2qZCdvVcXC7oBOP8UsYQtiPi5Fw9oIj
	 GsRRtF4HS1q4yQ45mreEO/8g4/epBa1dIvkPooeFDgEk6OtccdQOLoJej37wuiRHpq
	 pxbqF50LBqe3U7UBIMvSK9NZDO0i0NdM2q1aDnaSK2wh6cn6pL8BbJxg1jta6wtTyK
	 pWiNUzA+fzD5LWjQnR42IHSABJd+vaClMY8W7QyAndQkArhohFND76LOXVrWtOXuOl
	 z3xsAfpWM11PA==
Message-ID: <sashiko-outbox-180025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261021092124.2306053-2-an.wu@canonical.com>
References: <20261021092124.2306053-1-an.wu@canonical.com>
 <20261021092124.2306053-2-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:26:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The driver creates a serdev client without firmware metadata and
> force-attaches its driver.
>=20
> Set its name before adding it so the serdev core can match the driver
> normally, then remove the manual attachment.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021092124.2306=
053-1-an.wu@canonical.com?part=3D2

