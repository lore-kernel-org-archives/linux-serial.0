Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663936;
	b=Lpnj9VV8Y9zre9sCZvcyXAH4jaUBXb6S2xIHgqHoaZAE2hAgkiolKC5KIY72kdiGWYJj
	 xYYBrZ2j+gazu77VsZM9LqJ777kt0wy0jEilVE8+GlboHgvRnaIIqbFnpOBh3RHy6CwF2
	 T2JeQ7MOAfEmMF6lQ+DwTuJq/P9QGJDOIAFGvj7MM/QQNerBF6hRyYshKL/20qAEwWvsl
	 XuRmwUxWUoftNNwtrKTKoqR0/Z05Zb5bB/Nn8oykBwI0/E5aCJwbuvPX/M7Zq1GwtSYme
	 be0Hp2MoQ2JyiJEdlnX0GoxebN2A+/eE6fxeE6p8nQ7/oMGli0khpcesYvXPVbCcxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Is+l0UgBxpOgEx0aoM8Q4OIlrtV8UvAtfLCIfv4GEB8=;
	b=bfwr0XB7MnHem7kqp6My26H4JsvUn6EJzU8mVrDVkF7ruxX1okTQfhwaI/bJ/4eSD7uO
	 s4ZR+PnG+38rZLe2+MSZW1/b9ajNuU/+xUGhVCwJJ5kfAx2N36ViASbEjuyo/SeDLi7ej
	 BJdob73Eux9+XZGFYGZOTgI9R8ZVc9/bBRqHjfCj7ib2G52Mym3lRbM+VsIEikfhPgt6R
	 SZ1Ig0g4hsgruwb76h/K9YbnhX/1bjAu2X7HtefatxwJOOswMynXsCfo9CdLlf0mWwLmv
	 wFjLu9bamBYRmjbBrpNv221eGUToxPA6Ycq5b62VyKqOTa3iRfo+NXcwILNqL2kaTMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAch8z07;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D73606A330
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAch8z07
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415EB1F000C4;
	Sat, 14 Nov 2026 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663936;
	bh=Is+l0UgBxpOgEx0aoM8Q4OIlrtV8UvAtfLCIfv4GEB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAch8z075Kav18+mCGpbDYL+WT8L5SMH4jLgeGwFHX1LmMGb5YKhSHoAwNntZwXFl
	 3iOu8uexk/rc3gfebp437O0TW/2y7KnfwGG3GFrS03zezpaCr431Kkvja5DdZ2JzjA
	 TMaRCXDmoyuHgWwiogxWyjIPd+30lwXiyxz7efFMxxRdFAuQsGBb68SVINxcxsp6B6
	 BeGc/DhKIpRehNWOjWQTVNC9WUTCpZyuUtS8pgWMFOpZ2Yylvn3DeCM7nzgYuLgiP4
	 4yKeVCYf1u0ChFXbPB+5XSczEx8Z5V+WWVNq4HcRqDab0ca6uKMLsyUuY6ioKEktZK
	 3+5oOStpm+ECg==
Message-ID: <sashiko-outbox-214587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-9-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-9-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:45:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Enable the Cortina Systems CS75xx platform and its UART driver with
> console support, as used on the Securifi Almond+ router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D9

