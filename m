Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1EC4F055E
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454206; cv=none; b=Zh1EV0OUeCJKZls2qIkMH8aFk8WUPI6SOOTK4d89qdekF89biJi8YMJqfeCQQYHnHGsuouS6klMdPxLnGo2JlB2KmMYUVM4oFLyv7bEP/y8kOeEPGnrSbjxRIS/Rou8UXaMpzPf+sZfnQkn1L0zg5ZHBGA5N90HvQMkCnwI1gIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454206; c=relaxed/simple;
	bh=HS7whUT2BZfqVyjjlyufU3vAHiJTZMAngXCeB2IZDfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d4geL9zjftLkhtf5B7UcVCcoWwxnOxkUsRqq11DzJG9u/mXw/dqGDhEl4aiB2X+18e35XDMKXmmrrNr+AXBdi2QzbVQqjn2Jvs24oGfxBFkukaWMMcRLgXLsuyOsKnJPxVg/pTRNpxAddCLA7kKd+c8FFEbhxLWacivdVWjspO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFByN9tT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFByN9tT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89561F000E9;
	Thu,  3 Sep 2026 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454204;
	bh=XosvqnlxR6shybG1264GDBRpLOrtheJA5qk1SY8C2vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFByN9tTerfk2sn0xbEXDyuqYrVGWis98ssvZoLinItW6keXoeOJejQjfgG2duSJx
	 w5XnRTuhiYHWrVq1ERgwVUMzy5zTEuYmTRsDdmvHz38tVAywSxUOfgvMRPD9W6VAUW
	 PpVVoSVSFBEEn/eKr6ghgjJweGzDZCkTLBt/84MP0F4xhg4rbtF9K1Hw4Md8Fs2zSS
	 55apFt5rVuo/9Nh70mnLDQh7oezw3imgMwUPzGuPjoOSbSasXthYTtm6Lju2bEkVKs
	 q/osSZ4/YEKE0iJh7qWfT+lI4q/wYssRzuHm3DM2Uk/I9xBG0mkwkNGQ+voxzqwBov
	 T5yLS3TnL+Pmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: abort break signalling on hangup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260903163736.1499280-1-johan@kernel.org>
References: <20260903163736.1499280-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 16:50:04 +0000
Message-Id: <20260903165004.B89561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing hangup check before initiating the break state leaves the =
tty in a permanent break state if the port is already hung up.
--

commit fb29de6b768e6b046a458b30129e8f3ab80e0b86
Author: Johan Hovold <johan@kernel.org>

tty: abort break signalling on hangup

This commit aborts TCSBRK and TCSBRKP break signalling on hangup by waking
up pending break ioctls and returning early. This prevents calling back into
the driver after a user-controlled timeout for a disconnected device.

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 48569035da56e..1c30faae9ec13 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
[ ... ]
> @@ -2453,13 +2457,26 @@ static int send_break(struct tty_struct *tty, uns=
igned int duration)
>  		return -EINTR;
> =20
>  	retval =3D tty->ops->break_ctl(tty, -1);
> -	if (!retval) {
> -		msleep_interruptible(duration);
> -		retval =3D tty->ops->break_ctl(tty, 0);
> -	} else if (retval =3D=3D -EOPNOTSUPP) {
> -		/* some drivers can tell only dynamically */
> -		retval =3D 0;
> +	if (retval) {
> +		if (retval =3D=3D -EOPNOTSUPP) {
> +			/* some drivers can tell only dynamically */
> +			retval =3D 0;
> +		}
> +		goto out_unlock;
> +	}
> +
> +	timeout =3D msecs_to_jiffies(duration);
> +	timeout =3D wait_event_interruptible_timeout(tty->break_wait,
> +						   tty_hung_up_p(file),
> +						   timeout);
> +	/* return early on hangup only */
> +	if (timeout > 0) {
> +		retval =3D -EIO;
> +		goto out_unlock;
>  	}

[Severity: High]
Does this leave the tty in a permanent break state if the port was already
hung up before calling send_break()?

If a thread is sleeping in tty_wait_until_sent() during an ioctl(TCSBRK)
and a hangup occurs, __tty_hangup() marks the file as hung up and wakes
the thread. The thread then proceeds to send_break(), unconditionally
asserting the break state via:

    retval =3D tty->ops->break_ctl(tty, -1);

Since the port is already hung up, the wait_event_interruptible_timeout()
condition tty_hung_up_p(file) evaluates to true immediately, returning the
initial timeout which is > 0.

Taking this early return path skips the cleanup call to
tty->ops->break_ctl(tty, 0), which can force the hardware TX line into a
continuous break state and corrupt outgoing data for any subsequent user.

> +
> +	retval =3D tty->ops->break_ctl(tty, 0);
> +out_unlock:
>  	tty_write_unlock(tty);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903163736.1499=
280-1-johan@kernel.org?part=3D1
