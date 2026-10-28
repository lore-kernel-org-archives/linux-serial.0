Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193993;
	b=YqBxAGhIZhJheb3pllk6/GDk9S6aasQ38YJdunWX9ArRqacJjcj+6Y2fmT0bA4eEy79V
	 M5mOW7ReKWwv4cEZGs5cP5mO8562esxBvC5N2a3L+2OqMPb4BI0cfdndwIPNlkl6cxi12
	 YBu9tam6DBwadUsyHoSXnO7aKsaR+q7X+pweSsb9zJpb1yAwlfm29RfMcUdWs7uxxpo96
	 u9ovWzHA48AsDsFrNwv/LauslDfiubYgVV6CuaA1iauOpOAkKiKROUec1kgisWID2z65S
	 vz34fWryivgM5/LJ2lBoniCjgKcxGdd2WFPOvEF3ebX8jxZxYi67NemX/y8jPbIwBTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/Abi2u37G8TEmhd6+WDTiY9N4U1qhPNiLyOcBhaYFhA=;
	b=CJ1Cfqcx+/1mhg4+mFoXrSLNCSFns6EcHDCDfRGMPy2XfUdMR6TnXcyJI8H/w8dDz5ie
	 Tyyf4/vSPKNWNy5iWdVkoNW/SdBLlWXPXU3ShdYc7AxU+o7ITqGdSSqyK3DwXC5FxfxD1
	 wFpDfKgWpujWSfNh3MOz62Q0fRQP583+heTXr88wVzMDG1AIwgeiyn+PmYI4BGGP2KvKj
	 fpRu4TihUQB71SfdBvzgZ91PV0j2O3NVykuWAXldxn6KWBQf7nH9s2b+ztBCbfYQh+wFo
	 6dNC9IorFCOMUUenn46cxvIOHiV8H9WLwGI3skC+MFqHcXRyzI0YUitx+lyrzjtqfJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otc99l1V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE5606A329
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otc99l1V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D835C1F01825;
	Wed, 28 Oct 2026 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193992;
	bh=/Abi2u37G8TEmhd6+WDTiY9N4U1qhPNiLyOcBhaYFhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=otc99l1V5REQljo1ep/pw6H9HY5CE+JEW2DIzXnHeG9AUnrUY4sdS7vwq/yZ7dLH+
	 2OoA7bT3zOLOrwa/MPGnyHKG7j5IeSg+DuNQuVwSX+Jadkw1WpmMtkl3aQo3XE3upj
	 33M7popBG1sqTjFm836jzm7AYB6HI+8hUuzjWeTPXUHIF81153qZZlPwR3OSFIRi6D
	 mcqo4D/jgQgPYUWxJSgNOhv9dKWUnAtDZKd23devSo0WGrhTErg5L85pubm0Udy+R0
	 jDABIAysUCL7nJYNhCcsqIIkGLM/zWTfAGK+jVgOmmThJKJomuzANaUXJYDEna36R/
	 2UlIZZEIMiUpw==
Message-ID: <sashiko-outbox-187911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] tty: n_hdlc: fix read() hangup check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261028132049.728457-4-johan@kernel.org>
References: <20261028132049.728457-1-johan@kernel.org>
 <20261028132049.728457-4-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:26:31 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> When a tty is hung up, the file ops are generally set to
> hung_up_tty_fops, but this is not the case for, for example,
> /dev/console.
>=20
> Make sure to check the TTY_HUPPING flag so that a hangup is detected and
> read() returns zero also with /dev/console (as is done for n_tty [1]).
>=20
> Note that before commit c96cf923a98d ("tty: Don't block on IO when ldisc
> change is pending") a task hanging up the tty would get stuck in
> uninterruptible sleep when there are blocked readers, but since then
> read() incorrectly returns -EAGAIN instead.
>=20
> The false-positive stuck hangup issue was flagged by an LLM.
>=20
> [1] 28b0f8a6962a ("tty: make n_tty_read() always abort if hangup is in pr=
ogress")
>=20
> Fixes: 1035b63d3c6f ("n_hdlc: fix read and write locking")
> Cc: stable@vger.kernel.org	# 2.6.38
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028132049.7284=
57-1-johan@kernel.org?part=3D3

