Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A078202F71
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410408; cv=none; b=UBu9Nq9liybRyJLbu4WHIzFCLjSNE9aqcUEdNUo68KFKsDYBAKqsiuzcVKAVFK6O0KqDO0YnjbVUU+PqVqRqO1dfZyWbK4khppwugMGzEglEG1baA1oNk12H9jCvvmPcE1fgqWECLRCq8lV9hGXZTsdtVV45OWu+1C1zOFtdDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410408; c=relaxed/simple;
	bh=KClHrlr2oo+V6uSmTtOZ+z0KU8xvouf5EFUYX6DelSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pt/KO08vSM5gqlUe6q/6RGsL3CUde2+ZKFFD4noIlo+O/Dmh3veEJcxLbMUHnU5G10TB6rl1RLJ/lwye7KTxJ4dqnhrECxL3ZNnuZJoboZDxZzPqRg7xsWzqmdefm4hb7mNyyH9wCLDl5F2Fi4ExVdCcwqbKvuj2a0l/rKYOHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBgXw7lG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBgXw7lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1166A1F000E9;
	Thu,  3 Sep 2026 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788410407;
	bh=VS5tMc5yekpHpX+JE+4Qdb1mgtUiFH7DtNn3KIJAW3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBgXw7lGQIml5a/M7Tifwn/53ZgzCJSB7BoPW2DLRjH4+rUBWPwTeJUvrQ+aeUU2t
	 JNJc8pCM8tvMM6YOm9A+bEI7viANKwvBfq6i5M5Lj1+UMxWqnxqclPZu5DTydtNpRI
	 D1r1QuP9+JQy/azjYfnstPiev6XE/r++MtC/QVquXDYzbgZXoOEvmuCTrqxWZd6IVn
	 qnkJLv7Kdhuf67o+LDC1sfQP6TKvaw+PVbztbWhkJGzSUOBq5nCL3qJ2IWDgqLTDhB
	 TXJ3lPJugAh+XAmBUNKoPkCdVxyoBwT1PyCy1qhCJrVab9Hy8N712MPTV/by95FjfB
	 bs37ihMZEj2Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tty: fix break race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adriano Cordova" <adrianox@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260903042429.130320-3-adrianox@gmail.com>
References: <20260903042429.130320-1-adrianox@gmail.com>
 <20260903042429.130320-3-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:40:06 +0000
Message-Id: <20260903044007.1166A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The lockless checks of `tty_hung_up_p(file)` introduce a Time-of-C=
heck to Time-of-Use (TOCTOU) race against `__tty_hangup`, failing to fully =
resolve the Use-After-Free/NULL pointer dereference.
--

commit 8d56321f205bd51f6c216651862e6a270f2637ea
Author: Adriano Cordova <adrianox@gmail.com>

tty: fix break race

This commit attempts to fix a race condition where a timed break can call
break_ctl() on a tty whose driver data is gone, causing a use-after-free
or NULL-pointer dereference. It adds checks for the tty hung-up state
before each break_ctl() call.

Link: https://syzkaller.appspot.com/bug?extid=3D473d7477c523b41d4046

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 48569035da56e..272f2839acdba 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
[ ... ]
> @@ -2438,13 +2439,16 @@ static int tiocgetd(struct tty_struct *tty, int _=
_user *p)
>   * Locking:
>   *	@tty->atomic_write_lock serializes
>   */
> -static int send_break(struct tty_struct *tty, unsigned int duration)
> +static int send_break(struct file *file, struct tty_struct *tty, unsigne=
d int duration)
>  {
>  	int retval;
> =20
>  	if (tty->ops->break_ctl =3D=3D NULL)
>  		return 0;
> =20
> +	if (tty_hung_up_p(file))
> +		return -EIO;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless check ful=
ly
resolve the Time-of-Check to Time-of-Use (TOCTOU) race? If a concurrent thr=
ead
executes __tty_hangup() immediately after tty_hung_up_p() evaluates to fals=
e,
could __tty_hangup() tear down the driver data before tty->ops->break_ctl()
is executed on the hardware break path, leading to a use-after-free?

>  	if (tty->driver->flags & TTY_DRIVER_HARDWARE_BREAK)
>  		return tty->ops->break_ctl(tty, duration);
> =20
> @@ -2455,7 +2459,10 @@ static int send_break(struct tty_struct *tty, unsi=
gned int duration)
>  	retval =3D tty->ops->break_ctl(tty, -1);
>  	if (!retval) {
>  		msleep_interruptible(duration);
> -		retval =3D tty->ops->break_ctl(tty, 0);
> +		if (tty_hung_up_p(file))
> +			retval =3D -EIO;
> +		else
> +			retval =3D tty->ops->break_ctl(tty, 0);

[Severity: High]
This is a pre-existing issue, but does checking tty_hung_up_p() here under
atomic_write_lock provide mutual exclusion against __tty_hangup()? Could a
concurrent hangup occur right after this check, causing the subsequent call
to tty->ops->break_ctl() to dereference freed driver data?

>  	} else if (retval =3D=3D -EOPNOTSUPP) {
>  		/* some drivers can tell only dynamically */
>  		retval =3D 0;
[ ... ]
> @@ -2714,10 +2721,14 @@ long tty_ioctl(struct file *file, unsigned int cm=
d, unsigned long arg)
>  	 * Break handling
>  	 */
>  	case TIOCSBRK:	/* Turn break on, unconditionally */
> +		if (tty_hung_up_p(file))
> +			return -EIO;
>  		if (tty->ops->break_ctl)
>  			return tty->ops->break_ctl(tty, -1);

[Severity: High]
This isn't a bug introduced by this patch, but do these unconditional break
paths suffer from the same TOCTOU race? Since they do not hold tty_lock,
could a concurrent __tty_hangup() free the driver data between the
tty_hung_up_p() check and the break_ctl() call?

>  		return 0;
>  	case TIOCCBRK:	/* Turn break off, unconditionally */
> +		if (tty_hung_up_p(file))
> +			return -EIO;
>  		if (tty->ops->break_ctl)
>  			return tty->ops->break_ctl(tty, 0);

[Severity: High]
This is a pre-existing issue, but similar to TIOCSBRK, is this unprotected
check before unconditional break off vulnerable to a concurrent hangup?

>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903042429.1303=
20-1-adrianox@gmail.com?part=3D2
