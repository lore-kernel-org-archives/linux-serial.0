Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFE51C058
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790199; cv=none; b=Bk9e7A1a5ToJUBQ62gTLgRCQTtSYN5a42hqUvXNW+YwaXPI+AFJqtv9NdoHy+XdAAy3TeYP+3VFOtBnR5Jsn1KDr8MmTz/z98RPqokvOW5pg1H1/pnE1k306psCQOVkhpTl4GsnrP/dfvnbH6TAt3oOlSI1C8VCkpjqtH+GOUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790199; c=relaxed/simple;
	bh=MqE8F4ZD98Ed5z0hfCgHwKG7gtkJBa9p5Fzo2vb5j6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQE1W5ZBW3ZAb0Sig/Jw30I5snNHcNITVRA7oVsLMhNATbtQgT2XFlIKR1EW+kvkTqR5dnkg8igcKc4sDri6Xs8kMM1b/75JgTeF/zKU4R9WRfo5jAo0gL6q1cyRWU5t7excElOMfURJXDLlRD1d7KdvSQ3xmg8iJUi1sd+HfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5ajoBBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5ajoBBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032AA1F00898;
	Wed, 30 Sep 2026 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790198;
	bh=feuNB3YZdj74MqqzGZYhEJYT6rtnP0FMpTSoCTqpKvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5ajoBBcyhUbMQKrrOZES1GnZr2pVM/GGDz9lQL0OuW1vMJO2cWaEpz3HaxBP66lX
	 GX/zc2poHwVM9d5QO/gdXyTg1YEQom4KjS+mB0P1cjUO814SE2mMLY3GGaTDCw+JCe
	 Ple0RcPVMsd2xIq3rw9gRlj+IdGW9ij1iBN9gMmwd8qJ3LPt9gBhAvCh98Or9Cxl12
	 tUB/05iY10s+HNHn1lZ1p8bCC81Mlsg2iyJBjY0LVilbpY8E8KHvEheXzrXSlxtuLb
	 r58VglJ5TRicE1KwXFIHY0HJvL/ktqr1fSoZEyXFGOBJz+BYus6Y3AglXLonet13iY
	 FQO3bowY5YYiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] tty: serdev: Export functions to pause
 receive_buf callback calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-serial@vger.kernel.org
In-Reply-To: <20260930-rust_serdev_probe_refactor-v3-2-d1b6e77135e0@posteo.de>
References: <20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
 <20260930-rust_serdev_probe_refactor-v3-2-d1b6e77135e0@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:43:17 +0000
Message-Id: <20260930174318.032AA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: serdev: AB-BA deadlock between ttyport_pause_rx() and ttyport=
_receive_buf()
- [High] tty: serdev: Self-deadlock calling pause_rx or resume_rx from rece=
ive_buf
- [High] tty: serdev: TOCTOU race leading to NULL pointer dereference in tt=
yport_close/pause/resume
--

commit f462dbe8ac06c8a92e0fb79ce15c1e6444a27110
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Export functions to pause receive_buf callback calls

These functions will be used to simply the serdev rust abstraction. It
also contributes to the fixing of 2 race conditions in the serdev rust
abstraction.

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index c11908f5e1ce3..2bed0e54202a8 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c

[ ... ]

> @@ -35,6 +37,9 @@ static size_t ttyport_receive_buf(struct tty_port *port=
, const u8 *cp,
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
> =20
> +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> +		return 0;
> +
>  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);

[Severity: High]
Can this cause a self-deadlock if the driver attempts to pause or resume
reception during data reception?

If the downstream driver's receive callback calls serdev_device_pause_rx()
or serdev_device_resume_rx(), they will attempt to acquire the non-recursive
serport->lock which is already held by ttyport_receive_buf().

[ ... ]

> @@ -177,6 +182,32 @@ static bool ttyport_close(struct serdev_controller *=
ctrl)
>  	return true;
>  }
> =20
> +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;

[Severity: High]
Is it possible for this unprotected read of serport->tty to introduce a TOC=
TOU
race leading to a NULL pointer dereference?

If ttyport_pause_rx() races with ttyport_open(), the local tty pointer could
be captured as NULL before acquiring the lock. After acquiring the lock, the
code might observe SERPORT_ACTIVE as true (set by the concurrent open) and
proceed to dereference the stale, NULL tty pointer.

(Note: ttyport_close() also appears to have this pre-existing issue).

> +
> +	guard(mutex)(&serport->lock);
> +
> +	set_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_buffer_flush_work(tty->port);

[Severity: High]
Could this tty_buffer_flush_work() cause an AB-BA deadlock with
ttyport_receive_buf()?

ttyport_pause_rx() acquires serport->lock and then calls
tty_buffer_flush_work(), which blocks waiting for the currently executing w=
ork
to finish. If the current work is flush_to_ldisc(), it calls
ttyport_receive_buf(), which attempts to acquire serport->lock, resulting in
a deadlock.

> +}
> +
> +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;

[Severity: High]
Can this also cause a NULL pointer dereference if it races with ttyport_ope=
n()
and captures a NULL tty pointer before acquiring the lock?

> +
> +	guard(mutex)(&serport->lock);
> +
> +	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_buffer_restart_work(tty->port);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_serde=
v_probe_refactor-v3-0-d1b6e77135e0@posteo.de?part=3D2
