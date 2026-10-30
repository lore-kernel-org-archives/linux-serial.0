Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350636;
	b=zghcfw9S7pmxNSHO0Q3AfvkBgPK7BGYpH3gkSJWN9jmwNCznwP7eiW9MdWHTyLWjRskS
	 W9asnQIUD4hS5wjVbI3Yho/HIzwfzGyMNJxKdPbKE0nRgoAPG9fB2QAznjIo/GPXdkEQc
	 cCZhoScWS5pdI/3RefjXVmISp7YxJqNxgwafrGobWEf0Rd648QgLrTC1NtAgymLDiNp4e
	 wasUyOkx19nWnI5jrepUQoFVHLvzKFWZ5NGiV7kOCKWUehnfip59yxq8YBaKIAxl9NkZg
	 0xWHmALNuYKEyah1REWYs5fdRuGbMyUPGqMdFCnAaGbG60wAk+t4kKvlqaNuzRQY83w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350636;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0tYEUQ6+A7SRkfSyOr7B5BUccvYMGdAarG41kvM6Kxs=;
	b=I++grzBAx5aSY5nqaFZJp4tUPIQO9s9g8uqSt471gymH/SD5NQml+3EeCIlmpBBdV7sN
	 jTRwq6SwmdO4a9kDNx4RPRsmnyjbz/xS0UQuEYymqm2z6QddMUq1e89nVtTwDnhoJ6Fvy
	 oaURQhzbnw8XaknX5wLgjxS3J6EQ8drKIhgRhGtHDJ57QhhcEJYUUU9Ho70YmBoE1bQBv
	 KMvXwUuN3S/3qW7QzpZz6QvC9Kl0GbETAJTTQoa55SlCzDZL3R86FxYNMVB7AsQT3dy2f
	 WxLIe44VBzwR0EcGeFclWCx+GO7ln+L8+rK1BdrdEybzFKHN3ytwt/ldkTS9rip3Yjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DISASpMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF110606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DISASpMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387311F000C1;
	Fri, 30 Oct 2026 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350635;
	bh=0tYEUQ6+A7SRkfSyOr7B5BUccvYMGdAarG41kvM6Kxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DISASpMynmMBveHgDdExReA3WSb17dvhrRP1ZqRYu0SGW0IuYcIl5mHChI4+VGJag
	 5Md3DpApPOPa0ZMj9TiJZC75/qAy1Hc/sHaZnx3BxYjluOhwGXSwhorGkhZpgfuYbF
	 wTJdW4zkR5QtoyN2LxitfrlRlyWLQTerwUPe2BcP1d23+M44NkKgVyHqcs4cbAZLK0
	 lQCXA3T9Ra/MSX7HfZpwE4WgbjkCEvL44TO5VHNyEXIC/b9CTo03kkItescCBk5Zd8
	 XPYxKQ2YCjOHQYy40nbgnxtN5oa1eD+FNZIYd7hUeKpa6LvnMlWug4/iwge4UCiWSQ
	 1HBMjiFz67g2A==
Message-ID: <sashiko-outbox-190722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 08:57:14 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> sc16is7xx_probe() enables the clock with clk_prepare_enable() early in
> the probe path. If the resulting clock frequency cannot be determined
> (neither from the clock itself, nor from the "clock-frequency" property
> or platform data), the driver bails out with -EINVAL, but it does so
> with a plain return, leaving the clock prepared and enabled.
>=20
> All the later error paths of the probe already jump to the out_clk
> label to disable the clock. Do the same here.
>=20
> Fixes: cb1b206cff46 ("serial: sc16is7xx: Use devm_clk_get_optional()")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030085508.1882=
-1-laixiangwu@cmss.chinamobile.com?part=3D1

