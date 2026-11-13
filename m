Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566573;
	b=KOl1ERd4ilIYiW7tmIIHp0rGr1cIeOcoUj7Zx23Owg3i56/fWnZmmUfHteJq0WPgHn9b
	 8XCoAdfeG8o3rq1n8CdsV1NJ4XmhRwJMg72pr+gpP9l7eaNebFnQnS5rJAEOeQrxdyCqd
	 HN6T1C61/RKbHrPejElaq0PPGwEW9pCp2WWFWm9WAF6zoTmrC7wsgAJWX9X4AmFFWJN/A
	 FOzdxWkVCcKfa1suISXDgCiebaWp32NwjL1Uc6VH5o6wurcA2sMomUyWo9IxVcEpXI6Jr
	 NFFiTJiZQy8x/BkUBveGbOD+NefsA63bL7or45XNhalQhOZRWpFjVQ7KlWADVn2sx0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F+q9fIDVechYValfB07BtfVuFFF9FHB/lJgXaZYTqw0=;
	b=wm36nGkd+RxCz6xzMmupfW/USsSPRnEx79f8QbxwjB3ISdGjDDP2VhGGw4SJVAcoReBu
	 8vY00wed+ug7x8+U624eSo5EUCHKch/dAKdMJt+pm2DuygZn502S77NTzsMGA75wslK3P
	 RvJNasnpynGT41x7E8l2167xIq5g28rWqyJm0/ijwJn9h0EyciZ+/5vIHDrvhbngphtih
	 cTeRuAEqvWPpxs6URGOQW6rg/Cs2BAciJu9lNhQmagpacvBVsPjHOHDEfvuFejeb44DU7
	 xdDvW9+ob8zULdF4i5+a1XHiP4uuyD8L1hKCEpGPhFDDbLTYXxYSzJapG2sGANaS6Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhGIWK2W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF948606A334
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhGIWK2W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB761F000C4;
	Fri, 13 Nov 2026 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566573;
	bh=F+q9fIDVechYValfB07BtfVuFFF9FHB/lJgXaZYTqw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhGIWK2W9GbGaGJBDptoOYHzvN95CPoO/FZhLHZbob3RrgDliFe8tJEE4b3gYOJ8Q
	 oxk5oeLKktXrJ95uFDu4OsM+sfgbR6XA2bWEcSpqPGfUVKJF8ox+cWcbTDHRJAeKKO
	 dBDlxBhpK2dc4/91OQMWUCXNbRMpoX0SMtRKur7VrY0hK/SDbF1MrSw5YmnpeT+fCC
	 k6eKz+ns8Yv6VetrxbzDDXtIxaC8xwnQKi59R9mqZ5PM5KQX5tSMA9edr27Gtwsg+E
	 TpADxyhKMFC2T4Hd0aF8gv/IBl9ecjjEezy1g6KZ/EtbXyIdIuHGt+vAkaX0zTBbyL
	 K12M1p4VIaEkA==
Message-ID: <sashiko-outbox-212632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiangwu Lai" <laixiangwu@cmss.chinamobile.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>
References: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:42:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> sc16is7xx_probe() enables the clock with clk_prepare_enable() early
> in the probe path.  If the resulting clock frequency cannot be
> determined (neither from the clock itself, nor from the
> "clock-frequency" property or platform data), the driver bails out
> with -EINVAL, but it does so with a plain return, leaving the clock
> prepared and enabled.
>=20
> Switch to devm_clk_get_optional_enabled(), which drops the clock
> reference and disables the clock automatically when the probe fails
> and when the device is removed.  The manual clock management is no
> longer needed: drop clk_prepare_enable(), the out_clk label and the
> clk_disable_unprepare() call in sc16is7xx_remove().
>=20
> Fixes: cb1b206cff46 ("serial: sc16is7xx: Use devm_clk_get_optional()")
> Suggested-by: Hugo Villeneuve <hugo@hugovil.com>
> Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113103855.2144=
-1-laixiangwu@cmss.chinamobile.com?part=3D1

