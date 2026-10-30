Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364189;
	b=jkZn6YfdfAnxfjBq8+4zYrGfi6WCuxlsktXxZayO7t3GfvzzXxwiyD0vVs9djVBeNvr/
	 hBzxqfxQtd3EzYqTetbw7nLpAUoU0XtiLH4v4pHLWBmucuUEcFt613RVlKRoYtqHvPW6y
	 gHlYE2PwK7LeJcWzAX1W63bpHKv+c1Z9j0Wso18yp5IGGV/4aBjhPYJ8Ua4Q89NwiWuFf
	 LjiSAfkC4m9ebasI+lbkBr4x7SjZmXWL/NzzZA32+Mc3p3w6rr+XORahO4J9FBRt/WnPt
	 AJwvgAUTjkXXN2X/yfhZ/m5NugsDBKurXsTOdNFryBpHTVrSz0Xw0wwgQxjA2aKxWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ckuJnRo1BmPCjvMWW3BGaSRgPzx5HSSmS/1nZYZ6dbo=;
	b=5n09HGiHxACQmPuuJXS+yRpciirqylJ+8rf/KeMRkYuFK4BL1gnyFydnSJUi3MzbIZfM
	 1cI/jHaYKM2ubC+F3m6DukzAW9h93N3VBMesdL8qRG0KhJ/7Ak4C+4gQbfXrMc2oRCiO6
	 faCOmMS1VBoP1NOIJsAtY7Rzdo+J2cwCFlWvJlUHNNfdk8YJTujU/Rvmj3zvl/F+u4Wlk
	 XF0/fusIKmDoY1eYlcsGZT3zA8MrwCKujsf8e2vQtkQwoeizTbW7dEw4tVsyu6KCba4st
	 pWaXyoahgZzeAj880bSBetKf2gn2BsSQediV369Xt6TRYXLNB1x8M3+QERLTExoHclw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oACBQhEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67905606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oACBQhEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B73E1F000C1;
	Fri, 30 Oct 2026 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364188;
	bh=ckuJnRo1BmPCjvMWW3BGaSRgPzx5HSSmS/1nZYZ6dbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oACBQhEhqGeb6fJt66ux24kEiXA+WNNpuzGHj//eTYnHrwlbCgx3euQzgEe8SoO35
	 ef5resNUwqZeL7aLkqtvszqHdOfWZgRMNuHmhqrxrIydDArkX5Pqki7FSqC1sh5UJK
	 cW0oFrArsckFQ6yCqEGcgbeHQpaQKcWbEs8R4a2LRk7bE0PPespuPbzgIZvWsysKRc
	 m6DnupBqvvgrniav6B+s3fVh4jlri/pHE4aBipw+IbEGix63EYzakFnQ7wbQsCcYnl
	 dKvB0njJ6oSQRRNbuHVf/QEwkQM5479xn+9gs1r+8gFwElT0PM/VY0MqxQcG5MAfHZ
	 qyJnG90JyuYpw==
Message-ID: <sashiko-outbox-191022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] tty: sysrq: clear the old reset sequence when
 reset_seq changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030123640.263164-1-zhanxusheng1024@gmail.com>
References: <20261030123640.263164-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:43:07 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>=20
> Changing reset_seq at runtime does not work on a keyboard that already
> used the old value, because each keyboard adds the new keys to its own
> copy instead of replacing it:
>=20
>   echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
>   (press any key)
>   echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2
>=20
> F1+F2 then does nothing; only all five keys together reset.
>=20
> Clear the old keys when the copy is rebuilt.  If sysrq_downtime_ms is
> set, also stop a reset the old keys already started, since releasing
> them no longer cancels it.
>=20
> A key pressed while reset_seq is being written can see a partial
> sequence.  With this change that can happen on any keyboard, not only
> on ones that never used a sequence, but the window is a few
> microseconds and not worth closing.
>=20
> Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset seq=
uence")
> Cc: stable@vger.kernel.org
> Assisted-by: Kiro:claude-opus-5.5
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030123640.2631=
64-1-zhanxusheng1024@gmail.com?part=3D1

