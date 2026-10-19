Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429650;
	b=gg0g6SNBjEcWRG2aI/1n/kbVQAm3EC3nE2S5FD/oWv2M6XAuMBMSmXQq1aQ5IkkQkzcZ
	 HSvW5FfYNmBT+TJQguiWM36eFF8DK8PFnyGGQe63G20trL8pcRK8T52TJ0FVtpzf3kOH/
	 vkORolGjo2qs+YjershzBkByW1Q4HeJ7hbUxtdoRI+LYG8qzKcVnBeRoxCUWCU/2Lez3Z
	 6IX1RbUnlT22pH1tGO63H/weotZrDpztmTKjCkpaummOtFAm/AB2ctQfIpFqIbVLdpRbJ
	 iGdbfkq4IkWkZVvgBINrhHReGkJCEIygWdpIARUarjlMFkKn1lrFx5S/3QVR3oCU8dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5kMe6B4ulp3H1YUyh3j46V6Bf/NHZyIDVWuXqB7xmVc=;
	b=h7oMjYocoxnV7rNYDFg5QS+yEj2ivjfrRMT/5HGKLpzAu5/mgQGT4Os7ayoePKy0FZka
	 RtSDi6BaaFqdWumu8e6ZAfonXKABztV6fyYIDCCD2hoGL4YJmM8KH8ZhwgeGsk5dldjhh
	 8+kd65qGAfWR1HuYn8gJ451jBDen8L5YsS7KjaDfr9/i2/C7dLX8UfThLexcEuYDatrUl
	 4QQIeVVmM4l6bW5t8pG5iDy09/PpBAi/S1VM5WGVRIIOy0jmV6f84OWTiSFElYh2UmvLj
	 EPkrHfD23lvVAv9M0VWUCRKhzgqLJEmqQTNW7TEjEK5fnFC7h/HvAUOKwuxF2rpSpzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5YHJdvP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E54606A319
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5YHJdvP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4F51F000C4;
	Mon, 19 Oct 2026 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792429649;
	bh=5kMe6B4ulp3H1YUyh3j46V6Bf/NHZyIDVWuXqB7xmVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5YHJdvPIngIEBkM7iJwPYpKR5PoD3l/D1Aid7EOOatgec/rjpdeRzFViYhZLNi5K
	 Bc2AKuzqzVkCWdwfDyrWNhEnOAAZNA5qmBYCRbhZHdgcoMDfDIXSHkMOAW8zAGmg8o
	 0iaZABJv7WOfFsg212kr4Tp81GGLRklpC04Y++kAan98oBGQZar1dEVRDg1FaRj8F0
	 BeD59ECpivG0s2bsHXMJfRjpukwo87k0l7R7tvg5V51DC8V6MKPDI0XFFQgZsCOa8m
	 H44Pz8N6p+gL6dJcoU97My7C6kPrlzBrG8OvHOU82C9a44F2K1kpF9RZIVQwxQaw8c
	 pgh2VSdNOhlUA==
Message-ID: <sashiko-outbox-177993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019170139.473808-2-biju.das.jz@bp.renesas.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:07:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
> SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
> PORT_SCI once the transmit FIFO is empty.
>=20
> The hardware manual does not describe disabling the transmitter to end
> a transmission, so this special case has no basis in the documented
> programming sequence. Remove it and let SCI follow the same path as the
> other port types. A plain revert no longer applies because the driver
> now uses a kfifo, so the code is removed by hand.
>=20
> Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI=
")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019170139.4738=
08-1-biju.das.jz@bp.renesas.com?part=3D1

