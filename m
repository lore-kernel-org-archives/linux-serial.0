Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685598;
	b=d6PW+ckBaRJTtQPhWh2Opi329RnwQjOq0sxt4cHfjZFscYEvTyhXSF7LkEKpzHoq/Gug
	 xEm5fBCH4IK9Zdxy5Wsfh9gUPdU5WNxDgYEHylAnTXM9Qct+IRnLBwR5dYpRiC5rpC2Rg
	 ogQ2+839AomHoBlGiIRtSXaM9YIyTELgwZPRsUmTlRw8vWqJVYA6RmaiS8kH/mxOY6iq0
	 hD3a/AkJVZnJJNaQcC3Q7n5cnPpBcxtILY375btstOcoxvdHh9CVp+f4Mc+KOhI5mvH+H
	 WsU6brzeaL9DDuipwQxtVUVAGjJl30Hww5Al7Wg7kgJNGt/f6FrmTIVTUryelMfDhtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2bdGKBaxDkQdM+0tmjxCzHJWpaWYiPrUBfQJbJdYWss=;
	b=gvj5e/LLVeJNbvZwTI9wvUGLyAzO+XTA8rpEz9gQMHjqDRsI8WNXHxnJEB2Q3ZBfNUyi
	 HO8Nns/cpObDHh1L2Lt40gJRdx09ebLmpLyPiHKVynJ/KKxdWVEPmG2uq1MITSy+Y/qS3
	 kv5bAfuKqfk/8Hs86uTdtVPXOfQf4GlLbadvyeEWMNE+N4rEvC2h4zrOhanvyt00zmGSt
	 fxMgNYm67ITgDq6W3HHHSvjPzZiFESmTTxA0+zoyDHXXui3T8SsCBaE6ilrbhjvyrYs7U
	 5SZ+zSacb27B3e5ghcKQiXWKj5eZBExqMyp7QFrW+zT7RxAmhKN088QHuehLyZZ25WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUeLAsdO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC284606A336;
	Thu, 22 Oct 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUeLAsdO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C691F01825;
	Thu, 22 Oct 2026 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685597;
	bh=2bdGKBaxDkQdM+0tmjxCzHJWpaWYiPrUBfQJbJdYWss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UUeLAsdOjq6JVXz5AVXW1sq9ixkxFjUzGc1m411M0nwS+LrTRDNibQ93A40KJTWCQ
	 h9mqdZIF8DaTXawiEjvIt3B5qoaHhsfwq1u4zYDdKv9ZKA33E39LffAK2wyRqg9LkS
	 G4eTkzXGg+XZ2nQgs2MyR59KPhBVnPaN7m0IkbwtnqrDmo693ir+1DMnFig4885xad
	 DwQKaaWWrbW/s8T8W8ug7EBzPld6l87JhD56Zd/J7WdPcshqlKa/6yMZRq5fclt6Za
	 qrTNMrv5dFPpm8gTVMajDrugxtiZe+kbv1HfInF+gQqhJKwAEVNC3FvGVVAVARspKj
	 ds+yglP8kDe7Q==
Message-ID: <sashiko-outbox-181782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/27] dt-bindings: phy: rockchip-inno-usb2: Add RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-18-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-18-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Add the RK3572 USB2 PHY compatible.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D18

