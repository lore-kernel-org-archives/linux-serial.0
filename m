Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759183;
	b=rWbp0CeCJ1ytiTVYNz98r3LRneytYRYh1r60Gd4j4QkZiiOwmmrTv0R7r19tK8lqE+Bl
	 rq1bR6e8qQCES8O8QntbSrSqQgDKf1aLm+Su2b2QFsLegWF501P3RP5BgCO9VWCthMbOb
	 8rNzvgnjb1te/k/hsIb3yJl3n/XXlIXN6HrCpfZH9M5Gntnmxz0yK7WoiAen+p++WrXX/
	 OBGxbpPoaLITJXQbxexEYH7Xe2lAf6xuXMCLQ1I9FEbCNsWTbs9ckC+Tyr8JJgAD8TXIw
	 H/RhT9kzPCqF9Q2yHsd5SHnvpD0B8iAx0N25azkrXyKnxZVpSxviTfPLKlPgVvJwJ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=klR37Ek0iStjtGWLw9nJOY6CIF8MqqOa3xDFbJHiWjw=;
	b=btpazfqt4f3EF/zkS1tWHkPkdDVhJBvHrO7M8alZLmWEN0pvQeQyDbWcL8cz2xd017/h
	 u+Rzs5u0Bx6ct3Y9TWfVhLQISKYzFiAhGy7zVtZd1jJGG+RRjiHxpPC/7TeE4tPwXpB67
	 xRRJ8qIu3sy1XqpRmPZnUC0qrhClK2Vv3HyQMGfJnwU58P6YMYDxwoRQAaEv8/KApjduy
	 QgfSIzW97U0FtIQNjL/B7gAq+TgotUPia/ePVPk+aArnUzdvlLGW9EaySLsgTeu5QK0Pn
	 +XkcsbpVkOb1AOtaTsKLKXZdygwXDQ30ANqDA2QaqgWPO/5Owawmb+2r/HA/HfL+t6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvK+BiOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7A606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvK+BiOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD42B1F000C1;
	Wed,  4 Nov 2026 02:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759182;
	bh=klR37Ek0iStjtGWLw9nJOY6CIF8MqqOa3xDFbJHiWjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LvK+BiOkL6KkmkIE+L6viI+bIZLTH3JoEjEra8PUVeXPPAjOQmm7Ig3sl8Nv+/zag
	 m25I+gGtNHtBtamSCd8bRxQpsRC/Xhk6X9C8oO6k1xkDnRwUvy40JB5KL3Tx2xIjQV
	 6tJzekY7g6envxO8hHr6XRFYrFSad/h/GyDB/6Gni/Rt3M9wyxEY1SLa7PKky2ipPc
	 141y/i8l//rC45Q/4pX6RW3AJ2uYC6DcjPGQdh4eqeaR4Rd8uCmwr4B4E11pWJ6cD/
	 ZG0m2mxP9RV7y6EJYeVRWHbUB4Vt/gwcxa8GyfJ04cGCvu4JJplxqPQ4LFJcF/Re91
	 ZxfpOKjBtvNHw==
Message-ID: <sashiko-outbox-196460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: meson: unregister the UART driver if port
 registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261104021501.1468500-1-vulab@iscas.ac.cn>
References: <20261104021501.1468500-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:26:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> meson_uart_probe() registers the shared uart_driver on the first port and
> relies on meson_uart_remove() to unregister it once the last port is
> removed.  If uart_add_one_port() fails, probe returns an error, so remove
> is never called and the driver stays registered, leaking its tty driver
> and per-port state.
>=20
> Remember whether this probe registered the driver and unregister it again
> when adding the port fails.
>=20
> Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of t=
tyAML for new SoCs")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021501.1468=
500-1-vulab@iscas.ac.cn?part=3D1

