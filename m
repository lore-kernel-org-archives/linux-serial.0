Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFA5AA67B
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174441; cv=none; b=JDkAW4gI5fB/NzsIqMHmlNhG+Gp9F4WrPxgnNNi1l3W/Ao5yJCOgWnkBN+AtxLfNHMADP86yzoZzJBW2jED8uRWZ60DJICo+fo+h+bA98/8OEWddNbGBqaedxhtzGx6ojpDMBFSqYwZQGWFgjnnapNdFxIR9Tkgdp07o7G1vLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174441; c=relaxed/simple;
	bh=l3z5xgBQjnJHZ4AuzWiC3zymDkU/3gUBip7G+wWzOx8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R58cjN0s8S+A+YUOgqdtH2EpUOqb2z2UazK+9TYLd3JysEe/CDYJnevTjUeRT6XeMQ0P8rNKCHnCebJ4WDFw+orS7t46pV3yLSzfzRN2rLvzyCIuFdsNSK+N/5rc7Y/xyUU004ezfB1AlC5S6ScxsDmUUA5XzVsnQ3Qx8E/6ClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGNoQYvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGNoQYvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9FE1F000C5;
	Fri, 16 Oct 2026 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174440;
	bh=wyp2HyC6J294FpYk1t8TN987FES01tfLOAm10FWYShE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGNoQYvqzBGnTdfdXIoimEQmBaXD5SMlg//hr3Fek1s2q+8gY+Q590PqvpGQdaG22
	 Os/G6MIk7uln2J2OrLE+IsLx/PXfTEnsJ4SWkbVNwwESmb37uPH3I36XnlGlt+WDKb
	 oY9bpeKVwHzzJoiSpbdU02xn8ETpSoUuc9R8FpoeRxaoS6xNI3cViho82e1Tbe1GlU
	 poSZM6i0CbD0DVickuaFUSEokpsopsnNGu61SNaE5/pOUlFKTSm5DQxCeYqr0Fg2cA
	 9OQK3gewvbZd66h0hRc582JXd2AQM1umVN8G4UU3IJJXKOszbHS00G7vSOQMXqDgqP
	 GgDJ5psjfoIQw==
Message-ID: <sashiko-outbox-174756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] tty: serdev: Export functions to pause
 receive_buf callback calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261016-rust_serdev_probe_refactor-v4-2-46832e034757@posteo.de>
References: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
 <20261016-rust_serdev_probe_refactor-v4-2-46832e034757@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:13:59 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: NULL pointer dereference / UAF in ttyport_pause_rx and ttypor=
t_resume_rx due to TOCTOU
--

commit 7862c81055f41fa0e8cc37f91200a9bcccf35960
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Export functions to pause receive_buf callback calls

These functions will be used to simply the serdev rust abstraction. It
also contributes to the fixing of 2 race conditions in the serdev rust
abstraction.

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index 125a17a0bea50..e164ee7edc121 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c

[ ... ]

> @@ -185,6 +190,37 @@ static bool ttyport_close(struct serdev_controller *=
ctrl)
>  	return true;
>  }
> =20
> +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;
> +
> +	guard(mutex)(&serport->lock);

[Severity: High]
Does this code have a race condition since the local pointer tty is assigned
from serport->tty before the serport->lock is acquired?

This lock protects the lifecycle of the tty structure and the SERPORT_ACTIVE
flag, which are modified concurrently by ttyport_open() and ttyport_close().

If a concurrent thread calls ttyport_open() or if the port transitions stat=
es
asynchronously, it will allocate a new tty_struct, set serport->tty, and set
SERPORT_ACTIVE to true.

> +
> +	scoped_guard(mutex, &serport->receive_lock)
> +		set_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_buffer_cancel_work(tty->port);

Because tty was captured outside the lock, could it remain NULL if previous=
ly
closed or point to a freed structure?

If the ttyport_pause_rx() thread then acquires the lock and sees that
SERPORT_ACTIVE is true, will this result in an immediate NULL pointer
dereference or use-after-free when accessing tty->port?

Should the assignment of the tty pointer be moved inside the critical secti=
on?

> +}
> +
> +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;
> +
> +	guard(mutex)(&serport->lock);

[Severity: High]
Does the identical vulnerability exist in the resume path where tty is
captured outside the lock?

> +
> +	if (!test_bit(SERPORT_PAUSE_RX, &serport->flags))
> +		return;
> +
> +	scoped_guard(mutex, &serport->receive_lock)
> +		clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_buffer_restart_work(tty->port);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_serde=
v_probe_refactor-v4-0-46832e034757@posteo.de?part=3D2
