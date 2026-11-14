Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663978;
	b=ekB9BtW7jnvZlA1N63/yZu+z+IIfo+FTDdinHi6OTb5vTZQdWkNdMX5LBbzcrKrRM7Po
	 n89MO172ogiR9wQCfr95cJXGB07nJiDIBwwKH2d5NQjyu7wLqltP5+JnMFHI2JzGQa+Gg
	 0982mfjrXmjkOEvPMpi91F7b/GAROdJ7QwgZ317MwjRAfZTrBCds7FT5pOX4cTzxjCq8Q
	 mnGzbh6ub+PtWvfFwxaTQnXJvT40bFfJ5j65HttyrIUJhuPJ+xyBBwyFpTbKj2IVZjhfG
	 J7KgmB4nScYb55b4SEAp2MmpDOrTP34b3YceYTxSSE5zI3YIqPbrMS+8RzrVV6OiZ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bHFfYgMMz3XgwXevHZPK18fv8shPviX3o4hRGtoloE4=;
	b=P6HrcQtN5YOI3/ZiI6HyVTwDB7h87r6sX8kM4g1dPejv8FmxaN4zBR0n7KXxhXgTdgg2
	 wmIhB2BGA5KN6/2DkEjjA8RIjE0j4WiISNq5uZ8IjxL767AiXWqAJbHkJE5juSSrPhTEF
	 MoDfjc2SbVnH8mtmSXP+hYbMP8oFsVC+Vil+z7jifl87J1JUhPY7WSEvIdzeduSwnZlen
	 DncXYNU4NzrXPUmfIY400xycrBfHrPowtHZEmxRgxcKrgIEgwZjNmhE/4pFUjsYZnN7nN
	 7qK0y/JFaJYAUiO3wW9HYu4Nk1GC3uAkL1055E0DQ2wzYNBY9nH9j+zDQNxl9/ra2lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBs6KDhW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E7606A329
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBs6KDhW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB81F000C4;
	Sat, 14 Nov 2026 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663978;
	bh=bHFfYgMMz3XgwXevHZPK18fv8shPviX3o4hRGtoloE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBs6KDhWnQbrsZbI8CkBc/9JHNFBRZQsyjL0ZJ/QbMxiZ/9I8d66FbdM7CItecTIc
	 M21Twy6g06g8SxrLmpGi7Nf3sP/1ICfi1AYWZ2kcp8uUq8Gwe1BA+QRwkaxvYb19yE
	 z8iUFildx/tZJHGm3tWzx/cpKMngd7gz91cuI3gnp+m9Db+bAA9EduSP4+wFYbeo/F
	 j1LhzvIOJus6Avu2rMv0wU0Of68FZc3bPjDparQwpp9CJY/ET5T6SSbX7F6IuAJprX
	 qRpAdQY4UPRCxhoDmYvNdrA2IHkCFsZjKpbKiTHWC11Zz+gBVU/YcL4TIL5IVVzN6P
	 SstSsQOzcVEyQ==
Message-ID: <sashiko-outbox-214589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-5-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-5-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:46:17 +0000
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
> Add low-level debug output through UART0 of the Cortina Systems CS75xx
> SoCs. The UART is mapped at a fixed virtual address by the generic
> debug_ll_io_init(), so no platform map_io is needed.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D5

